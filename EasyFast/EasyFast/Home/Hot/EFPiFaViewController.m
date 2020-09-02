//
//  EFPiFaViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/9/2.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFPiFaViewController.h"
#import "EFHomeVM.h"
#import "EFGoodsTableViewCell.h"
@interface EFPiFaViewController ()
@property (nonatomic,assign)CGFloat goodsCellHeight;
@end

@implementation EFPiFaViewController

- (void)viewDidLoad {
    self.viewModel = [[EFHomeVM alloc] init];
    [super viewDidLoad];
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-45-WidthOfScale(44)-TAB_BAR_HEIGHT);
    self.gk_navigationBar.hidden = YES;
    [self.EFTableView registerClass:[EFGoodsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFGoodsTableViewCell class])];
    self.EFTableView.scrollEnabled = NO;
    [self loadNewData];
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kscrollYes object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        self.EFTableView.scrollEnabled = YES;
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kscrollNO object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        self.EFTableView.scrollEnabled = NO;
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kloadNewGoodsNoti object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self loadNewData];
    }];
    self.EFTableView.showsVerticalScrollIndicator = NO;
}

- (void)loadNewData {
    [[self.viewModel refreshForDown] subscribeNext:^(RACTuple *x) {
        /// 批发
        self.EFData = x.first;
        XYLog(@"data>>>>%@",self.EFData);
        [[RACScheduler mainThreadScheduler]schedule:^{
            [self addRefshUp];
            [self.EFTableView reloadData];
        }];
    }];
}

- (void)loadMoreData {
    [[self.viewModel refreshForUp] subscribeNext:^(RACTuple *x) {
        [self.EFTableView.mj_footer endRefreshing];
        self.EFData = x.first;
        [self.EFTableView reloadData];
    }];
}

- (UIView *)listView {
    return self.view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.EFData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFGoodsTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFGoodsTableViewCell class])];
    EFGoodsList *model = self.EFData[indexPath.row];
    [goodsCell setModel:model];
    goodsCell.btnSelect = ^{
        [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(YES),@"ggNo":model.ggNo}];
    };
    self.goodsCellHeight = [goodsCell cellHeight];
    return goodsCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EFGoodsList *model = self.EFData[indexPath.row];
    [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(NO),@"ggNo":model.ggNo}];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.goodsCellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= 0) {
        self.EFTableView.scrollEnabled = NO;
    }
}
@end
