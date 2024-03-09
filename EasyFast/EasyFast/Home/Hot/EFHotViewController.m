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
#import "EFFastHeaderView.h"
#import "EFNewGoodsViewController.h"
#import "EFPiFaViewController.h"

@interface EFHotViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong)EFFastHeaderView *fastHeader;
@property (nonatomic,strong)JXCategoryTitleView *wholesaleHeader;
@property (nonatomic,assign)BOOL isLoadActivity;
@property (nonatomic,assign)BOOL isLoadnotice;
@property (nonatomic,assign)CGFloat goodsCellHeight;
@property (nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property (nonatomic,strong)UIView *goodsHeader;
@end

@implementation EFHotViewController

-(JXCategoryTitleView *)wholesaleHeader
{
    if (_wholesaleHeader == nil) {
        _wholesaleHeader = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(44))];
        _wholesaleHeader.delegate = self;
        _wholesaleHeader.titleColorGradientEnabled = NO;
        _wholesaleHeader.titleColor = [RGB16(0xC76114) colorWithAlphaComponent:0.8];
        _wholesaleHeader.titleSelectedColor = RGB16(0xC76114);
        _wholesaleHeader.titleFont = MedFont17;
        _wholesaleHeader.titleSelectedFont = MedFont17;
        // 下划线
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        // 下划线颜
        lineView.indicatorColor = RGB16(0xC76114);
        // 下划线宽度
        lineView.indicatorWidth = WidthOfScale(40);
        lineView.indicatorHeight = WidthOfScale(3);
        lineView.indicatorCornerRadius = 0;
        _wholesaleHeader.indicators = @[lineView];
        _wholesaleHeader.titles = @[@"企业批发",@"新品上市"];
        _wholesaleHeader.defaultSelectedIndex = 0;
        self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
        self.listContainerView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-45 - WidthOfScale(44)-TAB_BAR_HEIGHT);
        //关联到categoryView
        _wholesaleHeader.listContainer = self.listContainerView;
        
    }
    return _wholesaleHeader;
}

- (UIView *)goodsHeader {
    if (_goodsHeader == nil) {
        _goodsHeader = [[UIView alloc] initWithFrame:self.wholesaleHeader.frame];
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = _goodsHeader.frame;
        gl.startPoint = CGPointMake(0, 0);
        gl.endPoint = CGPointMake(1, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:249/255.0 green:240/255.0 blue:225/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0.0),@(1.0f)];
        [_goodsHeader.layer addSublayer:gl];
        [_goodsHeader addSubview:self.wholesaleHeader];
    }
    return _goodsHeader;
}


-(EFFastHeaderView *)fastHeader
{
    if (_fastHeader == nil) {
        _fastHeader = [[EFFastHeaderView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(44))];
        @weakify(self);
        _fastHeader.moreBlock = ^{
            @strongify(self);
            EFFastTuanListViewController *vc = [[EFFastTuanListViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                
            }];
        };
        [_fastHeader setModel:@""];
    }
    return _fastHeader;
}

-(SDCycleScrollView *)cycleScrollView
{
    if (_cycleScrollView == nil) {
        _cycleScrollView = [[SDCycleScrollView alloc] init];
        _cycleScrollView.backgroundColor = [UIColor clearColor];
        _cycleScrollView.currentPageDotImage = [UIImage imageWithColor:UIColor.whiteColor size:CGSizeMake(20, 4) cornerRadius:2];
        _cycleScrollView.pageDotImage = [UIImage imageWithColor:UIColorFromRGBA(0xf5f5f5, 0.5) size:CGSizeMake(20, 4) cornerRadius:2];
        _cycleScrollView.placeholderImage = [UIImage imageWithColor:UIColor.whiteColor size:CGSizeMake(WidthOfScale(345), WidthOfScale(120))];
    }
    return _cycleScrollView;
}

- (void)viewDidLoad {
    self.viewModel = [[EFHomeVM alloc] init];
    self.tableViewStyle = UITableViewStylePlain;
    [super viewDidLoad];
    self.gk_navigationBar.hidden = YES;
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-45-TAB_BAR_HEIGHT);
    self.EFTableView.tableHeaderView = [self headerView];
    self.EFTableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    [self.EFTableView registerClass:[HotTabTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HotTabTableViewCell class])];
    [self.EFTableView registerClass:[EFNoticeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFNoticeTableViewCell class])];
    [self.EFTableView registerClass:[EFFastTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFFastTableViewCell class])];
    self.EFTableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[HotTabTableViewCell class] cellHeight:WidthOfScale(123.5)];
    self.EFTableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[EFNoticeTableViewCell class] cellHeight:WidthOfScale(30)];
    self.EFTableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[EFFastTableViewCell class] cellHeight:140+14.5+16+8+15+20];
    [self.EFTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self addRefshDown];
    @weakify(self);
    [self.EFTableView tab_startAnimationWithCompletion:^{
        @strongify(self);
       [self loadList];
    }];
    [self.wholesaleHeader reloadData];
}

