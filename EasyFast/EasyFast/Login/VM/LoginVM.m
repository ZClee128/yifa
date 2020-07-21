//
//  LoginVM.m
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "LoginVM.h"

@implementation LoginVM

- (void)getCodeWithBtn:(QMUIButton *)codeBtn {
//    [MBProgressHUD showLoadingProgress:@"获取验证码..."];
//    @weakify(self);
    [self intervalTimer:1 intervalBlock:^BOOL(NSDate * _Nonnull date, NSTimeInterval currenctCount) {
        if (currenctCount == 61) {
            [codeBtn setTitle:@"重发验证码" forState:(UIControlStateNormal)];
            codeBtn.enabled = YES;
            return YES;
        }else {
            codeBtn.enabled = NO;
            [codeBtn setTitle:[NSString stringWithFormat:@"%.fs后重发",60-currenctCount] forState:(UIControlStateNormal)];
            return NO;
        }
    }];
}

@end
