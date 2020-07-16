//
//  EFBaseTableViewController.m
//  flag
//
//  Created by zclee on 2020/5/18.
//  Copyright © 2020 zclee. All rights reserved.
//

#import "EFBaseTableViewController.h"

@interface EFBaseTableViewController ()

@end

@implementation EFBaseTableViewController

-(NSMutableArray *)EFData
{
    if (_EFData == nil) {
        _EFData = [[NSMutableArray alloc]init];
    }
    return _EFData;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self configrue];
    }
    return self;
}

- (void)configrue
{
    self.tableViewStyle = UITableViewStyleGrouped;
    self.lineHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.EFTableView = [EFBaseTableView defaultTableView:self dataSource:self style:self.tableViewStyle];
    self.EFTableView.separatorStyle = (self.lineHidden ? UITableViewCellSeparatorStyleNone : UITableViewCellSeparatorStyleSingleLine);
    [self.view addSubview:self.EFTableView];
}

- (void)addRefshDown {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置header
    self.EFTableView.mj_header = header;
    [self.EFTableView.mj_header beginRefreshing];
    
}

- (void)loadNewData {
    
}

- (void)addRefshUp {
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.EFTableView.mj_footer = footer;
}

- (void)loadMoreData {
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end