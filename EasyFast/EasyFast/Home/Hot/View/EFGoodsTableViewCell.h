//
//  EFGoodsTableViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFGoodsTableViewCell : BaseTableViewCell

@property (nonatomic,copy)void(^btnSelect)(void);
- (CGFloat )cellHeight;
@end

NS_ASSUME_NONNULL_END
