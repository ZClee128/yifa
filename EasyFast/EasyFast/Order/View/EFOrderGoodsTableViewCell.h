//
//  EFOrderGoodsTableViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/23.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFOrderGoodsTableViewCell : BaseTableViewCell

@property(nonatomic,strong)UIImageView *goods;
@property (nonatomic,strong)QMUILabel *goodsNameLab;
@property (nonatomic,strong)QMUILabel *goodsSizeLab;
@property (nonatomic,strong)QMUILabel *goodsPriceLab;
@property (nonatomic,strong)QMUILabel *goodsNumLab;

@end

NS_ASSUME_NONNULL_END
