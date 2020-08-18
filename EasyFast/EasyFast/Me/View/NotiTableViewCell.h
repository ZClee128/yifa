//
//  NotiTableViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface NotiTableViewCell : BaseTableViewCell

@property (nonatomic,copy)void(^switchBlock)(BOOL isOn);

@end

NS_ASSUME_NONNULL_END
