//
//  EFPlusButton.m
//  EasyFast
//
//  Created by zclee on 2020/7/13.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFPlusButton.h"

@interface EFPlusButton()
{
    CGFloat _buttonImageHeight;
}

@end

@implementation EFPlusButton

+ (void)load {
    //请在 `-[AppDelegate application:didFinishLaunchingWithOptions:]` 中进行注册，否则iOS10系统下存在Crash风险。
    //[super registerPlusButton];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

//上下结构的 button
//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//    // 控件大小,间距大小
//    // 注意：一定要根据项目中的图片去调整下面的0.7和0.9，Demo之所以这么设置，因为demo中的 plusButton 的 icon 不是正方形。
//    CGFloat const imageViewEdgeWidth   = self.bounds.size.width ;
//    CGFloat const imageViewEdgeHeight  = imageViewEdgeWidth ;
//
//    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
//    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
//    CGFloat const verticalMargin  = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight) * 0.8;
//
//    // imageView 和 titleLabel 中心的 Y 值
//    CGFloat  centerOfImageView  = verticalMargin + imageViewEdgeHeight * 0.5 + 3;
//    CGFloat  centerOfTitleLabel = imageViewEdgeHeight  + verticalMargin * 2 + labelLineHeight * 0.5 - 1;
//
//    if ((iPhoneX && !IOS13) || ([QMUIHelper is47InchScreen])) {
//        centerOfImageView = centerOfImageView - 4;
//        centerOfTitleLabel = centerOfTitleLabel - 10 + 1;
//    }
//    
//    if ([QMUIHelper is40InchScreen]) {
//        centerOfImageView = centerOfImageView - 10;
//        centerOfTitleLabel = centerOfTitleLabel -16 + 1;
//    }
//    
//    if ([QMUIHelper is55InchScreen]) {
//        centerOfImageView = centerOfImageView - 7 ;
//        centerOfTitleLabel = centerOfTitleLabel - 16 + 1;
//    }
//    //imageView position 位置
//    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
//    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
//    
//
//    //title position 位置
//    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
//    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
//}

#pragma mark -
#pragma mark - CYLPlusButtonSubclassing Methods

/*
 *
 Create a custom UIButton with title and add it to the center of our tab bar
 *
 */
+ (id)plusButton {
    QMUIButton *button = [[QMUIButton alloc] init];
    UIImage *normalButtonImage = [UIImage imageNamed:@"tuan"];
    UIImage *hlightButtonImage = [UIImage imageNamed:@"tuan"];
    [button setImage:normalButtonImage forState:UIControlStateNormal];
    [button setImage:[hlightButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    [button setImage:[hlightButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [button setTitle:@"团购批发" forState:(UIControlStateNormal)];
    [button setTitle:@"团购批发" forState:(UIControlStateHighlighted)];
    [button setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
    [button setTitleColor:tabbarRedColor forState:(UIControlStateSelected)];
//    button.imageEdgeInsets = UIEdgeInsetsMake(WidthOfScale(3.5), WidthOfScale(2), WidthOfScale(-3.5), WidthOfScale(2));
    button.imagePosition = QMUIButtonImagePositionTop;
    button.titleLabel.font = RegularFont11;
    [button sizeToFit]; // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
//    button.frame = CGRectMake(0.0, 0.0, WidthOfScale(60), normalButtonImage.size.height+20);
//    if ([QMUIHelper is55InchScreen]) {
//        button.frame = CGRectMake(0.0, 0.0, WidthOfScale(60), normalButtonImage.size.height+30);
//    }
    button.backgroundColor = UIColor.whiteColor;
    // if you use `+plusChildViewController` , do not addTarget to plusButton.
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    
    EFPlusButton *bg = [[EFPlusButton alloc] initWithFrame:CGRectMake(0.0, 0.0, kPHONE_WIDTH/5, WidthOfScale(69.5))];
    [bg addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg);
        make.top.equalTo(@(0));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(51),WidthOfScale(69.5)));
    }];
    [button layoutIfNeeded];
    [button AddImage2PiRadiusBorderWithColor:UIColor.whiteColor lineWidth:5 radius:20];
    return bg;
}

/*
 *
 Create a custom UIButton without title and add it to the center of our tab bar
 *
 */
//+ (id)plusButton
//{
//
//    UIImage *buttonImage = [UIImage imageNamed:@"hood.png"];
//    UIImage *highlightImage = [UIImage imageNamed:@"hood-selected.png"];
//
//    CYLPlusButtonSubclass* button = [CYLPlusButtonSubclass buttonWithType:UIButtonTypeCustom];
//
//    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
//    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
//    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
//    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
//
//    return button;
//}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    UIViewController *viewController = tabBarController.selectedViewController;

}


#pragma mark - CYLPlusButtonSubclassing

+ (UIViewController *)plusChildViewController {
    UIViewController *plusChildViewController = [[UIViewController alloc] init];
    plusChildViewController.view.backgroundColor = [UIColor redColor];
    plusChildViewController.navigationItem.title = @"PlusChildViewController";
    UIViewController *plusChildNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:plusChildViewController];
    return plusChildNavigationController;
}

+ (NSUInteger)indexOfPlusButtonInTabBar {
    return 2;
}

+ (BOOL)shouldSelectPlusChildViewController {
    BOOL isSelected = CYLExternPlusButton.selected;
    if (isSelected) {
//        HDLLogDebug("🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is selected");
    } else {
//        HDLLogDebug("🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is not selected");
    }
    return YES;
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.2;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return (CYL_IS_IPHONE_X ? - 6 : 4);
}



@end
