//
//  TuanListViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "TuanListViewController.h"

#import "TuanListSelectView.h"
#import "TuanListTableViewCell.h"
#import "TuanListDetailViewController.h"
#import "EFTeamVM.h"

@interface TuanListViewController ()


@property (nonatomic,strong)TuanListSelectView *selectView;
@property (nonatomic,strong)NSString *ggNO;
@property (nonatomic,strong)EFTeamGoodsModel *model;

@end

@implementation TuanListViewController

-(TuanGoodsView *)goodsHeaderView
{
    if (_goodsHeaderView == nil) {
        _goodsHeaderView = [[TuanGoodsView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(180))];
    }
    return _goodsHeaderView;
}

- (instancetype)initWithGGNo:(NSString *)ggNO
{
    self = [super init];
    if (self) {
        self.ggNO = ggNO;
    }
    return self;
}

- (void)viewDidLoad {
    self.viewModel = [[EFTeamVM alloc] init];
    [super viewDidLoad];
    ((EFTeamVM *)self.viewModel).ggNO = self.ggNO;
    ((EFTeamVM *)self.viewModel).orderBy = 1;
    ((EFTeamVM *)self.viewModel).type = 2;
    ((EFTeamVM *)self.viewModel).teamInfo = YES;
    self.gk_navTitle = @"拼团列表";
    self.EFTableView.tableHeaderView = self.goodsHeaderView;
    [self.EFTableView registerClass:[TuanListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TuanListTableViewCell class])];
    [self addRefshUp];
    [self addRefshDown];
    [self loadNewData];
}


- (void)loadNewData {
    @weakify(self);
    [[self.viewModel refreshForDown] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        [self.EFTableView.mj_header endRefreshing];
        self.EFData = x.first;
        [self.EFTableView reloadData];
    }];
    
    [[EFTeamVM goodsSummaryGGNo:self.ggNO] subscribeNext:^(EFTeamGoodsModel *x) {
        @strongify(self);
        self.model = x;
        [self.goodsHeaderView setModel:x];
    }];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.EFData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TuanListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TuanListTableViewCell class])];
    EFTeamListModel *model = self.EFData[indexPath.row];
    [cell setModel:model];
    cell.btnBlock = ^{
        [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(YES),@"ggNo":self.ggNO}];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthOfScale(63.5+(16.5+3*30+20));
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.selectView == nil) {
        self.selectView = [[TuanListSelectView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(40))];
        @weakify(self);
        self.selectView.leftBtnBlock = ^(NSInteger orderBy) {
            @strongify(self);
            ((EFTeamVM *)self.viewModel).orderBy = orderBy;
            ((EFTeamVM *)self.viewModel).type = 2;
            [self loadNewData];
        };
        self.selectView.rightBtnBlock = ^(NSInteger orderBy) {
            @strongify(self);
            ((EFTeamVM *)self.viewModel).orderBy = orderBy;
            ((EFTeamVM *)self.viewModel).type = 1;
            [self loadNewData];
        };
    }
    return self.selectView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EFTeamListModel *model = self.EFData[indexPath.row];
    TuanListDetailViewController *list = [[TuanListDetailViewController alloc] initWithGGNo:self.ggNO ootNo:model.ootNo model:self.model];
    [self.navigationController qmui_pushViewController:list animated:YES completion:^{
        
    }];
}

@end
