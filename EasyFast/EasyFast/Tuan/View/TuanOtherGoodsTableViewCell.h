//
//  TuanOtherGoodsTableViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "EFFootPrint.h"
NS_ASSUME_NONNULL_BEGIN

@interface TuanOtherGoodsTableViewCell : BaseTableViewCell

@property (nonatomic,copy)void(^leftBlock)(void);
@property (nonatomic,copy)void(^rightBlock)(void);

- (void)hiddenRightView;

- (void)showRightView;

- (void)setLeftModel:(EFGoodsList *)model;

- (void)setRightModel:(EFGoodsList *)model;
@end

NS_ASSUME_NONNULL_END
