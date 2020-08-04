//
//  EFBaseTabBarViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/9.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseTabBarViewController.h"
#import "EFHomeViewController.h"
#import "EFClassifyViewController.h"
#import "EFFollowViewController.h"
#import "EFMeViewController.h"
#import "EFPlusButton.h"
#import "TabbarBackView.h"
@interface EFBaseTabBarViewController ()
{
    CGFloat _tabbarheight;
}
@end

@implementation EFBaseTabBarViewController

- (instancetype)initWithContext:(NSString *)context {
    /**
     * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
     * 等 效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
     * 更推荐后一种做法。
     */
    UIEdgeInsets imageInsets = UIEdgeInsetsZero; //UIEdgeInsetsMake(0, 0, WidthOfScale(3), 0);
    UIOffset titlePositionAdjustment = UIOffsetMake(0, 0);
    if (self = [super initWithViewControllers:[self viewControllersForTabBar]
                        tabBarItemsAttributes:[self tabBarItemsAttributesForTabBar]
                                  imageInsets:imageInsets
                      titlePositionAdjustment:titlePositionAdjustment
                                      context:context
                ]) {
        [self customizeTabBarAppearanceWithTitlePositionAdjustment:titlePositionAdjustment];
        self.delegate = self;
        self.navigationController.navigationBar.hidden = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [EFPlusButton registerPlusButton];
    
}


- (NSArray *)viewControllersForTabBar {
    EFHomeViewController *firstViewController = [[EFHomeViewController alloc] init];
    UINavigationController *firstNav = [UINavigationController rootVC:firstViewController];
    
    EFClassifyViewController *secondViewController = [[EFClassifyViewController alloc] init];
    UINavigationController *secondNav = [UINavigationController rootVC:secondViewController];

    EFFollowViewController *thirdViewController = [[EFFollowViewController alloc] init];
    UINavigationController *thirdNav = [UINavigationController rootVC:thirdViewController];
    
    EFMeViewController *fourthViewController = [[EFMeViewController alloc] init];
    UINavigationController *fourNav = [UINavigationController rootVC:fourthViewController];
    NSArray *viewControllers = @[
                                 firstNav,
                                 secondNav,
                                 thirdNav,
                                 fourNav
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForTabBar {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"home_def",  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage : @"home_selet",  /* NSString and UIImage are supported*/
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"分类",
                                                  CYLTabBarItemImage : @"class_def",
                                                  CYLTabBarItemSelectedImage : @"class_selet",
                                                  };
    
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"关注",
                                                 CYLTabBarItemImage : @"follow_def",
                                                 CYLTabBarItemSelectedImage : @"follow_selet",
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"我的",
                                                  CYLTabBarItemImage :@"me_def",
                                                  CYLTabBarItemSelectedImage : @"me_selet",
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearanceWithTitlePositionAdjustment:(UIOffset)titlePositionAdjustment {
    // Customize UITabBar height
    // 自定义 TabBar 高度
//     self.tabBarHeight = TAB_BAR_HEIGHT;
    [self hideTabBarShadowImageView];
    [self rootWindow].backgroundColor = UIColor.whiteColor;
    self.tabBar.backgroundColor = UIColor.whiteColor;
//    self.tabBar.shadowImage = [[UIImage alloc] init];
    
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = tabbarBlackColor;
    normalAttrs[NSFontAttributeName] = RegularFont11;
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = tabbarRedColor;
    selectedAttrs[NSFontAttributeName] = RegularFont11;
    
    // NO.1，using Image note:recommended.推荐方式
    // set the bar shadow image
    // without shadow : use -[[CYLTabBarController hideTabBarShadowImageView] in CYLMainRootViewController.m
    if (@available(iOS 13.0, *)) {
        UITabBarItemAppearance *inlineLayoutAppearance = [[UITabBarItemAppearance  alloc] init];
        // fix https://github.com/ChenYilong/CYLTabBarController/issues/456
        inlineLayoutAppearance.normal.titlePositionAdjustment = titlePositionAdjustment;

        // set the text Attributes
        // 设置文字属性
        [inlineLayoutAppearance.normal setTitleTextAttributes:normalAttrs];
        [inlineLayoutAppearance.selected setTitleTextAttributes:selectedAttrs];

        UITabBarAppearance *standardAppearance = [[UITabBarAppearance alloc] init];
        standardAppearance.stackedLayoutAppearance = inlineLayoutAppearance;
        standardAppearance.backgroundColor = UIColor.whiteColor;
//        //shadowColor和shadowImage均可以自定义颜色, shadowColor默认高度为1, shadowImage可以自定义高度.
//        standardAppearance.shadowColor = RGB16(0xf5f5f5);
//         standardAppearance.shadowImage = [[self class] imageWithColor:RGB16(0xf5f5f5) size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)];
//        UIImage *bar =  [UIImage combineImageUpImage:[UIImage imageNamed:@"tab"] DownImage:[UIImage imageWithColor:UIColor.whiteColor size:CGSizeMake(kPHONE_WIDTH, 80*30) cornerRadius:0]];
//        [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor size:CGSizeMake(kPHONE_WIDTH, TAB_BAR_HEIGHT) cornerRadius:0]];
        self.tabBar.standardAppearance = standardAppearance;
        [[UITabBar appearance] setUnselectedItemTintColor:tabbarBlackColor];
    } else {
        // Override point for customization after application launch.
        // set the text Attributes
        // 设置文字属性
        UITabBarItem *tabBar = [UITabBarItem appearance];
        [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
        [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        [UITabBar appearance].backgroundColor = UIColor.whiteColor;
        UIImage *bg =  [UIImage imageWithColor:UIColor.whiteColor size:CGSizeMake(kPHONE_WIDTH, TAB_BAR_HEIGHT) cornerRadius:0];
        [[UITabBar appearance] setBackgroundImage:bg];
//        [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:RGB16(0xf5f5f5) size:CGSizeMake(kPHONE_WIDTH, 1) cornerRadius:0]];
    }
    self.tabBar.layer.shadowColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:0.3].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0,-3);
    self.tabBar.layer.shadowOpacity = 1;
    self.tabBar.layer.shadowRadius = 7;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (BOOL)tabBarController:(UITabBarController*)tabBarController shouldSelectViewController:(UIViewController*)viewController
{
    NSLog(@"viewcontoller===%@",viewController.childViewControllers);
    if ([viewController.childViewControllers[0] isKindOfClass:[EFMeViewController class]]) {
        if (kUserManager.userModel == nil) {
            [EFOnePhoneLoginManager show];
            return NO;
        }
        return YES;
    }
    
    
    
    return YES;
    
}


@end
