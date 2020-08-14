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
#import "EFWxLoginManager.h"



@interface EFThreeLoginTableViewCell () <ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding,WXApiDelegate>

@property (nonatomic,strong)SignInApple *signInApple;


@end

@implementation EFThreeLoginTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kwxLogin object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            [[EFWxLoginManager defaultManager] wxLogin:x withType:1];
        }];
    }
    return self;
}

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
    if (platformType == UMSocialPlatformType_WechatSession) {
        [[EFWxLoginManager defaultManager] sendAuthRequest];
    }else {
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:[UIViewController getCurrentVC] completion:^(id result, NSError *error) {
            UMSocialUserInfoResponse *resp = result;
            // 第三方登录数据(为空表示平台未提供)
            // 授权数据
            XYLog(@" uid: %@", resp.uid);
            XYLog(@" openid: %@", resp.openid);
            XYLog(@" accessToken: %@", resp.accessToken);
            XYLog(@" refreshToken: %@", resp.refreshToken);
            XYLog(@" expiration: %@", resp.expiration);
            // 用户数据
            XYLog(@" name: %@", resp.name);
            XYLog(@" iconurl: %@", resp.iconurl);
            XYLog(@" gender: %@", resp.unionGender);
            // 第三方平台SDK原始数据
            XYLog(@" originalResponse: %@", resp.originalResponse);
        }];
    }
    
}





// 使用系统提供的按钮调用处理授权的方法
- (void)didAppleIDBtnClicked{
    // 封装Sign In with Apple 登录工具类，使用这个类时要把类对象设置为全局变量，或者直接把这个工具类做成单例，如果使用局部变量，和IAP支付工具类一样，会导致苹果回调不会执行
    self.signInApple = [[SignInApple alloc] init];
    [self.signInApple handleAuthorizationAppleIDButtonPress];
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
