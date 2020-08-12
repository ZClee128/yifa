//
//  XQCBaseUICollectionView.m
//  XQC
//
//  Created by anmin on 2019/4/11.
//  Copyright © 2019 xqc. All rights reserved.
//

#import "EFBaseUICollectionView.h"

@implementation EFBaseUICollectionView

+ (instancetype)defaultCollectionView:(id<UICollectionViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)dataSource flowLayout:(UICollectionViewFlowLayout *)flowLayout registerClasses:(NSArray<NSDictionary<NSString *, NSString *> *> *)classes
{
    EFBaseUICollectionView *collectionView = [[EFBaseUICollectionView alloc] initWithFrame:CGRectMake(0.0f, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, (kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT)) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = UIColor.clearColor;
    collectionView.delegate = delegate;
    collectionView.dataSource = dataSource;
    collectionView.bounces = YES;
    collectionView.alwaysBounceVertical=YES;
    for (NSDictionary *registerClass in classes) {
        Class class = NSClassFromString(registerClass.allValues.firstObject);
        NSString *forKey = registerClass.allKeys.firstObject;
        [collectionView registerClass:class forCellWithReuseIdentifier:forKey];
    }
    return collectionView;
} 

+ (UICollectionViewFlowLayout *)collectionFlowLayout:(UICollectionViewScrollDirection)direction sectionEdgeInsets:(UIEdgeInsets)insets itemSize:(CGSize)size minimumLineSpacing:(CGFloat)lineSpacing minimumInteritemSpacing:(CGFloat)interitemSpacting
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = direction;
    flowLayout.sectionInset = insets;
    flowLayout.itemSize = size;
    flowLayout.minimumLineSpacing = lineSpacing;
    flowLayout.minimumInteritemSpacing = interitemSpacting;
    
    return flowLayout;
}

@end
