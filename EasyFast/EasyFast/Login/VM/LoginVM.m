//
//  LoginVM.m
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "LoginVM.h"
#import "EFUserModel.h"
#import "EFBindPhoneViewController.h"

@implementation LoginVM

- (void)getCodeWithBtn:(QMUIButton *)codeBtn withType:(NSInteger)type phone:(NSString *)phone{
    @weakify(self);
    [MBProgressHUD showLoadingProgress:@"获取验证码..."];
    [[[FMARCNetwork sharedInstance] sendCode:phone type:type] subscribeNext:^(FMHttpResonse *x) {
        if (x.isSuccess) {
            [[RACScheduler mainThreadScheduler] schedule:^{
                [MBProgressHUD removeProgressFromSuperView];
            }];
            @strongify(self);
            [self startWithStartDate:[NSDate new] finishDate:[NSDate dateWithTimeIntervalSinceNow:60] Btn:codeBtn];
//            [self intervalTimer:1 intervalBlock:^BOOL(NSDate * _Nonnull date, NSTimeInterval currenctCount) {
//                if (currenctCount == 61) {
//                    [codeBtn setTitle:@"重发验证码" forState:(UIControlStateNormal)];
//                    codeBtn.enabled = YES;
//                    return YES;
//                }else {
//                    codeBtn.enabled = NO;
//                    [codeBtn setTitle:[NSString stringWithFormat:@"%.fs后重发",60-currenctCount] forState:(UIControlStateNormal)];
//                    return NO;
//                }
//            }];
        }
    }];
    
}

//此方法用两个NSDate对象做参数进行倒计时
-(void)startWithStartDate:(NSDate *)strtDate finishDate:(NSDate *)finishDate Btn:(QMUIButton *)codeBtn{
    CountDown *time = [[CountDown alloc] init];
    [time countDownWithStratDate:strtDate finishDate:finishDate completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        NSLog(@"second = %li",second);
        NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
        if (totoalSecond==0) {
            codeBtn.enabled = YES;
            [codeBtn setTitle:@"重发验证码" forState:UIControlStateNormal];
        }else{
            codeBtn.enabled = NO;
            [codeBtn setTitle:[NSString stringWithFormat:@"%lis后重发",totoalSecond] forState:UIControlStateNormal];
        }
        
    }];
}

+ (RACSignal *)userLogin:(NSString *)account code:(NSString *)code loginToken:(NSString *)loginToken password:(NSString *)password phone:(NSString *)phone type:(NSInteger)type {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] userLogin:account code:code loginToken:loginToken password:password phone:phone type:type];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        if (result.isSuccess) {
            EFUserModel *model = [EFUserModel modelWithJSON:result.reqResult];
            [[UserManager defaultManager] saveUserModel:model];
            [model bg_saveOrUpdate];
            XYLog(@"model = >%@",model);
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginNoti object:nil];
        }
        return @(result.isSuccess);
    }];
}

+ (RACSignal *)userregister:(NSString *)phone code:(NSString *)code {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] userregister:phone code:code];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        if (result.isSuccess) {
            EFUserModel *model = [EFUserModel modelWithJSON:result.reqResult];
            [[UserManager defaultManager] saveUserModel:model];
            [model bg_saveOrUpdate];
            XYLog(@"model = >%@",model);
        }
        return @(result.isSuccess);
    }];
}

+ (RACSignal *)loginOut {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] loginOut];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        for (EFUserModel *model in [EFUserModel bg_findAll:nil]) {
            if ([model.username isEqualToString:kUserManager.userModel.username]) {
                model.isLogin = NO;
                model.token = @"";
                [model bg_saveOrUpdate];
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginNoti object:nil];
        [[UIViewController getCurrentVC].navigationController qmui_popToRootViewControllerAnimated:NO completion:^{
        }];
        kAppDelegate.efTabbar.selectedIndex = 0;
        return @(result.isSuccess);
    }];
}


+ (RACSignal *)unbindPhone:(NSString *)phone code:(NSString *)code {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] unbindPhone:phone code:code];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return @(result.isSuccess);
    }];
}

