//
//  XQCBaseUICollectionView.h
//  XQC
//
//  Created by anmin on 2019/4/11.
//  Copyright © 2019 xqc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EFBaseUICollectionView : UICollectionView

+ (instancetype)defaultCollectionView:(id<UICollectionViewDelegate>)delegate
                           dataSource:(id<UICollectionViewDataSource>)dataSource
                           flowLayout:(UICollectionViewFlowLayout *)flowLayout
                      registerClasses:(NSArray<NSDictionary<NSString *, NSString *> *> *)classes;

+ (UICollectionViewFlowLayout *)collectionFlowLayout:(UICollectionViewScrollDirection)direction
                                   sectionEdgeInsets:(UIEdgeInsets)insets
                                            itemSize:(CGSize)size
                                  minimumLineSpacing:(CGFloat)lineSpacing
                             minimumInteritemSpacing:(CGFloat)interitemSpacting;

@end

NS_ASSUME_NONNULL_END
