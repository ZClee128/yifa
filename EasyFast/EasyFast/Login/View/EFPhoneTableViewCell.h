//
//  EFPhoneTableViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFPhoneTableViewCell : BaseTableViewCell

@property (nonatomic,copy)void(^TextValue)(NSString *text);
@property (nonatomic,strong)QMUITextField *phoneTextField;
- (RACSignal *)phoneSignal;
@end

NS_ASSUME_NONNULL_END
