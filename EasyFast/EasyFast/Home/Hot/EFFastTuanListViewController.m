//
//  EFFastTuanListViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/8/3.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFastTuanListViewController.h"
#import "EFFastTuanListCollectionViewCell.h"
#import "EFFastVM.h"

@interface EFFastTuanListViewController ()



@end

@implementation EFFastTuanListViewController

- (void)viewDidLoad {
    self.viewModel = [[EFFastVM alloc] init];
    self.registerClasses = @[@{@"EFFastTuanListCollectionViewCell":@"EFFastTuanListCollectionViewCell"}];
    self.itemSize = CGSizeMake(WidthOfScale(167), flat(WidthOfScale(258)));
    self.lineSpacing = WidthOfScale(10);
    self.collectionEdgeInsets = UIEdgeInsetsMake(WidthOfScale(15), WidthOfScale(15), TAB_SAFE_HEIGHT, WidthOfScale(15));
    [super viewDidLoad];
    ((EFFastVM *)self.viewModel).orderBy = @1;
    ((EFFastVM *)self.viewModel).type = @1;
    self.collectionView.frame = CGRectMake(WidthOfScale(0), NAVIGATION_BAR_HEIGHT + WidthOfScale(40), kPHONE_WIDTH, kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT - WidthOfScale(40));
    self.gk_backImage = [UIImageMake(@"btn_back_black") qmui_imageWithTintColor:UIColor.whiteColor];
    self.gk_navTitle = @"急速拼团";
    self.gk_navTitleColor = UIColor.whiteColor;
    self.gk_navBackgroundColor = UIColor.clearColor;
    self.gk_navLineHidden = YES;
    UIImageView *bg = [[UIImageView alloc] initWithImage:UIImageMake(@"fast_bg")];
    [self.view insertSubview:bg belowSubview:self.collectionView];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(kPHONE_WIDTH));
    }];
    [self.view addSubview:[self headerView]];
    [self loadList];
    [self addRefshDown];
    [self addRefshUp];
}

- (void)loadList {
    @weakify(self);
    [[self.viewModel refreshForDown] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        [self.collectionView.mj_header endRefreshing];
        self.EFData = x.first;
        [self.collectionView reloadData];
    }];
}

- (void)loadNewData {
    [self loadList];
}

- (void)loadMoreData {
    @weakify(self);
    [[self.viewModel refreshForUp] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        [self.collectionView.mj_footer endRefreshing];
        self.EFData = x.first;
        [self.collectionView reloadData];
    }];
}

- (UIView *)headerView {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(WidthOfScale(15), NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH - WidthOfScale(30), WidthOfScale(40))];
    bg.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.2];
    [bg ViewRadius:4];
    
    QMUIButton *leftBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [leftBtn setTitle:@"最快成团" forState:(UIControlStateNormal)];
    [leftBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    leftBtn.titleLabel.font = RegularFont15;
    [leftBtn setImage:UIImageMake(@"up") forState:(UIControlStateNormal)];
    leftBtn.selected = YES;
    leftBtn.imagePosition = QMUIButtonImagePositionRight;
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(10.5), 0, 0);
    leftBtn.frame = CGRectMake(0, 0, bg.width/2, bg.height);
    [bg addSubview:leftBtn];
    
    
    QMUIButton *rightBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [rightBtn setTitle:@"时间最短" forState:(UIControlStateNormal)];
    [rightBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    rightBtn.titleLabel.font = RegularFont15;
    [rightBtn setImage:UIImageMake(@"normal") forState:(UIControlStateNormal)];
    rightBtn.imagePosition = QMUIButtonImagePositionRight;
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(10.5), 0, 0);
    rightBtn.frame = CGRectMake(leftBtn.width, 0, bg.width/2, bg.height);
    [bg addSubview:rightBtn];
    @weakify(self);
    [[rightBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        x.selected = !x.selected;
        @strongify(self);
        ((EFFastVM *)self.viewModel).orderBy = @2;
        if (x.selected) {
            [x setImage:kup forState:(UIControlStateNormal)];
            ((EFFastVM *)self.viewModel).type = @1;
        }else {
            [x setImage:kdown forState:(UIControlStateNormal)];
            ((EFFastVM *)self.viewModel).type = @2;
        }
        [leftBtn setImage:knormal forState:(UIControlStateNormal)];
        leftBtn.selected = NO;
        [self.collectionView scrollToTop];
        [self loadList];
    }];
    
    [[leftBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        x.selected = !x.selected;
        @strongify(self);
        ((EFFastVM *)self.viewModel).orderBy = @1;
        if (x.selected) {
            [x setImage:kup forState:(UIControlStateNormal)];
            ((EFFastVM *)self.viewModel).type = @1;
        }else {
            [x setImage:kdown forState:(UIControlStateNormal)];
            ((EFFastVM *)self.viewModel).type = @2;
        }
        [rightBtn setImage:knormal forState:(UIControlStateNormal)];
        rightBtn.selected = NO;
        [self.collectionView scrollToTop];
        [self loadList];
    }];
    return bg;
}

//-(UICollectionView *)collection
//{
//    if (_collection == nil) {
//        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
//        [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
//        flow.minimumInteritemSpacing = WidthOfScale(10);
//        flow.itemSize = CGSizeMake(WidthOfScale(167), flat(WidthOfScale(258)));
//        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(WidthOfScale(0), NAVIGATION_BAR_HEIGHT + WidthOfScale(40), kPHONE_WIDTH, kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT - WidthOfScale(40)) collectionViewLayout:flow];
//        _collection.backgroundColor = [UIColor clearColor];
//        _collection.delegate = self;
//        _collection.dataSource = self;
//        _collection.showsHorizontalScrollIndicator = NO;
//        _collection.showsVerticalScrollIndicator = NO;
//        _collection.contentInset = UIEdgeInsetsMake(WidthOfScale(15), WidthOfScale(15), TAB_SAFE_HEIGHT, WidthOfScale(15));
//        [_collection registerClass:[EFFastTuanListCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([EFFastTuanListCollectionViewCell class])];
//    }
//    return _collection;
//}



#pragma mark - collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.EFData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EFFastTuanListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EFFastTuanListCollectionViewCell class]) forIndexPath:indexPath];
    [cell setModel:self.EFData[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EFFastModel *model = self.EFData[indexPath.item];
    [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(YES),@"ggNo":model.ggNo}];
}

@end
