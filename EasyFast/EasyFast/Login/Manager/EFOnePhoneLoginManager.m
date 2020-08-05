//
//  EFOnePhoneLoginManager.m
//  EasyFast
//
//  Created by easyfast on 2020/8/3.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOnePhoneLoginManager.h"
#import "EFRegAndPswTableViewCell.h"
#import "EFThreeLoginTableViewCell.h"
#import "EFChangeLoginViewController.h"
#import "EFBindPhoneViewController.h"
#import "LoginVM.h"

@implementation EFOnePhoneLoginManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)show {
    if(!kAppDelegate.isOkOnePhone) {
        EFChangeLoginViewController *vc = [[EFChangeLoginViewController alloc] initWithType:NO];
        vc.hidesBottomBarWhenPushed = YES;
        [[UIViewController getCurrentVC].navigationController qmui_pushViewController:vc animated:YES completion:^{
            
        }];
        return;
    }
    [self setUI];
    
    [JVERIFICATIONService getAuthorizationWithController:[UIViewController getCurrentVC] hide:NO animated:YES timeout:5*1000 completion:^(NSDictionary *result) {
        NSLog(@"一键登录 result:%@", result);
        if ([result[@"code"] intValue] == 6000) {
            //                result[@"loginToken"]
            [MBProgressHUD showAlertProgress:@"登录中..."];
            [[LoginVM userLogin:@"" code:@"" loginToken:result[@"loginToken"] password:@"" phone:@"" type:3] subscribeNext:^(NSNumber *x) {
                [MBProgressHUD hideHUD];
                if ([x boolValue]) {
                    [JVERIFICATIONService dismissLoginControllerAnimated:YES completion:^{
                        
                    }];
                }
            }];
        }
    } actionBlock:^(NSInteger type, NSString *content) {
        if (type == 8) {
            
        }
    }];
}

+ (void)showBindPhone {
    if(!kAppDelegate.isOkOnePhone) {
        NSLog(@"当前网络环境不支持认证！");
        EFBindPhoneViewController *bind = [[EFBindPhoneViewController alloc] init];
        bind.hidesBottomBarWhenPushed = YES;
        [[UIViewController getCurrentVC].navigationController qmui_pushViewController:bind animated:YES completion:^{
            
        }];
        return;
    }
    [self setBindPhoneUI];
    
    [JVERIFICATIONService getAuthorizationWithController:[UIViewController getCurrentVC] hide:NO animated:YES timeout:5*1000 completion:^(NSDictionary *result) {
        NSLog(@"一键登录 result:%@", result);
        if ([result[@"code"] intValue] == 6000) {
            [JVERIFICATIONService getToken:5000 completion:^(NSDictionary *verifyresult) {
                if ([verifyresult[@"code"] intValue] == 2000) {
                    [[LoginVM bindingPhone:@"" type:2 loginToken:result[@"loginToken"] code:@"" verifyToken:verifyresult[@"token"] oldPhone:kUserManager.userModel.phone] subscribeNext:^(NSNumber *x) {
                        if ([x boolValue]) {
                            [JVERIFICATIONService dismissLoginControllerAnimated:YES completion:^{
                                
                            }];
                        }
                    }];
                }
            }];
        }
    } actionBlock:^(NSInteger type, NSString *content) {
        
    }];
}

