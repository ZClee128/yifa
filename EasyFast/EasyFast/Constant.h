//
//  Constant.h
//  flag
//
//  Created by zclee on 2020/5/16.
//  Copyright © 2020 zclee. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

//全局代理
#define kAppDelegate ((AppDelegate*)[UIApplication sharedApplication].delegate)
//主窗口 （keyWindow）
#define kKeyWindow [UIApplication sharedApplication].keyWindow

// h5manager
#define kH5Manager [H5Manager defaultManager]
#define kShareManager [ShareManager defaultManager]
#define kUserManager [UserManager defaultManager]

/// 屏幕宽
#define kPHONE_WIDTH [UIScreen mainScreen].bounds.size.width
/// 屏幕高
#define kPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height

#define iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

//APP版本号
#define kVersion [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]

/// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
/// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)
/// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
/// 安全高度
#define TAB_SAFE_HEIGHT (iPhoneX ? 34.f : 0.f)

#define IOS13 ([[UIDevice currentDevice].systemVersion intValue] >= 13 ? YES : NO)

#define RGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

/// 忽略执行警告
#define HSYCOCOAKIT_IGNORED_SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

/**
 打印日志
 */
#ifdef DEBUG
#define XYLog(FORMAT,...){\
NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
[dateFormatter setDateStyle:NSDateFormatterMediumStyle];\
[dateFormatter setTimeStyle:NSDateFormatterShortStyle];\
[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; \
NSString *str = [dateFormatter stringFromDate:[NSDate date]];\
fprintf(stderr,"[--%s--]\n[--%s:%d--]\n[--%s--]\n===========================\n",[str UTF8String],[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);\
}
#else
#define XYLog(FORMAT,...)
#endif

#define WidthOfScale(x)  (x)*(kPHONE_WIDTH/375.0)
#define HeightOfScale(x) (x)*(kPHONE_HEIGHT/667.0)

#define btnGradation(button,color) \
({[button setBackgroundImage:[UIImage imageWithColor:color size:button.frame.size] forState:(UIControlStateNormal)];\
})

//加载图片
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]


#define udInstance [NSUserDefaults standardUserDefaults]

// color
#define tabbarRedColor RGB16(0xFF3B37)
#define tabbarBlackColor RGB16(0x4D4D4D)
#define colorAEAEAE RGB16(0xAEAEAE)
#define colorEFEFEF RGB16(0xEFEFEF)
#define colorF14745 RGB16(0xF14745)
#define colorfafafa RGB16(0xfafafa)
#define colorFE851E RGB16(0xFE851E)
#define color39342F RGB16(0x39342F)
#define colorFFF9EB RGB16(0xFFF9EB)
#define color499AFF RGB16(0x499AFF)
#define colorFFBD20 RGB16(0xFFBD20)
#define colorFF3838 RGB16(0xFF3838)



// font
#define SemiboldFont26 [UIFont runtimeFitFont:26 weight:(UIFontWeightSemibold)]
#define SemiboldFont20 [UIFont runtimeFitFont:20 weight:(UIFontWeightSemibold)]
#define SemiboldFont18 [UIFont runtimeFitFont:18 weight:(UIFontWeightSemibold)]
#define SemiboldFont16 [UIFont runtimeFitFont:16 weight:(UIFontWeightSemibold)]
#define SemiboldFont14 [UIFont runtimeFitFont:14 weight:(UIFontWeightSemibold)]
#define SemiboldFont17 [UIFont runtimeFitFont:17 weight:(UIFontWeightSemibold)]

#define RegularFont10 [UIFont runtimeFitFont:10 weight:(UIFontWeightRegular)]
#define RegularFont11 [UIFont runtimeFitFont:11 weight:(UIFontWeightRegular)]
#define RegularFont12 [UIFont runtimeFitFont:12 weight:(UIFontWeightRegular)]
#define RegularFont13 [UIFont runtimeFitFont:13 weight:(UIFontWeightRegular)]
#define RegularFont14 [UIFont runtimeFitFont:14 weight:(UIFontWeightRegular)]
#define RegularFont15 [UIFont runtimeFitFont:15 weight:(UIFontWeightRegular)]
#define RegularFont17 [UIFont runtimeFitFont:17 weight:(UIFontWeightRegular)]
#define RegularFont16 [UIFont runtimeFitFont:16 weight:(UIFontWeightRegular)]
#define RegularFont21 [UIFont runtimeFitFont:21 weight:(UIFontWeightRegular)]


#define MedFont17 [UIFont runtimeFitFont:17 weight:(UIFontWeightMedium)]
#define MedFont16 [UIFont runtimeFitFont:16 weight:(UIFontWeightMedium)]
#define MedFont15 [UIFont runtimeFitFont:15 weight:(UIFontWeightMedium)]
#define MedFont12 [UIFont runtimeFitFont:12 weight:(UIFontWeightMedium)]
#define MedFont13 [UIFont runtimeFitFont:13 weight:(UIFontWeightMedium)]
#define MedFont14 [UIFont runtimeFitFont:14 weight:(UIFontWeightMedium)]
#define MedFont30 [UIFont runtimeFitFont:30 weight:(UIFontWeightMedium)]
#define MedFont20 [UIFont runtimeFitFont:20 weight:(UIFontWeightMedium)]

// 持久化key
// 用户信息
#define udUserInfo      @"FGUserDefaultsDefineUserInfo"


// 通知
#define kTabFollow @"TabFollow" //个人中心关注通知
#define knickName @"knickName" //修改昵称
#define kChangePhone @"kChangePhone" //修改手机
#define kChangePassword @"kChangePassword" // 修改密码
#define kAddress @"kAddress" // 新增地址
#define kselectTabBarMe @"kselectTabBarMe" //点击tabbar个人中心通知
#define kLoginNoti @"kLoginNoti"  //退出登录通知
#define kevalWritingOver @"kevalWritingOver" //订单评价通知
#define kreturnApplyOver @"kreturnApplyOver" // 订单售后通知
#define kComfroOrder @"kComfroOrder" // 确认收货通知
#define kwxLogin @"wxLogin" // 微信登录
#define kwxBing @"kwxBing" // 微信绑定成功
#define kclassNoti @"kclassNoti" //跳转分类通知
#define kPaySuccessNoti @"kPaySuccessNoti" //支付结果回调

// 图片
#define kup UIImageMake(@"up") // 降序
#define kdown UIImageMake(@"down") // 升序
#define knormal UIImageMake(@"normal") //正常

// 数据库表名

/// 首页分类
#define kHomeCategory @"HomeCategory"



// 三方
#define kwxappSecret @"bb7ee5e143ad9e83e8d78c868c4e1892"
#define kwxappId @"wx2456b611d95ac358"
#endif /* Constant_h */
