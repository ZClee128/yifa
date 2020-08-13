//
//  EFCollectionViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/7/29.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFCollectionViewController.h"
#import "SeachOneCollectionViewCell.h"
#import "SearchTwoCollectionViewCell.h"
#import "EFCollectionVM.h"
#import "EFRefreshHeader.h"

@interface EFCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic,assign) BOOL isOne;
@property (nonatomic,strong)UICollectionView *collect;
@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,strong)UICollectionViewFlowLayout *flow;
@property (nonatomic,strong) QMUIButton *leftBtn;
@property (nonatomic,strong)QMUIButton *MiddleBtn;
@property (nonatomic,strong)EFCollectionVM *collectVM;
@end

@implementation EFCollectionViewController

-(NSMutableArray *)data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc]init];
    }
    return _data;
}

-(UICollectionView *)collect
{
    if (_collect == nil) {
        self.flow = [[UICollectionViewFlowLayout alloc] init];
        [self.flow setScrollDirection:UICollectionViewScrollDirectionVertical];//竖滑动
        self.flow.minimumLineSpacing = WidthOfScale(0);
//        self.flow.minimumInteritemSpacing = WidthOfScale(10);
        self.flow.itemSize = CGSizeMake(kPHONE_WIDTH, WidthOfScale(155));
        _collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 47, kPHONE_WIDTH,kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT - 47 - TAB_BAR_HEIGHT - 45) collectionViewLayout:self.flow];
        _collect.backgroundColor = [UIColor clearColor];
        _collect.delegate = self;
        _collect.dataSource = self;
        _collect.showsHorizontalScrollIndicator = NO;
        _collect.showsVerticalScrollIndicator = NO;
        _collect.contentInset = UIEdgeInsetsMake(0,0,0,0);
//        [_collect registerClass:[SearchTwoCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SearchTwoCollectionViewCell class])];
        [_collect registerClass:[SeachOneCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SeachOneCollectionViewCell class])];
        _collect.tabAnimated = [TABCollectionAnimated animatedWithCellClass:[SeachOneCollectionViewCell class] cellSize:CGSizeMake(kPHONE_WIDTH, WidthOfScale(155))];
        _collect.tabAnimated.canLoadAgain = YES;
    }
    return _collect;
}


- (void)viewDidLoad {
    self.viewModel = [[EFCollectionVM alloc] init];
    [super viewDidLoad];
    self.collectVM = (EFCollectionVM *)self.viewModel;
    self.view.backgroundColor = UIColor.whiteColor;
    self.isOne = NO;
    self.gk_navigationBar.hidden = YES;
    [self.view addSubview:[self headerView]];
    [self.view addSubview:self.collect];
    [self addRefshUp];
    [self addRefshDown];
    
    [self loadCollectionWith:1 sortType:0];
}

- (void)loadCollectionWith:(NSInteger )type sortType:(NSInteger )sortType {
    self.collectVM.type = type;
    self.collectVM.sortType = sortType;
    @weakify(self);
    [self.collect tab_startAnimationWithCompletion:^{
    [[self.collectVM refreshForDown] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        [self.collect.mj_header endRefreshing];
        [self.collect tab_endAnimation];
        self.data = x.first;
        [self.collect reloadData];
    }];
    }];
}

- (void)addRefshDown {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    EFRefreshHeader *header = [EFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置header
    self.collect.mj_header = header;
    
}

- (void)loadNewData {
    @weakify(self);
    [self.collect tab_stopPullLoading];
    [[self.collectVM refreshForDown] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        [self.collect.mj_header endRefreshing];
        [self.collect tab_endAnimation];
        self.data = x.first;
        [self.collect reloadData];
    }];
}

- (void)addRefshUp {
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collect.mj_footer = footer;
}

- (void)loadMoreData {
    @weakify(self);
    [[self.collectVM refreshForUp] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        [self.collect.mj_footer endRefreshing];
        self.data = x.first;
        [self.collect reloadData];
    }];
}


- (UIView *)listView {
    return self.view;
}