+ (RACSignal *)bindingPhone:(NSString *)phone type:(NSInteger)type loginToken:(NSString *)loginToken code:(NSString *)code verifyToken:(NSString *)verifyToken oldPhone:(NSString *)oldPhone {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] bindingPhone:phone type:type loginToken:loginToken code:code verifyToken:verifyToken oldPhone:oldPhone];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        if (result.isSuccess) {
            for (EFUserModel *model in [EFUserModel bg_findAll:nil]) {
                if ([model.username isEqualToString:kUserManager.userModel.username]) {
                    model.phone = result.reqResult[@"phone"];
                    [model bg_saveOrUpdate];
                }
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kChangePhone object:nil];
        }
        return @(result.isSuccess);
    }];
}


+ (RACSignal *)verifyMessage:(NSString *)code phone:(NSString *)phone type:(NSInteger)type {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] verifyMessage:code phone:phone type:type];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return @(result.isSuccess);
    }];
}

+ (RACSignal *)thirdLoginType:(NSInteger)type city:(NSString *)city province:(NSString *)province headImgUrl:(NSString *)headImgUrl nickname:(NSString *)nickname openid:(NSString *)openid  sex:(NSInteger)sex uid:(NSString *)uid unionid:(NSString *)unionid {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] thirdLoginType:type city:city province:province headImgUrl:headImgUrl nickname:nickname openid:openid sex:sex uid:uid unionid:unionid];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        if (result.isSuccess) {
            EFUserModel *model = [EFUserModel modelWithJSON:result.reqResult];
            if (model.isPhone) {
                [[UserManager defaultManager] saveUserModel:model];
                [model bg_saveOrUpdate];
                XYLog(@"model = >%@",model);
                [JVERIFICATIONService dismissLoginControllerAnimated:YES completion:^{
                    
                }];
                [[NSNotificationCenter defaultCenter] postNotificationName:kLoginNoti object:nil];
            }else {
                kAppDelegate.isOneBindPhone = YES;
                kAppDelegate.BindPhoneUid = result.reqResult[@"username"];
                EFBindPhoneViewController *bind = [[EFBindPhoneViewController alloc] init];
                bind.hidesBottomBarWhenPushed = YES;
                [[UIViewController getCurrentVC].navigationController qmui_pushViewController:bind animated:YES completion:^{
                    
                }];
            }
        }
        return @(result.isSuccess);
    }];
}

+ (RACSignal *)thirdLoginBindingMessage:(NSString *)code phone:(NSString *)phone {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] thirdLoginBindingMessage:code phone:phone];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        if (result.isSuccess) {
            EFUserModel *model = [EFUserModel modelWithJSON:result.reqResult];
            [[UserManager defaultManager] saveUserModel:model];
            [model bg_saveOrUpdate];
            XYLog(@"model = >%@",model);
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginNoti object:nil];
        }
        return @(result.isSuccess);
    }];
}

+ (RACSignal *)bindingWechatType:(NSInteger)type city:(NSString *)city province:(NSString *)province headImgUrl:(NSString *)headImgUrl nickname:(NSString *)nickname openid:(NSString *)openid  sex:(NSInteger)sex uid:(NSString *)uid unionid:(NSString *)unionid {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] bindingWechatType:type city:city province:province headImgUrl:headImgUrl nickname:nickname openid:openid sex:sex uid:uid unionid:unionid];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        if (result.isSuccess) {
            for (EFUserModel *model in [EFUserModel bg_findAll:nil]) {
                if ([model.username isEqualToString:kUserManager.userModel.username]) {
                    model.isWeChat = 1;
                    model.wxname = nickname;
                    [model bg_saveOrUpdate];
                }
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kwxBing object:nil];
        }
        return @(result.isSuccess);
    }];
}

+ (RACSignal *)setNewPasswordNewPassword:(NSString *)password confirmPassword:(NSString *)confirmPassword {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] setNewPasswordNewPassword:password confirmPassword:confirmPassword];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return @(result.isSuccess);
    }];
}
@end
