//
//  MeViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/9.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFMeViewController.h"
#import "MeHeaderView.h"
#import "MeTabTableViewCell.h"
#import "MeListTableViewCell.h"
#import "MeWebTableViewCell.h"
#import "EFAddressViewController.h"
#import "EFSetUpViewController.h"
#import "EFBindPhoneViewController.h"
#import "EFEditPasswordViewController.h"
#import "EFMeDataViewController.h"
#import "EFOrderViewController.h"
#import "EFHelpViewController.h"
#import "EFIMListViewController.h"
#import "EFSafeAccountViewController.h"
#import "EFFootprintViewController.h"

@interface EFMeViewController ()

@property (nonatomic,strong)MeHeaderView *headerView;
@property (nonatomic,strong)NSArray *list;
@property (nonatomic,assign)CGFloat cellHeight;

@end

@implementation EFMeViewController

-(MeHeaderView *)headerView
{
    if (_headerView == nil) {
        @weakify(self);
        _headerView = [[MeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(236.5)) headerBlcok:^{
            @strongify(self);
            EFMeDataViewController *vc = [[EFMeDataViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                
            }];
        } setUpBlock:^{
            @strongify(self);
            EFSetUpViewController *vc = [[EFSetUpViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                
            }];
        } becomeBlock:^{
            @strongify(self);
            EFBindPhoneViewController *vc = [[EFBindPhoneViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                
            }];
        } messageBlock:^(NSInteger index) {
            @strongify(self);
            switch (index) {
                case 0:
                {
                    self.navigationController.tabBarController.selectedIndex = 2;
                    [[NSNotificationCenter defaultCenter] postNotificationName:kTabFollow object:nil];
                }
                    break;
                    case 1:
                {
                    EFFootprintViewController *foot = [[EFFootprintViewController alloc] init];
                    foot.hidesBottomBarWhenPushed = YES;
                    [self.navigationController qmui_pushViewController:foot animated:YES completion:^{
                    
                    }];
                    break;
                }
                default:
                {
                    EFIMListViewController *vc = [[EFIMListViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                        
                    }];
                }
                    break;
            }
        } vipBlock:^{
            
        }];
    }
    return _headerView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT - TAB_BAR_HEIGHT);
    self.gk_navTitle = @"昵称";
    self.gk_navigationBar.alpha = 0;
    self.EFTableView.tableHeaderView = self.headerView;
    [self.EFTableView registerClass:[MeTabTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MeTabTableViewCell class])];
    [self.EFTableView registerClass:[MeListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MeListTableViewCell class])];
    [self.EFTableView registerClass:[MeWebTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MeWebTableViewCell class])];
    self.list = @[/*@{@"title":@"我的支付",@"icon":@"pay"},*/@{@"title":@"收货地址管理",@"icon":@"address"},
    @{@"title":@"账号安全",@"icon":@"safe"},@{@"title":@"帮助中心",@"icon":@"help"}];
    [self addWhiteRefshDown];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:UIImageMake(@"bg")];
    [self.view insertSubview:bgImageView belowSubview:self.EFTableView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(kPHONE_WIDTH));
        make.height.equalTo(@(kPHONE_HEIGHT/2));
    }];
    self.EFTableView.backgroundColor = [UIColor clearColor];
  
}


- (void)loadNewData {
    [self.EFTableView.mj_header endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 2:
            return self.list.count;
        default:
            return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     MeTabTableViewCell *MeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MeTabTableViewCell class])];
    switch (indexPath.section) {
        case 0:
        {
            [MeCell setData:@[@{@"title":@"已完成",@"icon":@"yiwancheng"},
            @{@"title":@"等待中",@"icon":@"waitting"},
            @{@"title":@"已失效",@"icon":@"yishixiao"},
                              @{@"title":@"待付款",@"icon":@"daifukuan"}] title:@"我的团购"];
            @weakify(self);
            MeCell.seletBtn = ^(NSInteger index) {
                XYLog(@"tuan->%ld",(long)index);
                if (index == 3) {
                    EFOrderViewController *order = [[EFOrderViewController alloc] initWithIndex:1];
                    order.hidesBottomBarWhenPushed = YES;
                    @strongify(self);
                    [self.navigationController qmui_pushViewController:order animated:YES completion:^{
                        
                    }];
                }else {
                    [kH5Manager gotoUrl:@"myGroup" hasNav:YES navTitle:@"我的团购" query:@{}];
                }
            };
            MeCell.moreBlock = ^{
                
            };
            return MeCell;
        }
            case 1:
        {
            [MeCell setData:@[@{@"title":@"待发货",@"icon":@"daifahuo"},
            @{@"title":@"待收货",@"icon":@"daishouhuo"},
            @{@"title":@"待评价",@"icon":@"daipingjia"},
                              @{@"title":@"退款/售后",@"icon":@"tuikuan"}] title:@"我的订单"];
            @weakify(self);
            MeCell.seletBtn = ^(NSInteger index) {
                XYLog(@"me->%ld",(long)index);
                if (index != 3) {
                    EFOrderViewController *order = [[EFOrderViewController alloc] initWithIndex:index+2];
                    order.hidesBottomBarWhenPushed = YES;
                    @strongify(self);
                    [self.navigationController qmui_pushViewController:order animated:YES completion:^{
                        
                    }];
                }
            };
            MeCell.moreBlock = ^{
                EFOrderViewController *order = [[EFOrderViewController alloc] initWithIndex:0];
                order.hidesBottomBarWhenPushed = YES;
                @strongify(self);
                [self.navigationController qmui_pushViewController:order animated:YES completion:^{
                    
                }];
            };
            return MeCell;
        }
            case 2:
        {
            MeListTableViewCell *listCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MeListTableViewCell class])];
            NSDictionary *dict = self.list[indexPath.row];
            [listCell setModel:dict];
            return listCell;
        }
        default:
        {
            MeWebTableViewCell *webCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MeWebTableViewCell class])];
            @weakify(self);
            [[webCell getCellHeight] subscribeNext:^(NSNumber *x) {
                @strongify(self);
                self.cellHeight = [x floatValue];
                [self.EFTableView reloadSection:3 withRowAnimation:(UITableViewRowAnimationNone)];
            }];
            return webCell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 2:
            return 50;
        case 3:
            return self.cellHeight;
        default:
            return WidthOfScale(134);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, 10)];
    line.backgroundColor = colorfafafa;
    return line;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
            {
                EFAddressViewController *VC = [[EFAddressViewController alloc] init];
                VC.hidesBottomBarWhenPushed = YES;
                [self.navigationController qmui_pushViewController:VC animated:YES completion:^{
                    
                }];
            }
                break;
               case 1:
            {
                EFSafeAccountViewController *vc = [[EFSafeAccountViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                    
                }];
                break;
            }
//                case 2:
//            {
//                break;
//            }
            default:
            {
                EFHelpViewController *VC = [[EFHelpViewController alloc] init];
                VC.hidesBottomBarWhenPushed = YES;
                [self.navigationController qmui_pushViewController:VC animated:YES completion:^{
                    
                }];
            }
                break;
        }
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.gk_navigationBar.alpha = self.EFTableView.contentOffset.y / NAVIGATION_BAR_HEIGHT;
}
@end
