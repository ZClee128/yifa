//
//  EFCodeLoginTableViewCell.h
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFPhoneLoginTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFCodeLoginTableViewCell : EFPhoneLoginTableViewCell

@property (nonatomic,copy)void(^CodeBlock)(QMUIButton *btn);
@end

NS_ASSUME_NONNULL_END
