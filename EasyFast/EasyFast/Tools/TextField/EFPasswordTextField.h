//
//  EFPasswordTextField.h
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EFPasswordTextField : QMUITextField<QMUITextFieldDelegate>

- (BOOL)deptNumInputShouldNumber:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
