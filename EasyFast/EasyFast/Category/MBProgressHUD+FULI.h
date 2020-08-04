//
//  MBProgressHUD+FULI.h
//  FULI
//
//  Created by huangwenwu on 2019/4/2.
//  Copyright © 2019 FULI. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSUInteger, kFULIProgressHUDStyle) {
    
    kFULIProgressHUDStyleSuccess     = 32345,    //成功
    kFULIProgressHUDStyleFailure,                //失败
    kFULIProgressHUDStyleLoading,                //加载中
    kFULIProgressHUDStyleAlert,                  //中性提示框
    kFULIProgressHUDStyleToast,                  //传统的toast提示
    
};

NS_ASSUME_NONNULL_BEGIN
// 统一的显示时长
#define kHudShowTime                1.5

@interface MBProgressHUD (FULI)

#pragma mark 在指定的view上显示hud
+ (void)showMessage:(NSString *)message toView:(UIView *__nullable)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *__nullable)view;
+ (void)showError:(NSString *)error toView:(UIView *__nullable)view;
+ (void)showWarning:(NSString *)Warning toView:(UIView *__nullable)view;
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message toView:(UIView *__nullable)view;
+ (MBProgressHUD *)showActivityMessage:(NSString*)message view:(UIView *__nullable)view;
+ (MBProgressHUD *)showProgressBarToView:(UIView *__nullable)view;


#pragma mark 在window上显示hud
+ (void)showMessage:(NSString *)message;
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (void)showWarning:(NSString *)Warning;
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message;
+ (MBProgressHUD *)showActivityMessage:(NSString*)message;


#pragma mark 移除hud
+ (void)hideHUDForView:(UIView *__nullable)view;
+ (void)hideHUD;

#pragma mark - Custom
+ (void)showLoadingProgress;
+ (void)showLoadingProgress:(NSString *)message;
+ (void)showSuccessProgress:(NSString *)message;
+ (void)showFailureProgress:(NSString *)message;
+ (void)showToastProgress:(NSString *)message;
+ (void)showAlertProgress:(NSString *)message;
+ (void)removeProgressFromSuperView;
+ (void)removeProgressFromSuperView:(UIView *)superView;
+ (void)showLoadingProgressInView:(UIView *)view;
+ (void)showLoadingProgress:(NSString *)message inView:(UIView *)view;
+ (MBProgressHUD *)xqc_showProgressHUD:(kFULIProgressHUDStyle)style inView:(UIView *)view message:(NSString *)message afterDelay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
