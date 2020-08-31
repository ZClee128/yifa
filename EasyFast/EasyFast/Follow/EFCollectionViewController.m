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

@interface EFCollectionViewController ()

@property (nonatomic,assign) BOOL isOne;
@property (nonatomic,strong) QMUIButton *leftBtn;
@property (nonatomic,strong)QMUIButton *MiddleBtn;
@property (nonatomic,strong)EFCollectionVM *collectVM;
@end

@implementation EFCollectionViewController


- (void)viewDidLoad {
    self.viewModel = [[EFCollectionVM alloc] init];
    self.lineSpacing = 0;
    self.interitemSpacing = WidthOfScale(10);
    self.itemSize = CGSizeMake(kPHONE_WIDTH, WidthOfScale(155));
    self.registerClasses = @[@{@"SeachOneCollectionViewCell":NSStringFromClass([SeachOneCollectionViewCell class])}];
    [super viewDidLoad];
    self.collectionView.frame = CGRectMake(0, 47, kPHONE_WIDTH,kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT - 47 - TAB_BAR_HEIGHT - 45);
    self.collectionView.tabAnimated = [TABCollectionAnimated animatedWithCellClass:[SeachOneCollectionViewCell class] cellSize:CGSizeMake(kPHONE_WIDTH, WidthOfScale(155))];
    self.collectionView.tabAnimated.canLoadAgain = YES;
    self.collectVM = (EFCollectionVM *)self.viewModel;
    self.view.backgroundColor = UIColor.whiteColor;
    self.isOne = NO;
    self.gk_navigationBar.hidden = YES;
    [self.view addSubview:[self headerView]];
    [self loadCollectionWith:1 sortType:0];
    [self addRefshDown];
}

- (void)loadCollectionWith:(NSInteger )type sortType:(NSInteger )sortType {
    self.collectVM.type = type;
    self.collectVM.sortType = sortType;
    @weakify(self);
    [self.collectionView tab_startAnimationWithCompletion:^{
        [[self.collectVM refreshForDown] subscribeNext:^(RACTuple *x) {
            @strongify(self);
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView tab_endAnimation];
            self.EFData = x.first;
            [self addRefshUp];
            [self reloadDataCompleted:^(EFBaseUICollectionView * _Nonnull collection) {
                [collection reloadData];
            }];
        }];
    }];
}

- (void)loadNewData {
    @weakify(self);
    [self.collectionView tab_stopPullLoading];
    [[self.collectVM refreshForDown] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView tab_endAnimation];
        self.EFData = x.first;
        [self addRefshUp];
        [self.collectionView reloadData];
    }];
}

- (void)loadMoreData {
    @weakify(self);
    [[self.collectVM refreshForUp] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        [self.collectionView.mj_footer endRefreshing];
        self.EFData = x.first;
        [self.collectionView reloadData];
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
    return self.EFData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    if (self.isOne) {
    SeachOneCollectionViewCell *oneCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SeachOneCollectionViewCell class]) forIndexPath:indexPath];
    EFGoodsList *model = self.EFData[indexPath.item];
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
    XYLog(@"dddfd>>>%@",oneCell);
    return oneCell;
    //    }else{
    //        SearchTwoCollectionViewCell *twoCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SearchTwoCollectionViewCell class]) forIndexPath:indexPath];
    //        [twoCell setModel:@""];
    //        return twoCell;
    //    }
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeMake(0, 50);
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return CGSizeMake(0, 0);
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EFGoodsList *model = self.EFData[indexPath.item];
    [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(NO),@"ggNo":model.ggNo}];
}
@end
