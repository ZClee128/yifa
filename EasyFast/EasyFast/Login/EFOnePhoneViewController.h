//
//  EFOnePhoneViewController.h
//  EasyFast
//
//  Created by zclee on 2020/7/22.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

//绑定手机
@interface EFOnePhoneViewController : EFBaseViewController

- (void)setTitleLabTitle:(NSString *)title;
- (void)setOneBtnTitle:(NSString *)title;
- (void)oneBtnClick;
- (void)changClick;
@end

NS_ASSUME_NONNULL_END
