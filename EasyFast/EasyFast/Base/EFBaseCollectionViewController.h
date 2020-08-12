//
//  XQCBaseCollectionViewController.h
//  XQC
//
//  Created by anmin on 2019/4/10.
//  Copyright © 2019 xqc. All rights reserved.
//

#import "EFBaseViewController.h"
#import "EFBaseUICollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFBaseCollectionViewController : EFBaseViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong, readonly) EFBaseUICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *EFData;
#pragma mark - 请在[super viewDidLoad]执行前配置好
@property (nonatomic, assign) UIEdgeInsets collectionEdgeInsets;                                    //collectionView上下左右四个边距
@property (nonatomic, assign) CGSize itemSize;                                                      //item的size
@property (nonatomic, assign) CGFloat lineSpacing;                                                  //行间距
@property (nonatomic, assign) CGFloat interitemSpacing;                                             //块间距
@property (nonatomic, assign) UICollectionViewScrollDirection collectionDirection;                  //滚动方向
@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSString *> *> *registerClasses;     //注册的类,格式:@[@{@"注册的key" : @"注册的类名"}, ...]

#pragma mark - 以下属性无使用限制
@property (nonatomic, strong, setter=setCollectionHeaderView:) UIView *collectionHeaderView;
@property (nonatomic, strong, setter=setCollectionFooterView:) UIView *collectionFooterView;

- (UICollectionViewFlowLayout *)defaultCollectionFlowLayout;
- (void)reloadDataCompleted:(void(^)(EFBaseUICollectionView *collection))completed;                //重绘制

- (void)addRefshDown;
- (void)loadNewData;
- (void)addRefshUp;
- (void)loadMoreData;
@end

NS_ASSUME_NONNULL_END
