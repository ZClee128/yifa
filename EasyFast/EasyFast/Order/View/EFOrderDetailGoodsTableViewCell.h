//
//  EFOrderDetailGoodsTableViewCell.h
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOrderGoodsTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFOrderDetailGoodsTableViewCell : EFOrderGoodsTableViewCell

@property (nonatomic,copy)void(^moreClick)(void);
@end

NS_ASSUME_NONNULL_END