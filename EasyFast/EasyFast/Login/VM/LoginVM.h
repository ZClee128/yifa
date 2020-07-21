//
//  LoginVM.h
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseRefreshVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginVM : EFBaseRefreshVM

- (void)getCodeWithBtn:(QMUIButton *)codeBtn;

@end

NS_ASSUME_NONNULL_END