+ (void)setUI {
    JVUIConfig *config = [[JVUIConfig alloc] init];
    config.navCustom = YES;
    
    config.shouldAutorotate = NO;
    config.autoLayout = YES;
    config.privacyState = YES;
    //    config.orientation =  UIInterfaceOrientationPortrait;
    config.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    config.navReturnHidden = NO;
    config.numberFont = MedFont30;
    config.logBtnText = @"本机号码一键登录";
    config.logBtnFont = RegularFont17;
    UIImage *image = [[UIImage imageWithMixColors:@[RGB16(0xFFBD20),RGB16(0xFF3838)] size:CGSizeMake(WidthOfScale(300), WidthOfScale(50))] qmui_imageWithClippedCornerRadius:WidthOfScale(50)/2];
    config.logBtnImgs = @[image,image,image];
    //logo
    config.logoImg = [UIImage imageNamed:@"fast"];
    CGFloat logoWidth = config.logoImg.size.width?:100;
    CGFloat logoHeight = WidthOfScale(67);
    JVLayoutConstraint *logoConstraintX = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    JVLayoutConstraint *logoConstraintY = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeTop multiplier:1 constant:(WidthOfScale(97.5))];
    JVLayoutConstraint *logoConstraintW = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeWidth multiplier:1 constant:logoWidth];
    JVLayoutConstraint *logoConstraintH = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeHeight multiplier:1 constant:logoHeight];
    config.logoConstraints = @[logoConstraintX,logoConstraintY,logoConstraintW,logoConstraintH];
    config.logoHorizontalConstraints = config.logoConstraints;
    
    
    
    //号码栏
    JVLayoutConstraint *numberConstraintX = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    JVLayoutConstraint *numberConstraintY = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemLogo attribute:NSLayoutAttributeBottom multiplier:1 constant:(WidthOfScale(69.5))];
    JVLayoutConstraint *numberConstraintW = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeWidth multiplier:1 constant:WidthOfScale(180)];
    JVLayoutConstraint *numberConstraintH = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeHeight multiplier:1 constant:WidthOfScale(22.5)];
    config.numberConstraints = @[numberConstraintX,numberConstraintY, numberConstraintW, numberConstraintH];
    config.numberHorizontalConstraints = config.numberConstraints;
    
    
    CGFloat loginButtonWidth = WidthOfScale(300);
    CGFloat loginButtonHeight = WidthOfScale(50);
    JVLayoutConstraint *loginConstraintX = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    JVLayoutConstraint *loginConstraintY = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNumber attribute:NSLayoutAttributeBottom multiplier:1 constant:WidthOfScale(55)];
    JVLayoutConstraint *loginConstraintW = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeWidth multiplier:1 constant:loginButtonWidth];
    JVLayoutConstraint *loginConstraintH = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeHeight multiplier:1 constant:loginButtonHeight];
    config.logBtnConstraints = @[loginConstraintX,loginConstraintY,loginConstraintW,loginConstraintH];
    config.logBtnHorizontalConstraints = config.logBtnConstraints;
    

//    [JVERIFICATIONService customUIWithConfig:config];
    [JVERIFICATIONService customUIWithConfig:config customViews:^(UIView *customAreaView) {
        QMUIButton *close = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [close setImage:UIImageMake(@"delet") forState:(UIControlStateNormal)];
        [customAreaView addSubview:close];
        [close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(WidthOfScale(40.5)));
            make.right.equalTo(@(-WidthOfScale(20.5)));
        }];
        [[close rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [JVERIFICATIONService dismissLoginControllerAnimated:YES completion:^{
                
            }];
        }];
        
        QMUIButton *ChangeBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [ChangeBtn setTitle:@"切换手机号" forState:(UIControlStateNormal)];
        ChangeBtn.titleLabel.font = RegularFont17;
        [ChangeBtn setTitleColor:colorFE851E forState:(UIControlStateNormal)];
        [[ChangeBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            EFChangeLoginViewController *vc = [[EFChangeLoginViewController alloc] initWithType:YES];
            [[UIViewController getCurrentVC].navigationController qmui_pushViewController:vc animated:YES completion:^{
                
            }];
        }];
        [customAreaView addSubview:ChangeBtn];
        [ChangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(WidthOfScale(376.5)));
            make.centerX.equalTo(customAreaView);
            make.size.mas_equalTo(CGSizeMake(WidthOfScale(300), WidthOfScale(50)));
        }];
        [ChangeBtn layoutIfNeeded];
        [ChangeBtn AddImageRadiusBorderWithColor:colorFE851E lineWidth:1 radius:WidthOfScale(50)/2];
        EFRegAndPswTableViewCell *regcell = [[EFRegAndPswTableViewCell alloc] init];
        [customAreaView addSubview:regcell.contentView];
        [regcell.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ChangeBtn.mas_bottom).equalTo(@(WidthOfScale(21.5)));
            make.centerX.equalTo(customAreaView);
            make.size.mas_equalTo(CGSizeMake(kPHONE_WIDTH, WidthOfScale(13)));
        }];
        
        EFThreeLoginTableViewCell *threecell = [[EFThreeLoginTableViewCell alloc] init];
        [customAreaView addSubview:threecell.contentView];
        [threecell.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(regcell.contentView.mas_bottom).equalTo(@(WidthOfScale(0)));
            make.centerX.equalTo(customAreaView);
            make.size.mas_equalTo(CGSizeMake(kPHONE_WIDTH, WidthOfScale(208)));
        }];
        [threecell.contentView layoutIfNeeded];
        [customAreaView layoutIfNeeded];
        
    }];
}


