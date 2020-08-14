//
//  AppDelegate.h
//  EasyFast
//
//  Created by zclee on 2020/7/9.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EFBaseTabBarViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong)EFBaseTabBarViewController *efTabbar;
@property (nonatomic,assign) BOOL  isOkOnePhone;
@property (nonatomic,assign) BOOL  isOneBindPhone; //首次绑定
@property (nonatomic,strong) NSString  *BindPhoneUid; // 三方登陆首次用户名
@end

