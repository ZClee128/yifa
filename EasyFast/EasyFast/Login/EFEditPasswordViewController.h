//
//  EFEditPasswordViewController.h
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFEditPasswordViewController : EFBaseViewController

- (void)setUI;
- (void)nextClick;
@end


@interface EFSetNewPasswordViewController : EFEditPasswordViewController

@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *code;

@end

NS_ASSUME_NONNULL_END
