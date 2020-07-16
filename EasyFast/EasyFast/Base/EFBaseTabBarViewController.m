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
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    UIOffset titlePositionAdjustment = UIOffsetMake(0, -3.5);
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
    [EFPlusButton registerPlusButton];
    _tabbarheight = 75 + TAB_SAFE_HEIGHT;
    [self clearTabBarTopLine];
    TabbarBackView *tabBarView = [[TabbarBackView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, _tabbarheight)];
    tabBarView.backgroundColor = [UIColor whiteColor];
    [self.tabBar addSubview:tabBarView];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGRect frame = self.tabBar.frame;
    frame.size.height = _tabbarheight;
    frame.origin.y = self.view.frame.size.height - frame.size.height;
    self.tabBar.frame = frame;

    self.tabBar.barStyle = UIBarStyleDefault;
    for (int i=0; i<self.tabBar.items.count; i++) {
        UITabBarItem *item = self.tabBar.items[i];
        if (i!=2) {
            item.imageInsets = UIEdgeInsetsMake(_tabbarheight - TAB_BAR_HEIGHT - 15, 0, -(_tabbarheight - TAB_BAR_HEIGHT - 15), 0);
            item.titlePositionAdjustment = UIOffsetMake(0, -3);

        }else{
            item.imageInsets = UIEdgeInsetsMake(-5, 0, 5, 0);
            item.titlePositionAdjustment = UIOffsetMake(0, -3);

        }
    }
}

#pragma mark - 清除底部菜单栏上面自带的线，以便自定义
-(void)clearTabBarTopLine{
    CGRect rect = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorRef  clearColor =[[UIColor clearColor] CGColor];
    CGContextSetFillColor(context, CGColorGetComponents(clearColor));
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.tabBar.backgroundImage = img;
    self.tabBar.shadowImage = img;
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
//    [self hideTabBarShadowImageView];
    [self rootWindow].backgroundColor = UIColor.whiteColor;
//    self.tabBar.backgroundColor = UIColor.whiteColor;
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
//        [standardAppearance setBackgroundImage:[UIImage imageNamed:@"tab"]];
        self.tabBar.standardAppearance = standardAppearance;
    } else {
        // Override point for customization after application launch.
        // set the text Attributes
        // 设置文字属性
        UITabBarItem *tabBar = [UITabBarItem appearance];
        [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
        [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
//        [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tab"]];
        // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
//         [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab"]];
//        [[UITabBar appearance] setShadowImage:[[self class] imageWithColor:RGB16(0xf5f5f5) size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 3)]];
    }
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



@end
