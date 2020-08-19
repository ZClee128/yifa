//
//  EFHomeOtherViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFHomeOtherViewController.h"
#import "EFClassTabTableViewCell.h"
#import "EFGoodsTableViewCell.h"
#import "EFClassDetailViewController.h"
#import "TuanListViewController.h"
#import "EFClassifyVM.h"
#import "EFHomeVM.h"

@interface EFHomeOtherViewController ()
@property (nonatomic,assign)id type;
@property (nonatomic,strong)NSMutableArray *classData;
@property (nonatomic,assign)CGFloat goodsCellHeight;
@end

@implementation EFHomeOtherViewController

- (NSMutableArray *)classData {
    if (_classData == nil) {
        _classData = [[NSMutableArray alloc] init];
    }
    return _classData;
}

- (instancetype)initWithType:(id)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    self.viewModel = [[EFHomeVM alloc] init];
    [super viewDidLoad];
    ((EFHomeVM *)self.viewModel).orderBy = @(0);
    self.gk_navigationBar.hidden = YES;
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-30-TAB_BAR_HEIGHT);
    [self.EFTableView registerClass:[EFClassTabTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFClassTabTableViewCell class])];
    [self.EFTableView registerClass:[EFGoodsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFGoodsTableViewCell class])];
    self.EFTableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[EFClassTabTableViewCell class] cellHeight:WidthOfScale(211.5)];
    self.EFTableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[EFGoodsTableViewCell class] cellHeight:WidthOfScale(155)];
    [self.EFTableView tab_startAnimationWithCompletion:^{
       [self loadList];
    }];
    [self addRefshUp];
    [self addRefshDown];
}

- (void)loadList {
    //@{@"title":@"查看更多",@"icon":@"6"}
    @weakify(self);
    [[self defCode] subscribeNext:^(EFClassifyModel  *x) {
        @strongify(self);
        [[(EFHomeVM *)self.viewModel refreshOtherForDown:x.ggcsCode] subscribeNext:^(RACTuple *x) {
            @strongify(self);
            [self.EFTableView.mj_header endRefreshing];
            [self.EFTableView tab_endAnimation];
            self.EFData = [x.first mutableCopy];
            [self.EFTableView reloadData];
        }];
    }];
}

- (RACSignal *)defCode {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [[EFClassifyVM thirdCategory:self.type size:@"9"] subscribeNext:^(NSArray *x) {
            self.classData = [x mutableCopy];
            EFClassifyModel *model = [[EFClassifyModel alloc] init];
            model.icon = @"6";
            model.title = @"查看更多";
            [self.classData addObject:model];
            [subscriber sendNext:self.classData[0]];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

- (void)loadNewData {
    [self loadList];
}

- (void)loadMoreData {
    @weakify(self);
    [[self defCode] subscribeNext:^(EFClassifyModel  *x) {
        @strongify(self);
        [[(EFHomeVM *)self.viewModel refreshOtherForUp:x.ggcsCode] subscribeNext:^(RACTuple *x) {
            @strongify(self);
            [self.EFTableView.mj_footer endRefreshing];
            self.EFData = [x.first mutableCopy];
            [self.EFTableView reloadData];
        }];
    }];
}

- (UIView *)listView {
    return self.view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        default:
            return self.EFData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
         {
            EFClassTabTableViewCell *classCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFClassTabTableViewCell class])];
             [classCell setCollectData:self.classData];
             classCell.selectItem = ^(EFClassifyModel *model) {
                 if ([model.title isEqualToString:@"查看更多"]) {
                     kAppDelegate.classCode = self.type;
                     [[NSNotificationCenter defaultCenter] postNotificationName:kclassNoti object:@{@"code":self.type}];
                     kAppDelegate.efTabbar.selectedIndex = 1;
                 }else {
                     EFClassDetailViewController *VC = [[EFClassDetailViewController alloc] initWithModel:model];
                     VC.hidesBottomBarWhenPushed = YES;
                     [self.navigationController qmui_pushViewController:VC animated:YES completion:^{

                     }];
                 }
             };
             return classCell;
          }
        default:
        {
            EFGoodsTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFGoodsTableViewCell class])];
            EFGoodsList *model = self.EFData[indexPath.row];
            [goodsCell setModel:model];
            goodsCell.btnSelect = ^{
              [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(YES),@"ggNo":model.ggNo}];
            };
            self.goodsCellHeight = [goodsCell cellHeight];
            return goodsCell;
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        EFGoodsList *model = self.EFData[indexPath.row];
        [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(NO),@"ggNo":model.ggNo}];
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return WidthOfScale(212);
        default:
            return self.goodsCellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
@end
