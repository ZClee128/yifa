//
//  EFThreeLoginTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFThreeLoginTableViewCell.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "SignInApple.h"



@interface EFThreeLoginTableViewCell () <ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>

@property (nonatomic,strong)SignInApple *signInApple;


@end

@implementation EFThreeLoginTableViewCell



- (void)setUI{
    
    NSMutableArray *titles = [@[@"wechat",@"weibo",@"qq"] mutableCopy];
    CGFloat left = (kPHONE_WIDTH - titles.count*WidthOfScale(50) - (titles.count - 1)*WidthOfScale(30)) / 2;
    QMUILabel *topLab = [[QMUILabel alloc] init];
    topLab.font = RegularFont13;
    topLab.textColor = RGB16(0xdbdbdb);
    topLab.text = @"使用其他账号登录";
    topLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:topLab];
    [topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(95.5)));
        make.centerX.equalTo(self.contentView);
        make.height.equalTo(@(WidthOfScale(12.5)));
    }];
    
    // 使用系统提供的按钮，要注意不支持系统版本的处理
    if (@available(iOS 13.0, *)) {
        // Sign In With Apple Button
        ASAuthorizationAppleIDButton *appleIDBtn = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeDefault style:ASAuthorizationAppleIDButtonStyleWhite];
        //    appleBtn.cornerRadius = 22.f;
        [appleIDBtn addTarget:self action:@selector(didAppleIDBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [titles addObject:@"apple"];
        left = (kPHONE_WIDTH - titles.count*WidthOfScale(50) - (titles.count - 1)*WidthOfScale(30)) / 2;
        [self.contentView addSubview:appleIDBtn];
        [appleIDBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topLab.mas_bottom).equalTo(@(WidthOfScale(20)));
            make.left.equalTo(@(left+3*(WidthOfScale(50)+WidthOfScale(30))));
            make.size.mas_equalTo(CGSizeMake(WidthOfScale(50), WidthOfScale(50)));
        }];
        [appleIDBtn layoutIfNeeded];
        appleIDBtn.layer.borderWidth = 1;
        appleIDBtn.layer.borderColor = RGB16(0xe8e3e3).CGColor;
        appleIDBtn.layer.cornerRadius = WidthOfScale(50)/2;
        appleIDBtn.layer.masksToBounds = YES;
    }
    
    for (int i = 0 ; i < titles.count; i++) {
        QMUIButton *btn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        if (![titles[i] isEqualToString:@"apple"]) {
            [btn setBackgroundImage:UIImageMake(titles[i]) forState:(UIControlStateNormal)];
            btn.tag = i;
            [self.contentView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(topLab.mas_bottom).equalTo(@(WidthOfScale(20)));
                make.left.equalTo(@(left+i*(WidthOfScale(50)+WidthOfScale(30))));
                make.size.mas_equalTo(CGSizeMake(WidthOfScale(50), WidthOfScale(50)));
            }];
            [[btn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
                UMSocialPlatformType type;
                if (x.tag == 0) {
                    type = UMSocialPlatformType_WechatSession;
                }else if (x.tag == 1) {
                    type = UMSocialPlatformType_Sina;
                }else {
                    type = UMSocialPlatformType_QQ;
                }
//                @strongify(self);
                [self getUserInfoForPlatform:type];
            }];
        }
    }
    
}

- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    XYLog(@">>>>>>>");
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:[UIViewController getCurrentVC] completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *resp = result;
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];
}

// 自己用UIButton按钮调用处理授权的方法
- (void)didCustomBtnClicked{
    // 封装Sign In with Apple 登录工具类，使用这个类时要把类对象设置为全局变量，或者直接把这个工具类做成单例，如果使用局部变量，和IAP支付工具类一样，会导致苹果回调不会执行
    self.signInApple = [[SignInApple alloc] init];
    [self.signInApple handleAuthorizationAppleIDButtonPress];
}

// 使用系统提供的按钮调用处理授权的方法
- (void)didAppleIDBtnClicked{
    // 封装Sign In with Apple 登录工具类，使用这个类时要把类对象设置为全局变量，或者直接把这个工具类做成单例，如果使用局部变量，和IAP支付工具类一样，会导致苹果回调不会执行
    self.signInApple = [[SignInApple alloc] init];
    [self.signInApple handleAuthorizationAppleIDButtonPress];
}

// 处理授权
- (void)handleAuthorizationAppleIDButtonPress{
    NSLog(@"////////");

    if (@available(iOS 13.0, *)) {
        // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        // 创建新的AppleID 授权请求
        ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
        // 在用户授权期间请求的联系信息
        appleIDRequest.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[appleIDRequest]];
        // 设置授权控制器通知授权请求的成功与失败的代理
        authorizationController.delegate = self;
        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
        authorizationController.presentationContextProvider = self;
        // 在控制器初始化期间启动授权流
        [authorizationController performRequests];
    }else{
        // 处理不支持系统版本
        NSLog(@"该系统版本不可用Apple登录");
    }
}


#pragma mark - delegate
//@optional 授权成功地回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)){
    NSLog(@"授权完成:::%@", authorization.credential);
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", controller);
    NSLog(@"%@", authorization);

    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        // 用户登录使用ASAuthorizationAppleIDCredential
        ASAuthorizationAppleIDCredential *appleIDCredential = authorization.credential;
        NSString *user = appleIDCredential.user;
        // 使用过授权的，可能获取不到以下三个参数
        NSString *familyName = appleIDCredential.fullName.familyName;
        NSString *givenName = appleIDCredential.fullName.givenName;
        NSString *email = appleIDCredential.email;

        NSData *identityToken = appleIDCredential.identityToken;
        NSData *authorizationCode = appleIDCredential.authorizationCode;

        // 服务器验证需要使用的参数
        NSString *identityTokenStr = [[NSString alloc] initWithData:identityToken encoding:NSUTF8StringEncoding];
        NSString *authorizationCodeStr = [[NSString alloc] initWithData:authorizationCode encoding:NSUTF8StringEncoding];
        NSLog(@"%@\n\n%@", identityTokenStr, authorizationCodeStr);

        // Create an account in your system.
        // For the purpose of this demo app, store the userIdentifier in the keychain.
        //  需要使用钥匙串的方式保存用户的唯一信息
//        [YostarKeychain save:KEYCHAIN_IDENTIFIER(@"userIdentifier") data:user];

    }else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]){
        // 这个获取的是iCloud记录的账号密码，需要输入框支持iOS 12 记录账号密码的新特性，如果不支持，可以忽略
        // Sign in using an existing iCloud Keychain credential.
        // 用户登录使用现有的密码凭证
        ASPasswordCredential *passwordCredential = authorization.credential;
        // 密码凭证对象的用户标识 用户的唯一标识
        NSString *user = passwordCredential.user;
        // 密码凭证对象的密码
        NSString *password = passwordCredential.password;

    }else{
        NSLog(@"授权信息均不符");

    }
}

// 授权失败的回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)){
    // Handle error.
    NSLog(@"Handle error：%@", error);
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"用户取消了授权请求";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"授权请求失败";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"授权请求响应无效";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"未能处理授权请求";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"授权请求失败未知原因";
            break;

        default:
            break;
    }

    NSLog(@"%@", errorMsg);
}

// 告诉代理应该在哪个window 展示内容给用户
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)){
    NSLog(@"88888888888");
    // 返回window
    return [UIApplication sharedApplication].windows.lastObject;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
