//
//  EFSearchResultViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFSearchResultViewController.h"
#import "EFSearchViewController.h"
#import "SearchTwoCollectionViewCell.h"
#import "SeachOneCollectionViewCell.h"
#import "EFSearchVM.h"

@interface EFSearchResultViewController ()

@property (nonatomic,strong)QMUILabel *searchField;


@end

@implementation EFSearchResultViewController

//-(NSMutableArray *)data
//{
//    if (_data == nil) {
//        _data = [[NSMutableArray alloc]init];
//    }
//    return _data;
//}
//
//-(UICollectionView *)collect
//{
//    if (_collect == nil) {
//        self.flow = [[UICollectionViewFlowLayout alloc] init];
//        [self.flow setScrollDirection:UICollectionViewScrollDirectionVertical];//竖滑动
//        self.flow.minimumLineSpacing = WidthOfScale(11);
//        self.flow.minimumInteritemSpacing = WidthOfScale(10);
//        self.flow.itemSize = CGSizeMake(WidthOfScale(167), WidthOfScale(280));
//        _collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 45, kPHONE_WIDTH,kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT - 45) collectionViewLayout:self.flow];
//        _collect.backgroundColor = [UIColor clearColor];
//        _collect.delegate = self;
//        _collect.dataSource = self;
//        _collect.showsHorizontalScrollIndicator = NO;
//        _collect.showsVerticalScrollIndicator = NO;
//        _collect.contentInset = UIEdgeInsetsMake(WidthOfScale(15), WidthOfScale(15), WidthOfScale(15), WidthOfScale(15));
//        [_collect registerClass:[SearchTwoCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SearchTwoCollectionViewCell class])];
//        [_collect registerClass:[SeachOneCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SeachOneCollectionViewCell class])];
//    }
//    return _collect;
//}


-(QMUILabel *)searchField
{
    if (_searchField == nil) {
        _searchField = [[QMUILabel alloc] initWithFrame:CGRectMake(WidthOfScale(60), STATUS_BAR_HEIGHT, WidthOfScale(300), WidthOfScale(36))];
        _searchField.text = @"滑板车";
        _searchField.textColor = tabbarBlackColor;
        _searchField.backgroundColor = colorEFEFEF;
        _searchField.font = RegularFont15;
        [_searchField ViewRadius:36/2];
        _searchField.textAlignment = NSTextAlignmentLeft;
        _searchField.contentEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(20), 0, 0);
        _searchField.userInteractionEnabled = YES;
        @weakify(self);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            @strongify(self);
            EFSearchViewController *searchVC = [[EFSearchViewController alloc] init];
            [self.navigationController qmui_pushViewController:searchVC animated:NO completion:^{
                [self removeFromParentViewController];
            }];
        }];
        [_searchField addGestureRecognizer:tap];
        
    }
    return _searchField;
}

- (instancetype)initWithSearchTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.searchField.text = title;
    }
    return self;
}

- (void)viewDidLoad {
    self.viewModel = [[EFSearchVM alloc] init];
    self.collectionView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT + 45, kPHONE_WIDTH,kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT - 45);
    self.lineSpacing = WidthOfScale(11);
    self.interitemSpacing = WidthOfScale(10);
    self.itemSize = CGSizeMake(WidthOfScale(167), WidthOfScale(280));
    self.registerClasses = @[@{@"SearchTwoCollectionViewCell":@"SearchTwoCollectionViewCell"},@{@"SeachOneCollectionViewCell":@"SeachOneCollectionViewCell"}];
    self.collectionEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(15), WidthOfScale(15), WidthOfScale(15));
    ((EFSearchVM *)self.viewModel).title = self.searchField.text;
    ((EFSearchVM *)self.viewModel).sortType = 0;
    [super viewDidLoad];
    self.collectionView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT + 45, kPHONE_WIDTH,kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT - 45);
    self.isOne = NO;
    self.gk_navigationBar.hidden = NO;
    self.gk_navLineHidden = YES;
    [self setSearch];
    [self.view addSubview:[self headerView]];
    [self loadList];
}

- (void)loadList {
    @weakify(self);
    [[self.viewModel refreshForDown] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        self.EFData = x.first;
        [self.collectionView reloadData];
    }];
}

