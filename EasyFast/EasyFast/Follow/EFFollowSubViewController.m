//
//  EFFollowSubViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFollowSubViewController.h"
#import "EFFollowTableViewCell.h"
#import "EFFollowTuanTableViewCell.h"
#import "EFFollowVM.h"
@interface EFFollowSubViewController ()

@property (nonatomic,assign)Follow type;
@property (nonatomic,strong)EFFollowVM *followVM;

@end

@implementation EFFollowSubViewController

- (instancetype)initWithType:(Follow)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    self.viewModel = [[EFFollowVM alloc] init];
    self.viewModel.branches = @(10);
    [super viewDidLoad];
    self.followVM = (EFFollowVM *)self.viewModel;
    self.gk_navigationBar.hidden = YES;
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-45-TAB_BAR_HEIGHT);
    self.gk_navLineHidden = YES;
    
    [self.EFTableView registerClass:[EFFollowTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFFollowTableViewCell class])];
    [self.EFTableView registerClass:[EFFollowTuanTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFFollowTuanTableViewCell class])];
    self.EFTableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[EFFollowTableViewCell class] cellHeight:WidthOfScale(243)];
    self.EFTableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[EFFollowTuanTableViewCell class] cellHeight:WidthOfScale(327)];
    [self addRefshDown];
    [self addRefshUp];
    switch (self.type) {
        case FollowGZ:
        {
            [self FollowLoad];
            break;
        }
        case FollowGM:
        {
            [self payload];
            break;
        }
        default:
            [self teamload];
            break;
    }
}

- (void)FollowLoad {
    [self.EFTableView tab_startAnimationWithCompletion:^{
        [[self.viewModel refreshForDown] subscribeNext:^(RACTuple *x) {
            [self.EFTableView.mj_header endRefreshing];
            [self.EFTableView tab_endAnimation];
            self.EFData = x.first;
            [self.EFTableView reloadData];
        }];
    }];
}

- (void)payload{
    [self.EFTableView tab_startAnimationWithCompletion:^{
        [[self.followVM TransactionRefreshForeDown] subscribeNext:^(RACTuple *x) {
            [self.EFTableView.mj_header endRefreshing];
            [self.EFTableView tab_endAnimation];
            self.EFData = x.first;
            [self.EFTableView reloadData];
        }];
    }];
}

- (void)teamload {
    [self.EFTableView tab_startAnimationWithCompletion:^{
        [[self.followVM TeamRefreshForeDown] subscribeNext:^(RACTuple *x) {
            [self.EFTableView.mj_header endRefreshing];
            [self.EFTableView tab_endAnimation];
            self.EFData = x.first;
            [self.EFTableView reloadData];
        }];
    }];
}

- (void)loadNewData {
    switch (self.type) {
        case FollowGZ:
        {
            [self FollowLoad];
            break;
        }
        case FollowGM:
        {
            [self payload];
            break;
        }
        default:
            [self teamload];
            break;
    }
}

- (void)loadMoreData {
    switch (self.type) {
        case FollowGZ:
        {
            [[self.viewModel refreshForUp] subscribeNext:^(RACTuple *x) {
                [self.EFTableView.mj_footer endRefreshing];
//                if ([x.second count] == 0) {
//                    [self.EFTableView.mj_footer endRefreshingWithNoMoreData];
//                }else {
//                    [self.EFTableView.mj_footer resetNoMoreData];
//                }
                self.EFData = x.first;
                [self.EFTableView reloadData];
            }];
            break;
        }
        case FollowGM:
        {
            [[self.followVM TransactionRefreshForeUp] subscribeNext:^(RACTuple *x) {
                [self.EFTableView.mj_footer endRefreshing];
                //                [self.EFData appendObjects:x.first];
                self.EFData = x.first;
                [self.EFTableView reloadData];
            }];
            break;
        }
        default:
            break;
    }
}

- (UIView *)listView {
    return self.view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.EFData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFFollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFFollowTableViewCell class])];
    EFFollowModel *model = self.EFData[indexPath.section];
    cell.selectIndex = ^(EFGoodsList *model) {
        [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(NO),@"ggNO":model.ggNo}];
    };
    cell.headerSelect = ^{
        [kH5Manager gotoUrl:@"shop" hasNav:NO navTitle:@"" query:@{}];
    };
    [cell setModel:model];
    cell.follow = ^(QMUIButton * _Nonnull sender) {
        if (sender.selected) {
            [[EFFollowVM cancelFollowShop:model.shopNo] subscribeNext:^(NSNumber *ok) {
                if ([ok boolValue]) {
                    model.isFollow = NO;
                    sender.selected = !sender.selected;
                }
            }];
        }else {
            [[EFFollowVM setFollowShopCategory:@"" shopNo:model.shopNo] subscribeNext:^(NSNumber *ok) {
                if ([ok boolValue]) {
                    model.isFollow = YES;
                    sender.selected = !sender.selected;
                }
            }];
        }
    };
    switch (self.type) {
        case FollowGZ:
        {
            return cell;
        }
        case FollowGM:
        {
            return cell;
        }
        default:
        {
            EFFollowTuanTableViewCell *tuanCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFFollowTuanTableViewCell class])];
            [tuanCell setModel:model];
            tuanCell.headerSelect = ^{
                [kH5Manager gotoUrl:@"shop" hasNav:NO navTitle:@"" query:@{}];
            };
            tuanCell.pintuanBlock = ^{
                [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(YES),@"ggNo":model.team.ggNo}];
            };
            tuanCell.selectIndex = ^(EFGoodsList *model) {
                [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(NO),@"ggNo":model.ggNo}];
            };
            tuanCell.follow = ^(QMUIButton * _Nonnull sender) {
                if (sender.selected) {
                    [[EFFollowVM cancelFollowShop:model.shopNo] subscribeNext:^(NSNumber *ok) {
                        if ([ok boolValue]) {
                            model.isFollow = NO;
                            sender.selected = !sender.selected;
                        }
                    }];
                }else {
                    [[EFFollowVM setFollowShopCategory:@"" shopNo:model.shopNo] subscribeNext:^(NSNumber *ok) {
                        if ([ok boolValue]) {
                            model.isFollow = YES;
                            sender.selected = !sender.selected;
                        }
                    }];
                }
            };
            return tuanCell;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.type) {
        case FollowTuan:
            return WidthOfScale(327);
        default:
            return WidthOfScale(243);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return WidthOfScale(10);
}
@end