- (UIView *)headerView {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, 47)];
    bg.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bg];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, 10)];
    line.backgroundColor = colorfafafa;
    [bg addSubview:line];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 46, kPHONE_WIDTH, 1)];
    line2.backgroundColor = colorfafafa;
    [bg addSubview:line2];
    
    QMUIButton *leftBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [leftBtn setTitle:@"时间" forState:(UIControlStateNormal)];
    leftBtn.selected = YES;
    [leftBtn setImage:kup forState:(UIControlStateNormal)];
    leftBtn.titleLabel.font = RegularFont15;
    [leftBtn setTitleColor:colorF14745 forState:(UIControlStateNormal)];
    leftBtn.imagePosition = QMUIButtonImagePositionRight;
    self.leftBtn = leftBtn;
    @weakify(self);
    [[self.leftBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
        x.selected = !x.selected;
        @strongify(self);
        if (x.selected) {
            [x setImage:kup forState:(UIControlStateNormal)];
            [self.MiddleBtn setImage:knormal forState:(UIControlStateNormal)];
            [self.MiddleBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
            self.MiddleBtn.selected = NO;
            [x setTitleColor:colorF14745 forState:(UIControlStateNormal)];
            [self loadCollectionWith:1 sortType:0];
        }else {
            [x setImage:kdown forState:(UIControlStateNormal)];
            [x setTitleColor:colorF14745 forState:(UIControlStateNormal)];
            [self loadCollectionWith:1 sortType:1];
        }
        
    }];
    
    QMUIButton *MiddleBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    MiddleBtn.titleLabel.font = RegularFont15;
    [MiddleBtn setTitle:@"价格" forState:(UIControlStateNormal)];
    [MiddleBtn setImage:knormal forState:(UIControlStateNormal)];
    [MiddleBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
    [MiddleBtn setTitleColor:colorF14745 forState:(UIControlStateSelected)];
    MiddleBtn.imagePosition = QMUIButtonImagePositionRight;
    self.MiddleBtn = MiddleBtn;
    [[self.MiddleBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
        x.selected = !x.selected;
        @strongify(self);
        if (x.selected) {
            [x setImage:kup forState:(UIControlStateNormal)];
            [self.leftBtn setImage:knormal forState:(UIControlStateNormal)];
            [self.leftBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
            self.leftBtn.selected = NO;
            [x setTitleColor:colorF14745 forState:(UIControlStateNormal)];
            [self loadCollectionWith:2 sortType:0];
        }else {
            [x setImage:kdown forState:(UIControlStateNormal)];
            [x setTitleColor:colorF14745 forState:(UIControlStateNormal)];
            [self loadCollectionWith:2 sortType:1];
        }
        
    }];
    
    
    
//    QMUIButton *rightBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
//    [rightBtn setImage:UIImageMake(@"two") forState:(UIControlStateNormal)];
//    [rightBtn setImage:UIImageMake(@"one") forState:(UIControlStateSelected)];
//    @weakify(self);
//    [[rightBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
//        x.selected = !x.selected;
//        @strongify(self);
//        self.isOne = x.selected;
//        if (self.isOne) {
//            self.collect.contentInset = UIEdgeInsetsMake(0,0,0,0);
//            self.flow.minimumLineSpacing = WidthOfScale(0);
//            self.flow.minimumInteritemSpacing = WidthOfScale(0);
//            self.flow.itemSize = CGSizeMake(kPHONE_WIDTH, WidthOfScale(155));
//        }else {
//            self.collect.contentInset = UIEdgeInsetsMake(WidthOfScale(0), WidthOfScale(15), WidthOfScale(15), WidthOfScale(15));
//            self.flow.minimumLineSpacing = WidthOfScale(11);
//            self.flow.minimumInteritemSpacing = WidthOfScale(10);
//            self.flow.itemSize = CGSizeMake(WidthOfScale(167), WidthOfScale(280));
//
//        }
//        [[RACScheduler mainThreadScheduler] schedule:^{
//           [self.collect reloadSections:[NSIndexSet indexSetWithIndex:0]];
//        }];
//    }];
//
    [bg addSubview:leftBtn];
    [bg addSubview:MiddleBtn];
//    [bg addSubview:rightBtn];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(14.5)));
        make.bottom.equalTo(@(-WidthOfScale(10.5)));
//        make.height.equalTo(@(WidthOfScale(36.5)));
    }];
    
    [MiddleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(178.5)));
        make.bottom.equalTo(@(-WidthOfScale(10.5)));
//        make.height.equalTo(@(WidthOfScale(36.5)));
    }];
    
//    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(@(-WidthOfScale(15.5)));
//        make.bottom.equalTo(@(-WidthOfScale(10.5)));
////        make.height.equalTo(@(WidthOfScale(36.5)));
//    }];
    
    return bg;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    if (self.isOne) {
    SeachOneCollectionViewCell *oneCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SeachOneCollectionViewCell class]) forIndexPath:indexPath];
    EFGoodsList *model = self.data[indexPath.item];
    [oneCell setModel:model];
    [oneCell setBtnStyle];
    oneCell.seletBtnBlock = ^(QMUIButton * _Nonnull sender) {
        if (sender.selected) {
            [[EFCollectionVM cancelCollectGoods:model.ggNo] subscribeNext:^(NSNumber *ok) {
                if ([ok boolValue]) {
                    model.isCollect = NO;
                    sender.selected = !sender.selected;
                }
            }];
        }else {
            [[EFCollectionVM setCollectGoods:model.ggNo] subscribeNext:^(NSNumber *ok) {
                if ([ok boolValue]) {
                    model.isCollect = YES;
                    sender.selected = !sender.selected;
                }
            }];
        }
    };
    return oneCell;
    //    }else{
    //        SearchTwoCollectionViewCell *twoCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SearchTwoCollectionViewCell class]) forIndexPath:indexPath];
    //        [twoCell setModel:@""];
    //        return twoCell;
    //    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EFGoodsList *model = self.data[indexPath.item];
    [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(NO),@"ggNo":model.ggNo}];
}
@end