- (void)loadList {
    @weakify(self);
    [[(EFHomeVM *)self.viewModel zipLoadUrl] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.EFTableView.mj_header endRefreshing];
        [self.EFTableView tab_endAnimation];
        self.isLoadActivity = YES;
        self.isLoadnotice = YES;
        self.cycleScrollView.imageURLStringsGroup = self.viewModel.dataSources[0][Homebanner];
        self.cycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
            @strongify(self);
            EFBannerModel *model = self.viewModel.dataSources[0][HomebannerData][currentIndex];
            XYLog(@"model===>%@",model);
        };
        [self.EFTableView reloadData];
    } error:^(NSError * _Nullable error) {
        [self.EFTableView.mj_header endRefreshing];
        [self.EFTableView reloadData];
    }];
}

- (void)loadNewData {
    [self loadList];
    [[NSNotificationCenter defaultCenter] postNotificationName:kloadNewGoodsNoti object:nil];
}


- (UIView *)headerView {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(130) +10)];
    bg.backgroundColor = [UIColor clearColor];
    [bg addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(10)));
        make.width.equalTo(@(WidthOfScale(355)));
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
    return self.viewModel.dataSources.count > 0 ? 4 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.viewModel.dataSources.count) {
        return 0;
    }
    switch (section) {
        case 0:
            return [self.viewModel.dataSources[0][Homeactivity] count] > 0 ? 1 : 0;
        case 1:
            return [self.viewModel.dataSources[0][Homenotice] count] > 0 ? 1 : 0;
        case 2:
            return [self.viewModel.dataSources[0][Homefast] count] > 0 ? 1 : 0;
        case 3:
            return 1;
        default:
            return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            HotTabTableViewCell *hotCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HotTabTableViewCell class])];
            if (self.isLoadActivity) {
                [hotCell setCollectData:self.viewModel.dataSources[0][Homeactivity]];
                self.isLoadActivity = NO;
            }
            if (![self.viewModel.dataSources[0][Homeactivity] count]) {
                hotCell.hidden = YES;
            }else {
                hotCell.hidden = NO;
            }
            return hotCell;
        }
        case 1:
        {
            EFNoticeTableViewCell *noticeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFNoticeTableViewCell class])];
            if (self.isLoadnotice) {
                [noticeCell setModel:self.viewModel.dataSources[0][Homenotice]];
                self.isLoadnotice = NO;
            }
            if ([self.viewModel.dataSources[0][Homenotice] count]) {
                noticeCell.hidden = NO;
            }else {
                noticeCell.hidden = YES;
            }
            return noticeCell;
        }
            case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
                    if (![cell.contentView viewWithTag:666]) {
//                        [cell.contentView removeAllSubviews];
                        [cell.contentView addSubview:self.fastHeader];
                        self.fastHeader.tag = 666;
                    }
                    if (![self.viewModel.dataSources[0][Homefast] count]) {
                        cell.hidden = YES;
                    }else {
                        cell.hidden = NO;
                    }
                    return cell;
                }
                default:
                {
                    EFFastTableViewCell *fastCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFFastTableViewCell class])];
                    [fastCell setCollectData:self.viewModel.dataSources[0][Homefast]];
                    fastCell.selectIndex = ^(EFFastModel *model) {
                        [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(YES),@"ggNo":model.ggNo}];
                    };
                    if (![self.viewModel.dataSources[0][Homefast] count]) {
                        fastCell.hidden = YES;
                    }else {
                        fastCell.hidden = NO;
                    }
                    return fastCell;
                }
            }
        }
        default:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
            if (![cell.contentView viewWithTag:888]) {
//                [cell.contentView removeAllSubviews];
                [cell.contentView addSubview:self.listContainerView];
                self.listContainerView.tag = 888;
            }
            return cell;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
//            return self.activityArr.count > 0 ? (self.activityArr.count <= 4 ? WidthOfScale(123.5) : WidthOfScale(208)) : 0.001;
            return [self.viewModel.dataSources[0][Homeactivity] count] > 0 ? WidthOfScale(102.5)+20 : 0;
            case 1:
        {
            return [self.viewModel.dataSources[0][Homenotice] count] > 0 ? WidthOfScale(30) : 0;
        }
            case 2:
        {
            if ([self.viewModel.dataSources[0][Homefast] count] > 0) {
                switch (indexPath.row) {
                    case 0:
                        return WidthOfScale(44);
                    default:
                        return 140+14.5+16+8+15+20;
                }
            }else {
                return 0;
            }
        }
        default:
            return kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-45 - WidthOfScale(44)-TAB_BAR_HEIGHT;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 3:
        {
            return self.goodsHeader;
        }
        default:
            return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 3:
        {
            return WidthOfScale(44);
        }
        default:
            return 0.001;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 1 ? WidthOfScale(20) : 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *foot = [tableView viewWithTag:700];
    if (foot == nil) {
        foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(20))];
        foot.backgroundColor = colorfafafa;
        foot.tag = 700;
    }
    return section == 1 ? foot : nil;
}


//返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.wholesaleHeader.titles.count;
}
//根据下标index返回对应遵从`JXCategoryListContentViewDelegate`协议的列表实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            EFPiFaViewController *hot =  [[EFPiFaViewController alloc] init];
            return hot;
        }
        default:
        {
            EFNewGoodsViewController *vc = [[EFNewGoodsViewController alloc] init];
            return vc;
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.EFTableView.qmui_indexOfPinnedSectionHeader == 3) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kscrollYes object:nil];
    }else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kscrollNO object:nil];
    }
}
@end
