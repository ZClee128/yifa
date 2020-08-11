//
//  EFOrderDetailViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/23.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOrderDetailViewController.h"
#import "EFOrderTitleTableViewCell.h"
#import "EFOrderGoodsTableViewCell.h"
#import "EFOrderPriceTableViewCell.h"
#import "EFOrderBtnTableViewCell.h"
#import "EFLogisticsViewController.h"
#import "EFOrderMoreDetailViewController.h"
#import "EFToPayDetailViewController.h"
#import "EFOrderVM.h"

@interface EFOrderDetailViewController ()

@property (nonatomic,assign)OrderType type;

@end

@implementation EFOrderDetailViewController

- (instancetype)initWithType:(OrderType)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}


- (void)viewDidLoad {
    self.viewModel = [[EFOrderVM alloc] init];
    [super viewDidLoad];
    ((EFOrderVM *)self.viewModel).type = self.type;
    self.gk_navigationBar.hidden = YES;
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT- 45);
    self.gk_navLineHidden = YES;
    
    [self.EFTableView registerClass:[EFOrderTitleTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFOrderTitleTableViewCell class])];
    [self.EFTableView registerClass:[EFOrderGoodsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFOrderGoodsTableViewCell class])];
    [self.EFTableView registerClass:[EFOrderPriceTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFOrderPriceTableViewCell class])];
    [self.EFTableView registerClass:[EFOrderBtnTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFOrderBtnTableViewCell class])];
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, 70)];
    self.EFTableView.tableFooterView = foot;
    [self addRefshUp];
    [self addRefshDown];
    [self loadList];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kOrderSearch object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSDictionary *dict = x.object;
        ((EFOrderVM *)self.viewModel).searchText = dict[@"text"];
        [[((EFOrderVM *)self.viewModel) searchRefreshForDown] subscribeNext:^(RACTuple *x) {
            self.EFData = x.first;
            [self.EFTableView reloadData];
        }];
    }];
    
}

- (void)loadList {
    @weakify(self);
    [[self.viewModel refreshForDown] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        [self.EFTableView.mj_header endRefreshing];
        self.EFData = x.first;
        [self.EFTableView reloadData];
    }];
}

- (void)loadNewData {
    [self loadList];
}

- (void)loadMoreData {
    @weakify(self);
    [[self.viewModel refreshForUp] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        [self.EFTableView.mj_footer endRefreshing];
        self.EFData = x.first;
        [self.EFTableView reloadData];
    }];
}

- (UIView *)listView {
    return self.view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.EFData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    EFOrderModel *model = self.EFData[section];
    return  model.goodsList.count + 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFOrderModel *model = self.EFData[indexPath.section];
    if (indexPath.row == 0) {
        EFOrderTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderTitleTableViewCell class])];
        [cell setModel:model];
        return cell;
    }else if (indexPath.row == model.goodsList.count + 1) {
        EFOrderPriceTableViewCell *priceCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderPriceTableViewCell class])];
        [priceCell setModel:model];
        return priceCell;
    }else if (indexPath.row == model.goodsList.count + 2) {
        EFOrderBtnTableViewCell *btnCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderBtnTableViewCell class])];
        [btnCell setModel:model];
        @weakify(self);
        
        btnCell.moreClick = ^(QMUIButton * _Nonnull x) {
            [FTPopOverMenu showFromSenderFrame:[x convertRect:x.bounds toView:nil] withMenu:@[@"退货退款"] imageNameArray:@[@""] doneBlock:^(NSInteger selectedIndex) {
                
            } dismissBlock:^{
                
            }];
        };
        btnCell.oneClick = ^{
            @strongify(self);
            switch (model.orderState) {
                case 300:
                {
                    EFLogisticsViewController *vc = [[EFLogisticsViewController alloc] initWithExpressNum:model];
                    [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                        
                    }];
                }
                    break;
                default:
                    break;
            }
        };
        
        btnCell.twoClick = ^{
            @strongify(self);
            switch (model.orderState) {
                case 300:
                {
                    [[XQCAlertTool showAlertTitle:@"" message:@"是否确认收货" cancle:@"取消" sure:@"确认"] subscribeNext:^(id  _Nullable x) {
                        [[EFOrderVM confirmReceiptExpressNum:model.expressNum orderNum:model.orderNum] subscribeNext:^(NSNumber *x) {
                            if ([x boolValue]) {
                                [self loadList];
                            }
                        }];
                    } error:^(NSError * _Nullable error) {
                        
                    }];
                }
                    break;
                    case 400:
                {
                    [kH5Manager gotoUrl:@"evalWriting" hasNav:NO navTitle:@"" query:@{@"expressNum":model.expressNum,@"orderNum":model.orderNum}];
                    break;
                }
                default:
                    break;
            }
        };
        
        btnCell.threeClick = ^{
            @strongify(self);
            switch (model.orderState) {
                case 100:
                {
                    EFToPayDetailViewController *vc = [[EFToPayDetailViewController alloc] init];
                    vc.model = model;
                    [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                        
                    }];
                }
                    break;
                case 200:
                {
                    [[EFOrderVM urgedDeliveryOrderNum:model.orderNum] subscribeNext:^(NSNumber *x) {
                        if ([x boolValue]) {
                            [MBProgressHUD showSuccess:@"催促成功"];
                        }
                    }];
                    break;
                }
                case 300:
                {
                    [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{}];
                    break;
                }
                case 400:
                {
                    [kH5Manager gotoUrl:@"returnApply" hasNav:NO navTitle:@"" query:@{}];
                    break;
                }
                case 600:
                {
                    [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{}];
                    break;
                }
                case 800:
                {
                    [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{}];
                    break;
                }
                default:
                {
                    
                }
                    break;
            }
        };
        return btnCell;
    }else {
        EFOrderGoodsTableViewCell *goodCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderGoodsTableViewCell class])];
        [goodCell setModel:model.goodsList[indexPath.row - 1]];
        return goodCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFOrderModel *model = self.EFData[indexPath.section];
    if (indexPath.row == 0) {
        return WidthOfScale(61);
    }else if (indexPath.row == model.goodsList.count + 1) {
        return WidthOfScale(45.5);
    }else if (indexPath.row == model.goodsList.count + 2) {
        return WidthOfScale(70);
    }else {
        return WidthOfScale(130);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EFOrderModel *model = self.EFData[indexPath.section];
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == model.goodsList.count + 1) {
        
    }else if (indexPath.row == model.goodsList.count + 2) {
        
    }else {
        switch (model.orderState) {
            case 100:
            {
                EFToPayDetailViewController *vc = [[EFToPayDetailViewController alloc] init];
                vc.model = model;
                [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                    
                }];
            }
                break;
            default:
            {
                EFOrderMoreDetailViewController *vc = [[EFOrderMoreDetailViewController alloc] init];
                vc.model = model;
                [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                    
                }];
            }
                break;
        }
    }
    
}

@end
