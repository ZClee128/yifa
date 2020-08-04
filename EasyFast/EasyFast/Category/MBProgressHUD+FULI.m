//
//  MBProgressHUD+FULI.m
//  FULI
//
//  Created by admin on 2019/4/2.
//  Copyright © 2019 FULI. All rights reserved.
//

#import "MBProgressHUD+FULI.h"

static MBProgressHUD *progressHUD = nil;
static NSInteger const kFULIProgressHUDSingleForTag = 28363;

@interface FULIProgressContentView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, assign, readonly) kFULIProgressHUDStyle style;

@end

@implementation FULIProgressContentView

- (instancetype)initWithStyle:(kFULIProgressHUDStyle)style message:(NSString *)message
{
    if (self = [super init]) {
        _style = style;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        CGSize size = CGSizeZero;
        if (self.style != kFULIProgressHUDStyleToast) {
            //UIImage *logo1 = [UIImage imageNamed:@{@(kFULIProgressHUDStyleSuccess) : @"icon_success_hud",
                                               //   @(kFULIProgressHUDStyleFailure) : @"icon_failure_hud",
                                                  //@(kFULIProgressHUDStyleLoading) : @"icon_loading_hud",
                                                //  @(kFULIProgressHUDStyleAlert) : @"icon_warning_hud", }[@(style)]];
            UIImage *logo = kGetImage((@{@(kFULIProgressHUDStyleSuccess) : @"icon_success_hud",
                                         @(kFULIProgressHUDStyleFailure) : @"icon_failure_hud",
                                         @(kFULIProgressHUDStyleLoading) : @"icon_loading_hud",
                                         @(kFULIProgressHUDStyleAlert) : @"icon_warning_hud", }[@(style)]));
            size = logo.size;
            self.logoImageView = [[UIImageView alloc] initWithImage:logo highlightedImage:logo];
            [self addSubview:self.logoImageView];
            [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top);
                make.centerX.equalTo(self.mas_centerX);
                make.size.mas_equalTo(size);
            }];
        }
        
        CGFloat bottom = 10.0f;
        CGFloat maxWidth = 270.0f;
        CGFloat left = 19.0f;
        CGFloat maxContentWidth = maxWidth - (left * 2);
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = RegularFont14;
        self.titleLabel.textColor = RGB16(0xFFFFFF);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleLabel setAdaptionText:@{message : @(maxContentWidth)}];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            if (self.logoImageView) {
                make.top.equalTo(self.logoImageView.mas_bottom).offset(bottom);
            } else {
                make.centerY.equalTo(self.mas_centerY);
            }
            make.size.mas_equalTo(self.titleLabel.ceilSize);
        }];
        
        if (style == kFULIProgressHUDStyleLoading && self.logoImageView) {
            [self.logoImageView rotateds];
        }
        self.height = (self.style == kFULIProgressHUDStyleToast ? (self.titleLabel.ceilHeight + bottom) : (size.height + bottom + self.titleLabel.ceilHeight));
        self.width = MIN((self.titleLabel.ceilWidth + left * 2.0f), maxWidth);
    }
    return self;
}

#pragma mark - Load

- (CGSize)intrinsicContentSize
{
    return self.size;
}

@end

//***************************************************************************************************************************************************************

@implementation MBProgressHUD (FULI)

+ (UIView *)keyWindows
{
    return [UIApplication sharedApplication].keyWindow;
}

#pragma mark - Custom

+ (void)showProgress:(kFULIProgressHUDStyle)style message:(NSString *)message afterDelay:(NSTimeInterval)delay
{
    [MBProgressHUD removeProgressFromSuperView];
    [self.class showProgress:style inView:[MBProgressHUD keyWindows] message:message afterDelay:delay];
}

+ (void)showProgress:(kFULIProgressHUDStyle)style inView:(UIView *)view message:(NSString *)message afterDelay:(NSTimeInterval)delay
{
    [MBProgressHUD xqc_showProgressHUD:style inView:view message:message afterDelay:delay];
}

+ (MBProgressHUD *)xqc_showProgressHUD:(kFULIProgressHUDStyle)style inView:(UIView *)view message:(NSString *)message afterDelay:(NSTimeInterval)delay
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [RGB16(0x000000) colorWithAlphaComponent:0.8f];
    hud.mode = MBProgressHUDModeCustomView;
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.graceTime = 1.35f;
    hud.bezelView.layer.cornerRadius = 5.0f;
    hud.customView = [[FULIProgressContentView alloc] initWithStyle:style message:message];
    if (delay > 0) {
        [[RACScheduler mainThreadScheduler] afterDelay:delay schedule:^{
            [MBProgressHUD removeProgressFromSuperView];
        }];
    }
    return hud;
}

