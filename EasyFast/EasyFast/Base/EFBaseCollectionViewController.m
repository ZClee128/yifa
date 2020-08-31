//
//  XQCBaseCollectionViewController.m
//  XQC
//
//  Created by anmin on 2019/4/10.
//  Copyright © 2019 xqc. All rights reserved.
//

#import "EFBaseCollectionViewController.h"
#import "EFRefreshHeader.h"
@interface EFBaseCollectionViewController ()

@end

@implementation EFBaseCollectionViewController

- (instancetype)init
{
    if (self = [super init]) {
        _collectionEdgeInsets = UIEdgeInsetsZero;
        _itemSize = CGSizeMake(kPHONE_WIDTH, 44.0f);
        _lineSpacing = 0.0f;
        _interitemSpacing = 0.0f;
        _collectionDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

-(NSMutableArray *)EFData
{
    if (_EFData == nil) {
        _EFData = [[NSMutableArray alloc]init];
    }
    return _EFData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSParameterAssert(self.registerClasses);
    _collectionView = [EFBaseUICollectionView defaultCollectionView:self dataSource:self flowLayout:self.defaultCollectionFlowLayout registerClasses:self.registerClasses];
    [self.view addSubview:self.collectionView];
    [self addEmpty];
    // Do any additional setup after loading the view.
}

- (void)addEmpty {
    @weakify(self);
    self.collectionView.ly_emptyView = [EFEmptyView NoDataEmptybtnClickBlock:^{

    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kNetNoti object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        self.collectionView.ly_emptyView = [EFEmptyView NoNetEmptybtnClickBlock:^{
            @strongify(self);
            [self noNetClick];
        }];
    }];
}

- (void)noNetClick {
    self.collectionView.ly_emptyView = [EFEmptyView NoDataEmptybtnClickBlock:^{

    }];
    [self loadNewData];
}

#pragma mark - Methods

- (void)reloadDataCompleted:(void(^)(EFBaseUICollectionView *collection))completed
{
    [self.collectionView layoutIfNeeded];
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        [[RACScheduler mainThreadScheduler] afterDelay:0.1 schedule:^{
            if (completed) {
                @strongify(self);
                completed(self.collectionView);
            }
        }];
    });
}

#pragma mark - Default FlowLayout

- (UICollectionViewFlowLayout *)defaultCollectionFlowLayout
{
    if (self.collectionView.collectionViewLayout) {
        return (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    }
    UICollectionViewFlowLayout *flowLayout = [EFBaseUICollectionView collectionFlowLayout:self.collectionDirection
                                                                         sectionEdgeInsets:self.collectionEdgeInsets
                                                                                  itemSize:self.itemSize
                                                                        minimumLineSpacing:self.lineSpacing
                                                                   minimumInteritemSpacing:self.interitemSpacing];
    return flowLayout;
}

#pragma mark - Header & Footer

- (void)setCollectionHeaderView:(UIView *)collectionHeaderView
{
    if (_collectionHeaderView) {
        [_collectionHeaderView removeFromSuperview];
        _collectionHeaderView = nil;
    }
    _collectionHeaderView = collectionHeaderView;
    if ([_collectionHeaderView respondsToSelector:@selector(delegate)]) {
        [_collectionHeaderView setValue:self forKey:NSStringFromSelector(@selector(delegate))];
    }
    self.collectionView.contentInset = UIEdgeInsetsMake(_collectionHeaderView.height, 0, 0, 0);
    [self.collectionView addSubview:_collectionHeaderView];
    _collectionHeaderView.y = -_collectionHeaderView.height;
}

- (void)setCollectionFooterView:(UIView *)collectionFooterView
{
    if (_collectionFooterView) {
        [_collectionFooterView removeFromSuperview];
        _collectionFooterView = nil;
    }
    _collectionFooterView = collectionFooterView;
    if ([_collectionFooterView respondsToSelector:@selector(delegate)]) {
        [_collectionFooterView setValue:self forKey:NSStringFromSelector(@selector(delegate))];
    }
    _collectionFooterView.y = self.collectionView.contentSize.height;
    [self.collectionView addSubview:_collectionFooterView];
    self.collectionView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, _collectionFooterView.height, 0.0f);
}


- (void)addRefshDown {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    EFRefreshHeader *header = [EFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置header
    self.collectionView.mj_header = header;
//    [self.EFTableView.mj_header beginRefreshing];
    
}

- (void)loadNewData {
    
}

- (void)addRefshUp {
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    if (self.EFData.count > 0) {
        self.collectionView.mj_footer = footer;
    }
}

- (void)loadMoreData {
    
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
