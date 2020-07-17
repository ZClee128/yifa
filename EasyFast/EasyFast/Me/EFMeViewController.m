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



@interface EFMeViewController ()

@property (nonatomic,strong)MeHeaderView *headerView;
@property (nonatomic,strong)NSArray *list;


@end

@implementation EFMeViewController

-(MeHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[MeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(236.5))];
    }
    return _headerView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT - TAB_BAR_HEIGHT);
    self.gk_navigationBar.hidden = YES;
    self.EFTableView.tableHeaderView = self.headerView;
    [self.EFTableView registerClass:[MeTabTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MeTabTableViewCell class])];
    [self.EFTableView registerClass:[MeListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MeListTableViewCell class])];
    self.list = @[@{@"title":@"我的支付",@"icon":@"pay"},@{@"title":@"收货地址管理",@"icon":@"address"},
    @{@"title":@"账号安全",@"icon":@"safe"},@{@"title":@"帮助中心",@"icon":@"help"}];

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
            MeCell.seletBtn = ^(NSInteger index) {
                XYLog(@"tuan->%ld",(long)index);
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
            MeCell.seletBtn = ^(NSInteger index) {
                XYLog(@"me->%ld",(long)index);
            };
            MeCell.moreBlock = ^{
                
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
            return [[UITableViewCell alloc] init];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 2:
            return 50;
        case 3:
            return 0;
        default:
            return WidthOfScale(134);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}




@end
