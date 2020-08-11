//
//  XQCAlertTool.h
//  XQC
//
//  Created by lee on 2019/4/17.
//  Copyright © 2019 xqc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XQCAlertTool : NSObject

/// 返回err就是点击取消按钮
+ (RACSignal *)showAlertTitle:(NSString *)title message:(NSString *)message;

/**
 没有取消按钮的弹窗

 @param title 标题
 @param message 消息
 @return 弹窗
 */
+ (RACSignal *)showAlertNoCancelWithTitle:(NSString *)title message:(NSString *)message;

/**
 window层弹出

 @param title 提示
 @param message 信息
 @param cancleTitle 取消按钮名字
 @param sureTitle 确认按钮名字
 @return 返回err就是点击取消按钮
 */
+ (RACSignal *)showAlertTitle:(NSString *)title message:(NSString *)message cancle:(NSString *)cancleTitle sure:(NSString *)sureTitle;


/**
 viewController 弹出

 @param viewController 要弹出的viewController
 @param title 提示
 @param message 信息
 @param cancleTitle 取消按钮名字
 @param sureTitle 确认按钮名字
 @return 返回err就是点击取消按钮
 */
+ (RACSignal *)showAlertWithController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message cancle:(NSString *)cancleTitle sure:(NSString *)sureTitle;
@end

NS_ASSUME_NONNULL_END
