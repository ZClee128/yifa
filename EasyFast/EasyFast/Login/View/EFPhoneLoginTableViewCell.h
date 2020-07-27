//
//  EFPhoneLoginTableViewCell.h
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFPhoneLoginTableViewCell : BaseTableViewCell

@property (nonatomic,strong)QMUILabel *leftLab;
@property (nonatomic,strong)QMUITextField *phoneTextfield;
@property (nonatomic,copy)void(^TextValue)(NSString *text);
- (void)setPlaceholder:(NSString *)place;
@end

NS_ASSUME_NONNULL_END
