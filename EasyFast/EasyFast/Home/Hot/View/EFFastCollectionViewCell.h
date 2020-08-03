//
//  EFFastCollectionViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EFFastCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *goods;
@property (nonatomic,strong)UILabel *priceLab;
@property (nonatomic,strong)LRAnimationProgress *progressView;

- (void)setModel:(id)model;
@end

NS_ASSUME_NONNULL_END
