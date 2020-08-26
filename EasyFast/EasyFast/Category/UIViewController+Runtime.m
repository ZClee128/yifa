//
//  UIViewController+Runtime.m
//  XQC
//
//  Created by anmin on 2019/4/23.
//  Copyright © 2019 xqc. All rights reserved.
//

#import "UIViewController+Runtime.h"
#import <objc/runtime.h>

@implementation UIViewController (Runtime)

+ (void)load
{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"presentViewController:animated:completion:")), class_getInstanceMethod(self.class, NSSelectorFromString(@"myPresentViewController:animated:completion:")));
    });

    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")), class_getInstanceMethod(self.class, NSSelectorFromString(@"exchangedDealloc")));
}

- (void)exchangedDealloc
{
    if ([self respondsToSelector:@selector(viewModel)]) {
        EFBaseViewController *viewController = (EFBaseViewController *)self;
        @autoreleasepool {
            NSLog(@"");
            //            viewController.viewModel = nil;
            [viewController setViewModel:nil];
            NSLog(@"");
        }
    }
    else if ([self isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)self;
        if (![navigationController isKindOfClass:NSClassFromString(@"ZLImageNavigationController")]) {
            @autoreleasepool {
                
                if ([navigationController.topViewController respondsToSelector:@selector(setViewModel:)]) {
                    
                    [(EFBaseViewController *)navigationController.topViewController setViewModel:nil];
                }
            }
        }
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    XYLog(@"%@->ViewController class execute dealloc completed !", self.class);
    [self exchangedDealloc];
}


- (void)myPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    //设置满屏，不需要小卡片
    if(IOS13) {
        viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self myPresentViewController:viewControllerToPresent animated:flag completion:completion];
}

+ (UIViewController *)getCurrentVC {
    
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}

+ (UIViewController *)jsd_getRootViewController{

    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}

+ (UIViewController *)jsd_findVisibleViewController {
    
    UIViewController* currentViewController = [self jsd_getRootViewController];

    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else {
            if ([currentViewController isKindOfClass:[UINavigationController class]]) {
                currentViewController = ((UINavigationController *)currentViewController).visibleViewController;
            } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
                currentViewController = ((UITabBarController* )currentViewController).selectedViewController;
            } else {
                break;
            }
        }
    }
    
    return currentViewController;
}

@end
