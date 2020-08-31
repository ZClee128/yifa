//
//  EFBaseTableViewController.m
//  flag
//
//  Created by zclee on 2020/5/18.
//  Copyright © 2020 zclee. All rights reserved.
//

#import "EFBaseTableViewController.h"
#import "EFRefreshHeader.h"
#import "EFMeRefreshHeader.h"

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
//    @weakify(self);
//    self.EFTableView.ly_emptyView = [EFEmptyView NoNetEmptybtnClickBlock:^{
//        @strongify(self);
//        [self noNetClick];
//    }];
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kNetNoti object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//        @strongify(self);
//        [self.EFTableView ly_showEmptyView];
//    }];
    [self addEmpty];
}

- (void)addEmpty {
    @weakify(self);
    self.EFTableView.ly_emptyView = [EFEmptyView NoDataEmptybtnClickBlock:^{

    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kNetNoti object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        self.EFTableView.ly_emptyView = [EFEmptyView NoNetEmptybtnClickBlock:^{
            @strongify(self);
            [self noNetClick];
        }];
    }];
}

- (void)noNetClick {
    self.EFTableView.ly_emptyView = [EFEmptyView NoDataEmptybtnClickBlock:^{

    }];
    [self loadNewData];
}

- (void)addRefshDown {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    EFRefreshHeader *header = [EFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置header
    self.EFTableView.mj_header = header;
//    [self.EFTableView.mj_header beginRefreshing];
    
}

- (void)addWhiteRefshDown {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    EFMeRefreshHeader *header = [EFMeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置header
    self.EFTableView.mj_header = header;
//    [self.EFTableView.mj_header beginRefreshing];
    
}

- (void)loadNewData {
    
}

- (void)addRefshUp {
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    if (self.EFData.count > 0) {
        self.EFTableView.mj_footer = footer;
    }
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
    return [[UITableViewCell alloc] init];
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
