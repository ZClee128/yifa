//
//  EFHotViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/14.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFHotViewController.h"
#import "HotTabTableViewCell.h"
#import "EFNoticeTableViewCell.h"
#import "EFHeaderView.h"
#import "EFFastTableViewCell.h"
#import "EFGoodsTableViewCell.h"
#import "EFFastTuanListViewController.h"
#import "EFHomeVM.h"
#import "EFFastVM.h"

@interface EFHotViewController ()

@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong)EFHeaderView *fastHeader;
@property (nonatomic,strong)EFHeaderView *wholesaleHeader;
@property (nonatomic,strong)NSMutableArray *activityArr;
@property (nonatomic,strong)NSMutableArray *noticeArr;
@property (nonatomic,strong)NSMutableArray *fastArr;
@property (nonatomic,strong)EFFastVM *fastVM;
@end

@implementation EFHotViewController

- (NSMutableArray *)activityArr {
    if (_activityArr == nil) {
        _activityArr = [[NSMutableArray alloc] init];
    }
    return _activityArr;
}

- (NSMutableArray *)noticeArr {
    if (_noticeArr == nil) {
        _noticeArr = [[NSMutableArray alloc] init];
    }
    return _noticeArr;
}

- (NSMutableArray *)fastArr {
    if (_fastArr== nil) {
        _fastArr = [[NSMutableArray alloc] init];
    }
    return _fastArr;
}

-(EFHeaderView *)wholesaleHeader
{
    if (_wholesaleHeader == nil) {
        _wholesaleHeader = [[EFHeaderView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, 53) WithLeftTitle:@"企业批发" WithRightTitle:@""];
        UILabel *left = [_wholesaleHeader getLeftLab];
        [left mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(23));
            make.height.equalTo(@(17));
            make.left.equalTo(@(15));
        }];
    }
    return _wholesaleHeader;
}

-(EFHeaderView *)fastHeader
{
    if (_fastHeader == nil) {
        _fastHeader = [[EFHeaderView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, 53) WithLeftTitle:@"急速拼团" WithRightTitle:@"查看全部"];
        @weakify(self);
        _fastHeader.moreBlock = ^{
            @strongify(self);
            EFFastTuanListViewController *vc = [[EFFastTuanListViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                
            }];
        };
    }
    return _fastHeader;
}

-(SDCycleScrollView *)cycleScrollView
{
    if (_cycleScrollView == nil) {
        _cycleScrollView = [[SDCycleScrollView alloc] init];
        _cycleScrollView.currentPageDotImage = [UIImage imageWithColor:UIColor.whiteColor size:CGSizeMake(20, 4) cornerRadius:2];
        _cycleScrollView.pageDotImage = [UIImage imageWithColor:UIColorFromRGBA(0xf5f5f5, 0.5) size:CGSizeMake(20, 4) cornerRadius:2];
    }
    return _cycleScrollView;
}

- (void)viewDidLoad {
    self.viewModel = [[EFHomeVM alloc] init];
    [super viewDidLoad];
    self.fastVM = [[EFFastVM alloc] init];
    self.fastVM.orderBy = @1;
    self.fastVM.type = @1;
    self.fastVM.branches = @3;
    self.gk_navigationBar.hidden = YES;
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-30-TAB_BAR_HEIGHT);
    self.EFTableView.tableHeaderView = [self headerView];
    [self.EFTableView registerClass:[HotTabTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HotTabTableViewCell class])];
    [self.EFTableView registerClass:[EFNoticeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFNoticeTableViewCell class])];
    [self.EFTableView registerClass:[EFFastTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFFastTableViewCell class])];
    [self.EFTableView registerClass:[EFGoodsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFGoodsTableViewCell class])];
    [self addRefshDown];
    [self addRefshUp];
    [self loadList];
}

- (void)loadList {
    [[EFHomeVM activity] subscribeNext:^(NSArray *x) {
        self.activityArr = [x mutableCopy];
        [self.EFTableView reloadData];
    }];
    
    [[EFHomeVM banner] subscribeNext:^(NSArray *x) {
        NSMutableArray *images = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < x.count; i++) {
            EFBannerModel *model = x[i];
            [images addObject:model.url];
        }
        self.cycleScrollView.imageURLStringsGroup = images;
    }];
    
    [[EFHomeVM notice] subscribeNext:^(NSArray *x) {
        self.noticeArr = [x mutableCopy];
        [self.EFTableView reloadData];
    }];
    
    [[self.viewModel refreshForDown] subscribeNext:^(RACTuple *x) {
        [self.EFTableView.mj_header endRefreshing];
        self.EFData = x.first;
        [self.EFTableView reloadData];
    }];
    
    [[EFHomeVM fastOrderBy:@1 type:@1 PageNum:@1 pageSize:@3] subscribeNext:^(NSArray *x) {
        self.fastArr = [x mutableCopy];
        [self.EFTableView reloadData];
    }];
    
}

- (void)loadNewData {
    [self loadList];
}

- (void)loadMoreData {
    [[self.viewModel refreshForUp] subscribeNext:^(RACTuple *x) {
        [self.EFTableView.mj_footer endRefreshing];
        self.EFData = x.first;
        [self.EFTableView reloadData];
    }];
}

- (UIView *)headerView {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(130))];
    bg.backgroundColor = colorfafafa;
    [bg addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15)));
        make.width.equalTo(@(WidthOfScale(345)));
        make.height.equalTo(@(WidthOfScale(120)));
        make.top.equalTo(@(WidthOfScale(10)));
    }];
    [self.cycleScrollView layoutIfNeeded];
    [self.cycleScrollView ViewRadius:5];
    return bg;
}

// 返回列表视图
// 如果列表是VC，就返回VC.view
// 如果列表是View，就返回View自己
- (UIView *)listView {
    return self.view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 3:
            return self.EFData.count;
        default:
            return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            HotTabTableViewCell *hotCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HotTabTableViewCell class])];
            [hotCell setCollectData:self.activityArr];
            return hotCell;
        }
        case 1:
        {
            EFNoticeTableViewCell *noticeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFNoticeTableViewCell class])];
            [noticeCell setModel:self.noticeArr];
            return noticeCell;
        }
            case 2:
        {
            EFFastTableViewCell *fastCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFFastTableViewCell class])];
            [fastCell setCollectData:self.fastArr];
            fastCell.selectIndex = ^(EFFastModel *model) {
                [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(YES),@"ggNo":model.ggNo}];
            };
            return fastCell;
        }
        default:
        {
            EFGoodsTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFGoodsTableViewCell class])];
            EFGoodsList *model = self.EFData[indexPath.row];
            [goodsCell setModel:model];
            goodsCell.btnSelect = ^{
                [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(YES),@"ggNo":model.ggNo}];
            };
            return goodsCell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        EFGoodsList *model = self.EFData[indexPath.row];
        [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(NO),@"ggNo":model.ggNo}];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return self.activityArr.count <= 4 ? WidthOfScale(123.5) : WidthOfScale(208);
            case 1:
        {
            return WidthOfScale(30);
        }
            case 2:
        {
            return 140+14.5+16+8+15+20;
        }
        default:
            return WidthOfScale(140)+15;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 2:
        {
            return self.fastHeader;
        }
        case 3:
        {
            return self.wholesaleHeader;
        }
        default:
            return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 2:
            return WidthOfScale(52);
        case 3:
        {
            return WidthOfScale(52);
        }
        default:
            return 0.001;
    }
}

@end
