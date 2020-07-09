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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%@->ViewController class execute dealloc completed !", self.class);
    [self exchangedDealloc];
}


- (void)myPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    //设置满屏，不需要小卡片
    if(IOS13) {
        viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self myPresentViewController:viewControllerToPresent animated:flag completion:completion];
}


@end
