//
//  EFAddressTableViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFAddressTableViewCell : BaseTableViewCell

@property (nonatomic,copy)void(^deletBlcok)(void);
@property (nonatomic,copy)void(^editBlock)(void);
@property (nonatomic,copy)void(^defBlock)(QMUIButton *btn,QMUILabel *lab);

- (CGFloat)getCellHeight;

@end

NS_ASSUME_NONNULL_END
