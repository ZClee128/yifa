//
//  UIViewController+Runtime.h
//  XQC
//
//  Created by anmin on 2019/4/23.
//  Copyright © 2019 xqc. All rights reserved.
//

#import "EFBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Runtime)

+ (UIViewController *)getCurrentVC;
@end

NS_ASSUME_NONNULL_END
