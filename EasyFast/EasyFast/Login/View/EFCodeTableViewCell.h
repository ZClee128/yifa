//
//  EFCodeTableViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFCodeTableViewCell : BaseTableViewCell

@property (nonatomic,copy)void(^TextValue)(NSString *text);
@property (nonatomic,copy)void(^CodeBlock)(QMUIButton *btn);

@property (nonatomic,strong)QMUITextField *codeTextField;

- (RACSignal *)codeSignal;
@end

NS_ASSUME_NONNULL_END