+ (void)setBindPhoneUI {
    JVUIConfig *config = [[JVUIConfig alloc] init];
    config.navCustom = NO;
    config.navColor = UIColor.whiteColor;
    config.navText = [[NSAttributedString alloc] initWithString:@"绑定手机" attributes:@{NSFontAttributeName : MedFont17, NSForegroundColorAttributeName : tabbarBlackColor}];
    config.navReturnImg = UIImageMake(@"btn_back_black");
    
    config.shouldAutorotate = NO;
    config.autoLayout = YES;
    config.privacyState = YES;
    //    config.orientation =  UIInterfaceOrientationPortrait;
    config.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    config.navReturnHidden = NO;
    config.numberFont = MedFont30;
    config.logBtnText = @"一键绑定";
    config.logBtnFont = RegularFont17;
    UIImage *image = [[UIImage imageWithColor:colorF14745 size:CGSizeMake(WidthOfScale(300), WidthOfScale(50))] qmui_imageWithClippedCornerRadius:WidthOfScale(50)/2];
    config.logBtnImgs = @[image,image,image];
    
    
    //号码栏
    JVLayoutConstraint *numberConstraintX = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    JVLayoutConstraint *numberConstraintY = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeTop multiplier:1 constant:(WidthOfScale(90.5))];
    JVLayoutConstraint *numberConstraintW = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeWidth multiplier:1 constant:WidthOfScale(180)];
    JVLayoutConstraint *numberConstraintH = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeHeight multiplier:1 constant:WidthOfScale(22.5)];
    config.numberConstraints = @[numberConstraintX,numberConstraintY, numberConstraintW, numberConstraintH];
    config.numberHorizontalConstraints = config.numberConstraints;
    
    
    CGFloat loginButtonWidth = WidthOfScale(300);
    CGFloat loginButtonHeight = WidthOfScale(50);
    JVLayoutConstraint *loginConstraintX = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    JVLayoutConstraint *loginConstraintY = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNumber attribute:NSLayoutAttributeBottom multiplier:1 constant:WidthOfScale(50)];
    JVLayoutConstraint *loginConstraintW = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeWidth multiplier:1 constant:loginButtonWidth];
    JVLayoutConstraint *loginConstraintH = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeHeight multiplier:1 constant:loginButtonHeight];
    config.logBtnConstraints = @[loginConstraintX,loginConstraintY,loginConstraintW,loginConstraintH];
    config.logBtnHorizontalConstraints = config.logBtnConstraints;
    

//    [JVERIFICATIONService customUIWithConfig:config];
    [JVERIFICATIONService customUIWithConfig:config customViews:^(UIView *customAreaView) {
        
        QMUILabel *lab = [[QMUILabel alloc] init];
        lab.font = RegularFont17;
        lab.textColor = tabbarBlackColor;
        lab.text = @"绑定本机";
        [customAreaView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(WidthOfScale(50)));
            make.centerX.equalTo(customAreaView);
        }];
        
        QMUIButton *ChangeBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [ChangeBtn setTitle:@"更换手机号" forState:(UIControlStateNormal)];
        ChangeBtn.titleLabel.font = RegularFont15;
        [ChangeBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        [[ChangeBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            EFBindPhoneViewController *bind = [[EFBindPhoneViewController alloc] init];
            [[UIViewController getCurrentVC].navigationController qmui_pushViewController:bind animated:YES completion:^{
                
            }];
        }];
        [customAreaView addSubview:ChangeBtn];
        [ChangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(WidthOfScale(233)));
            make.centerX.equalTo(customAreaView);
            make.size.mas_equalTo(CGSizeMake(WidthOfScale(300), WidthOfScale(50)));
        }];
    }];
}

@end
