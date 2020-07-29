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

@interface EFCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic,assign) BOOL isOne;
@property (nonatomic,strong)UICollectionView *collect;
@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,strong)UICollectionViewFlowLayout *flow;

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
        _collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 47, kPHONE_WIDTH,kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT - 47) collectionViewLayout:self.flow];
        _collect.backgroundColor = [UIColor clearColor];
        _collect.delegate = self;
        _collect.dataSource = self;
        _collect.showsHorizontalScrollIndicator = NO;
        _collect.showsVerticalScrollIndicator = NO;
        _collect.contentInset = UIEdgeInsetsMake(0,0,0,0);
//        [_collect registerClass:[SearchTwoCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SearchTwoCollectionViewCell class])];
        [_collect registerClass:[SeachOneCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SeachOneCollectionViewCell class])];
    }
    return _collect;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.isOne = NO;
    self.gk_navigationBar.hidden = YES;
    [self.view addSubview:[self headerView]];
    [self.view addSubview:self.collect];
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
    [leftBtn setTitle:@"时间" forState:(UIControlStateSelected)];
    [leftBtn setImage:UIImageMake(@"up") forState:(UIControlStateNormal)];
    [leftBtn setImage:UIImageMake(@"down") forState:(UIControlStateSelected)];
    leftBtn.titleLabel.font = RegularFont15;
    [leftBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
    [leftBtn setTitleColor:colorF14745 forState:(UIControlStateSelected)];
    [[leftBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
        x.selected = !x.selected;
    }];
    leftBtn.imagePosition = QMUIButtonImagePositionRight;
    
    QMUIButton *MiddleBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    MiddleBtn.titleLabel.font = RegularFont15;
    [MiddleBtn setTitle:@"价格" forState:(UIControlStateNormal)];
    [MiddleBtn setTitle:@"价格" forState:(UIControlStateSelected)];
    [MiddleBtn setImage:UIImageMake(@"up") forState:(UIControlStateNormal)];
    [MiddleBtn setImage:UIImageMake(@"down") forState:(UIControlStateSelected)];
    [MiddleBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
    [MiddleBtn setTitleColor:colorF14745 forState:(UIControlStateSelected)];
    [[MiddleBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
        x.selected = !x.selected;
    }];
    MiddleBtn.imagePosition = QMUIButtonImagePositionRight;
    
    
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
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    if (self.isOne) {
    SeachOneCollectionViewCell *oneCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SeachOneCollectionViewCell class]) forIndexPath:indexPath];
    [oneCell setModel:@""];
    [oneCell setBtnStyle];
    return oneCell;
    //    }else{
    //        SearchTwoCollectionViewCell *twoCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SearchTwoCollectionViewCell class]) forIndexPath:indexPath];
    //        [twoCell setModel:@""];
    //        return twoCell;
    //    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}
@end
