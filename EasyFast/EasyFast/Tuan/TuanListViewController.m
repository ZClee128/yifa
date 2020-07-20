//
//  TuanListViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "TuanListViewController.h"
#import "TuanGoodsView.h"
#import "TuanListSelectView.h"
#import "TuanListTableViewCell.h"
#import "TuanListDetailViewController.h"

@interface TuanListViewController ()

@property (nonatomic,strong)TuanGoodsView *goodsHeaderView;
@property (nonatomic,strong)TuanListSelectView *selectView;

@end

@implementation TuanListViewController

-(TuanGoodsView *)goodsHeaderView
{
    if (_goodsHeaderView == nil) {
        _goodsHeaderView = [[TuanGoodsView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(180))];
        [_goodsHeaderView setModel:@""];
    }
    return _goodsHeaderView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"拼团列表";
    self.EFTableView.tableHeaderView = self.goodsHeaderView;
    [self.EFTableView registerClass:[TuanListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TuanListTableViewCell class])];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TuanListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TuanListTableViewCell class])];
    [cell setModel:@""];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthOfScale(63.5+(16.5+3*30+20));
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.selectView == nil) {
        self.selectView = [[TuanListSelectView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(40))];
    }
    return self.selectView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TuanListDetailViewController *list = [[TuanListDetailViewController alloc] init];
    [self.navigationController qmui_pushViewController:list animated:YES completion:^{
        
    }];
}

@end
