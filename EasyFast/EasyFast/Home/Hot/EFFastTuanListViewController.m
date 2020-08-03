//
//  EFFastTuanListViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/8/3.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFastTuanListViewController.h"
#import "EFFastTuanListCollectionViewCell.h"

@interface EFFastTuanListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collection;
@property (nonatomic,strong)NSMutableArray *data;

@end

@implementation EFFastTuanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_backImage = [UIImageMake(@"btn_back_black") qmui_imageWithTintColor:UIColor.whiteColor];
    self.gk_navTitle = @"极速拼团";
    self.gk_navTitleColor = UIColor.whiteColor;
    self.gk_navBackgroundColor = UIColor.clearColor;
    self.gk_navLineHidden = YES;
    self.data = [@[@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1] mutableCopy];
    UIImageView *bg = [[UIImageView alloc] initWithImage:UIImageMake(@"fast_bg")];
    [self.view addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(kPHONE_WIDTH));
    }];
    
    [self.view addSubview:[self headerView]];
    
    [self.view addSubview:self.collection];
    
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
    leftBtn.imagePosition = QMUIButtonImagePositionRight;
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(10.5), 0, 0);
    leftBtn.frame = CGRectMake(0, 0, bg.width/2, bg.height);
    [bg addSubview:leftBtn];
    [[leftBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    
    QMUIButton *rightBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [rightBtn setTitle:@"时间最短" forState:(UIControlStateNormal)];
    [rightBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    rightBtn.titleLabel.font = RegularFont15;
    [rightBtn setImage:UIImageMake(@"normal") forState:(UIControlStateNormal)];
    rightBtn.imagePosition = QMUIButtonImagePositionRight;
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(10.5), 0, 0);
    rightBtn.frame = CGRectMake(leftBtn.width, 0, bg.width/2, bg.height);
    [bg addSubview:rightBtn];
    [[rightBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    return bg;
}

-(UICollectionView *)collection
{
    if (_collection == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
        flow.minimumInteritemSpacing = WidthOfScale(10);
        flow.itemSize = CGSizeMake(WidthOfScale(167), flat(WidthOfScale(258)));
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(WidthOfScale(0), NAVIGATION_BAR_HEIGHT + WidthOfScale(40), kPHONE_WIDTH, kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT - WidthOfScale(40)) collectionViewLayout:flow];
        _collection.backgroundColor = [UIColor clearColor];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.showsVerticalScrollIndicator = NO;
        _collection.contentInset = UIEdgeInsetsMake(WidthOfScale(15), WidthOfScale(15), TAB_SAFE_HEIGHT, WidthOfScale(15));
        [_collection registerClass:[EFFastTuanListCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([EFFastTuanListCollectionViewCell class])];
    }
    return _collection;
}



#pragma mark - collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EFFastTuanListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EFFastTuanListCollectionViewCell class]) forIndexPath:indexPath];
    [cell setModel:@""];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