- (void)setSearch {
    [self.gk_navigationBar addSubview:self.searchField];
}

- (UIView *)headerView {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, 45)];
    bg.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bg];
    QMUIButton *leftBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [leftBtn setTitle:@"销量" forState:(UIControlStateNormal)];
    leftBtn.titleLabel.font = RegularFont15;
    [leftBtn setTitleColor:colorF14745 forState:(UIControlStateNormal)];
    
    
    QMUIButton *MiddleBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    MiddleBtn.titleLabel.font = RegularFont15;
    [MiddleBtn setTitle:@"价格" forState:(UIControlStateNormal)];
    [MiddleBtn setImage:knormal forState:(UIControlStateNormal)];
    [MiddleBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
    MiddleBtn.imagePosition = QMUIButtonImagePositionRight;
    
    
    QMUIButton *rightBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [rightBtn setImage:UIImageMake(@"two") forState:(UIControlStateNormal)];
    [rightBtn setImage:UIImageMake(@"one") forState:(UIControlStateSelected)];
    @weakify(self);
    [[rightBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
        x.selected = !x.selected;
        @strongify(self);
        self.isOne = x.selected;
        if (self.isOne) {
            self.collectionEdgeInsets = UIEdgeInsetsMake(15,0,0,0);
            [self defaultCollectionFlowLayout].minimumLineSpacing = WidthOfScale(0);
            [self defaultCollectionFlowLayout].minimumInteritemSpacing = WidthOfScale(0);
            [self defaultCollectionFlowLayout].itemSize = CGSizeMake(kPHONE_WIDTH, WidthOfScale(155));
        }else {
            self.collectionEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(15), WidthOfScale(15), WidthOfScale(15));
            [self defaultCollectionFlowLayout].minimumLineSpacing  = WidthOfScale(11);
            [self defaultCollectionFlowLayout].minimumInteritemSpacing = WidthOfScale(10);
            [self defaultCollectionFlowLayout].itemSize = CGSizeMake(WidthOfScale(167), WidthOfScale(280));
            
        }
        [[RACScheduler mainThreadScheduler] schedule:^{
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }];
    }];
    
    [bg addSubview:leftBtn];
    [bg addSubview:MiddleBtn];
    [bg addSubview:rightBtn];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(50)));
        make.bottom.equalTo(@(-WidthOfScale(10.5)));
        //        make.height.equalTo(@(WidthOfScale(36.5)));
    }];
    
    [MiddleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg);
        make.bottom.equalTo(@(-WidthOfScale(10.5)));
        //        make.height.equalTo(@(WidthOfScale(36.5)));
    }];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(50)));
        make.bottom.equalTo(@(-WidthOfScale(10.5)));
        //        make.height.equalTo(@(WidthOfScale(36.5)));
    }];
    
    
    [[leftBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
        [x setTitleColor:colorF14745 forState:(UIControlStateNormal)];
        [MiddleBtn setImage:knormal forState:(UIControlStateNormal)];
        [MiddleBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        MiddleBtn.selected = NO;
    }];
    
    [[MiddleBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
        @strongify(self);
        x.selected = !x.selected;
        if (x.selected) {
            [x setImage:kup forState:(UIControlStateNormal)];
            [x setTitleColor:colorF14745 forState:(UIControlStateNormal)];
            ((EFSearchVM *)self.viewModel).sortType = 1;
        }else {
            [x setImage:kdown forState:(UIControlStateNormal)];
            [x setTitleColor:colorF14745 forState:(UIControlStateNormal)];
            ((EFSearchVM *)self.viewModel).sortType = 2;
        }
        [self loadList];
        [leftBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
    }];
    return bg;
}


#pragma mark - collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.EFData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EFGoodsList *model = self.EFData[indexPath.item];
    if (self.isOne) {
        SeachOneCollectionViewCell *oneCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SeachOneCollectionViewCell class]) forIndexPath:indexPath];
        [oneCell setModel:model];
        return oneCell;
    }else{
        SearchTwoCollectionViewCell *twoCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SearchTwoCollectionViewCell class]) forIndexPath:indexPath];
        [twoCell setModel:model];
        return twoCell;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EFGoodsList *model = self.EFData[indexPath.item];
    [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(NO),@"ggNo":model.ggNo}];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}

@end