+ (void)showLoadingProgress
{
    [self.class showLoadingProgress:@"正在加载..."];
}

+ (void)showLoadingProgressInView:(UIView *)view
{
    [self.class showLoadingProgress:@"正在加载..." inView:view];
}

+ (void)showLoadingProgress:(NSString *)message inView:(UIView *)view
{
    [self.class showProgress:kFULIProgressHUDStyleLoading inView:[MBProgressHUD keyWindows] message:message afterDelay:-1];
}

+ (void)showLoadingProgress:(NSString *)message
{
    [self.class showProgress:kFULIProgressHUDStyleLoading message:message afterDelay:-1];
}

+ (void)showSuccessProgress:(NSString *)message
{
    if (!message.length) {
        return;
    }
    [self.class showProgress:kFULIProgressHUDStyleSuccess message:message afterDelay:kHudShowTime];
}

+ (void)showFailureProgress:(NSString *)message
{
    if (!message.length) {
        return;
    }
    [self.class showProgress:kFULIProgressHUDStyleFailure message:message afterDelay:kHudShowTime];
}

+ (void)showAlertProgress:(NSString *)message
{
    if (!message.length) {
        return;
    }
    [self.class showProgress:kFULIProgressHUDStyleAlert message:message afterDelay:kHudShowTime];
}

+ (void)showToastProgress:(NSString *)message
{
    if (!message.length) {
        return;
    }
    [self.class showProgress:kFULIProgressHUDStyleToast message:message afterDelay:kHudShowTime];
}

+ (void)removeProgressFromSuperView
{
    [self.class removeProgressFromSuperView:MBProgressHUD.keyWindows];
}

+ (void)removeProgressFromSuperView:(UIView *)superView
{
    [MBProgressHUD hideHUDForView:superView animated:YES];
}

#pragma mark 显示一条信息
+ (void)showMessage:(NSString *)message toView:(UIView *__nullable)view
{
    [self show:message icon:nil view:view];
}

#pragma mark 显示带图片或者不带图片的信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *__nullable)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    // 判断是否显示图片
    if (icon == nil) {
        hud.mode = MBProgressHUDModeText;
    }else{
        // 设置图片
//        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]];
        NSString *imgname = [NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon];
        UIImage *img = kGetImage(imgname);
        img = img == nil ? [UIImage imageNamed:icon] : img;
        hud.customView = [[UIImageView alloc] initWithImage:img];
        // 再设置模式
        hud.mode = MBProgressHUDModeCustomView;
    }
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 指定时间之后再消失
    [hud hideAnimated:YES afterDelay:kHudShowTime];
}

#pragma mark 显示成功信息
+ (void)showSuccess:(NSString *)success toView:(UIView *__nullable)view{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *__nullable)view{
    [self show:error icon:@"error.png" view:view];
}

#pragma mark 显示警告信息
+ (void)showWarning:(NSString *)Warning toView:(UIView *__nullable)view{
    [self show:Warning icon:@"warn" view:view];
}

#pragma mark 显示自定义图片信息
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message toView:(UIView *)view{
    [self show:message icon:imageName view:view];
}

#pragma mark 加载中
+ (MBProgressHUD *)showActivityMessage:(NSString*)message view:(UIView *__nullable)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.label.text = message;
    // 细节文字
//        hud.detailsLabelText = @"请耐心等待";
    hud.detailsLabel.text = message;
    // 再设置模式
    hud.mode = MBProgressHUDModeIndeterminate;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

+ (MBProgressHUD *)showProgressBarToView:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.label.text = @"加载中...";
    return hud;
}



+ (void)showMessage:(NSString *)message
{
    [MBProgressHUD showAlertProgress:message];
}

+ (void)showSuccess:(NSString *)success{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error{
    [self showError:error toView:nil];
}

+ (void)showWarning:(NSString *)Warning{
    [self showWarning:Warning toView:nil];
}

+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message{
    [self showMessageWithImageName:imageName message:message toView:nil];
}

+ (MBProgressHUD *)showActivityMessage:(NSString*)message{
    return [self showActivityMessage:message view:nil];
}




+ (void)hideHUDForView:(UIView *__nullable)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD{
    [self hideHUDForView:nil];
}

@end
