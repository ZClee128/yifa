//
//  EFOrderBtnTableViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/23.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFOrderBtnTableViewCell : BaseTableViewCell

@property (nonatomic,copy)void(^oneClick)(void);
@property (nonatomic,copy)void(^twoClick)(void);
@property (nonatomic,copy)void(^threeClick)(void);
@property (nonatomic,copy)void(^moreClick)(QMUIButton *x);
@end

NS_ASSUME_NONNULL_END
