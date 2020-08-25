//
//  EFEditPasswordViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFEditPasswordViewController.h"
#import "EFPasswordTextField.h"
#import "MeVM.h"
#import "LoginVM.h"

@interface EFEditPasswordViewController ()

@property (nonatomic,strong)EFPasswordTextField *oldTextField;
@property (nonatomic,strong)EFPasswordTextField *newsTextField;
@property (nonatomic,strong)EFPasswordTextField *comfirTextField;
@property (nonatomic,strong)QMUIButton *nextBtn;

@end

@implementation EFEditPasswordViewController

-(EFPasswordTextField *)oldTextField
{
    if (_oldTextField == nil) {
        _oldTextField = [[EFPasswordTextField alloc] init];
        _oldTextField.placeholder = @"请输入当前登录密码";
        _oldTextField.font = MedFont15;
        _oldTextField.textColor = tabbarBlackColor;
        _oldTextField.secureTextEntry = YES;
    }
    return _oldTextField;
}

-(EFPasswordTextField *)newsTextField
{
    if (_newsTextField == nil) {
        _newsTextField = [[EFPasswordTextField alloc] init];
        _newsTextField.placeholder = @"请输入新密码";
        _newsTextField.font = MedFont15;
        _newsTextField.textColor = tabbarBlackColor;
        _newsTextField.secureTextEntry = YES;
    }
    return _newsTextField;
}

-(EFPasswordTextField *)comfirTextField
{
    if (_comfirTextField == nil) {
        _comfirTextField = [[EFPasswordTextField alloc] init];
        _comfirTextField.placeholder = @"确认新密码";
        _comfirTextField.font = MedFont15;
        _comfirTextField.textColor = tabbarBlackColor;
        _comfirTextField.secureTextEntry = YES;
    }
    return _comfirTextField;
}

-(QMUIButton *)nextBtn
{
    if (_nextBtn == nil) {
        _nextBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_nextBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
        [_nextBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
        _nextBtn.titleLabel.font = MedFont15;
        @weakify(self);
        [[_nextBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self nextClick];
        }];
    }
    return _nextBtn;
}

- (void)nextClick {
    if (![self.newsTextField.text deptNumInputShouldNumber]) {
        [MBProgressHUD showFailureProgress:@"必须是6-20个英文字母，数字或符号（除空格），且字母，数字和标点至少包含两种"];
        return;
    }
    [[MeVM updatePassWord:self.oldTextField.text password:self.newsTextField.text confirmPassword:self.comfirTextField.text] subscribeNext:^(NSNumber *x) {
        if ([x boolValue]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kChangePassword object:nil];
            [[LoginVM loginOut] subscribeNext:^(id  _Nullable x) {
                
            }];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"修改密码";
    [self setUI];
}


- (void)setUI {
    
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(NAVIGATION_BAR_HEIGHT));
        make.height.equalTo(@(WidthOfScale(150)));
        make.width.equalTo(@(kPHONE_WIDTH));
    }];
    
    QMUILabel *oldLab = [[QMUILabel alloc] init];
    oldLab.font = MedFont15;
    oldLab.textColor = tabbarBlackColor;
    oldLab.text = @"当前密码";
    [self.view addSubview:oldLab];
    [oldLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(16.5)));
        make.top.equalTo(@(WidthOfScale(18)+NAVIGATION_BAR_HEIGHT));
    }];
    
    [self.view addSubview:self.oldTextField];
    [self.oldTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(104.5)));
        make.centerY.equalTo(oldLab);
        make.height.equalTo(@(WidthOfScale(50)));
        make.right.equalTo(@(0));
    }];
    
    QMUILabel *newLab = [[QMUILabel alloc]init];
    newLab.font = MedFont15;
    newLab.textColor = tabbarBlackColor;
    newLab.text = @"新密码";
    [self.view addSubview:newLab];
    [newLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(16.5)));
        make.top.equalTo(@(WidthOfScale(68)+NAVIGATION_BAR_HEIGHT));
    }];
    
    [self.view addSubview:self.newsTextField];
    [self.newsTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(104.5)));
        make.centerY.equalTo(newLab);
        make.height.equalTo(@(WidthOfScale(50)));
        make.right.equalTo(@(0));
    }];
    
    QMUILabel *comLab = [[QMUILabel alloc] init];
    comLab.font = MedFont15;
    comLab.textColor = tabbarBlackColor;
    comLab.text = @"确认新密码";
    [self.view addSubview:comLab];
    [comLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(16.5)));
        make.top.equalTo(@(WidthOfScale(118)+NAVIGATION_BAR_HEIGHT));
    }];
    
    [self.view addSubview:self.comfirTextField];
    [self.comfirTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(104.5)));
        make.centerY.equalTo(comLab);
        make.height.equalTo(@(WidthOfScale(50)));
        make.right.equalTo(@(0));
    }];
    
    QMUILabel *rool = [[QMUILabel alloc] init];
    rool.font = RegularFont13;
    rool.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
    rool.numberOfLines = 0;
    rool.text = @"必须是6-20个英文字母，数字或符号（除空格），且字母，数字和标点至少包含两种";
    [self.view addSubview:rool];
    [rool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg.mas_bottom).equalTo(@(WidthOfScale(15)));
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(WidthOfScale(337.5)));
    }];
    
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rool.mas_bottom).equalTo(@(WidthOfScale(30)));
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(WidthOfScale(345)));
        make.height.equalTo(@(WidthOfScale(50)));
    }];
    [self.nextBtn layoutIfNeeded];
    [self.nextBtn ViewRadius:5];
    
    RACSignal *oldSignal = [RACSignal merge:@[self.oldTextField.rac_textSignal, RACObserve(self.oldTextField, text)]];
    RACSignal *newSignal = [RACSignal merge:@[self.newsTextField.rac_textSignal, RACObserve(self.newsTextField, text)]];
    RACSignal *comSignal = [RACSignal merge:@[self.comfirTextField.rac_textSignal, RACObserve(self.comfirTextField, text)]];
    @weakify(self);
    RAC(self.nextBtn,userInteractionEnabled) =  [RACSignal combineLatest:@[oldSignal,newSignal,comSignal] reduce:^id _Nonnull(NSString *old,NSString *news,NSString *com){
        @strongify(self);
        BOOL enabled = old.length && news.length && com.length > 0;
        
        if (!enabled) {
            btnGradation(self.nextBtn,[colorF14745 colorWithAlphaComponent:0.6]);
        }else {
            btnGradation(self.nextBtn,colorF14745);
        }
        return @(enabled);
    }];
}



@end


@implementation EFSetNewPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)setUI {
    
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(NAVIGATION_BAR_HEIGHT));
        make.height.equalTo(@(WidthOfScale(100)));
        make.width.equalTo(@(kPHONE_WIDTH));
    }];
    
    QMUILabel *newLab = [[QMUILabel alloc]init];
    newLab.font = MedFont15;
    newLab.textColor = tabbarBlackColor;
    newLab.text = @"新密码";
    [self.view addSubview:newLab];
    [newLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(16.5)));
        make.top.equalTo(@(WidthOfScale(18)+NAVIGATION_BAR_HEIGHT));
    }];
    
    [self.view addSubview:self.newsTextField];
    [self.newsTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(104.5)));
        make.centerY.equalTo(newLab);
        make.height.equalTo(@(WidthOfScale(50)));
        make.right.equalTo(@(0));
    }];
    
    QMUILabel *comLab = [[QMUILabel alloc] init];
    comLab.font = MedFont15;
    comLab.textColor = tabbarBlackColor;
    comLab.text = @"确认新密码";
    [self.view addSubview:comLab];
    [comLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(16.5)));
        make.top.equalTo(@(WidthOfScale(68)+NAVIGATION_BAR_HEIGHT));
    }];
    
    [self.view addSubview:self.comfirTextField];
    [self.comfirTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(104.5)));
        make.centerY.equalTo(comLab);
        make.height.equalTo(@(WidthOfScale(50)));
        make.right.equalTo(@(0));
    }];
    
    QMUILabel *rool = [[QMUILabel alloc] init];
    rool.font = RegularFont13;
    rool.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
    rool.numberOfLines = 0;
    rool.text = @"必须是6-20个英文字母，数字或符号（除空格），且字母，数字和标点至少包含两种";
    [self.view addSubview:rool];
    [rool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg.mas_bottom).equalTo(@(WidthOfScale(15)));
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(WidthOfScale(337.5)));
    }];
    
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rool.mas_bottom).equalTo(@(WidthOfScale(30)));
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(WidthOfScale(345)));
        make.height.equalTo(@(WidthOfScale(50)));
    }];
    [self.nextBtn layoutIfNeeded];
    [self.nextBtn ViewRadius:5];
    
    RACSignal *newSignal = [RACSignal merge:@[self.newsTextField.rac_textSignal, RACObserve(self.newsTextField, text)]];
    RACSignal *comSignal = [RACSignal merge:@[self.comfirTextField.rac_textSignal, RACObserve(self.comfirTextField, text)]];
    @weakify(self);
    RAC(self.nextBtn,userInteractionEnabled) =  [RACSignal combineLatest:@[newSignal,comSignal] reduce:^id _Nonnull(NSString *news,NSString *com){
        @strongify(self);
        BOOL enabled = news.length && com.length > 0;
        
        if (!enabled) {
            btnGradation(self.nextBtn,[colorF14745 colorWithAlphaComponent:0.6]);
        }else {
            btnGradation(self.nextBtn,colorF14745);
        }
        return @(enabled);
    }];
}

- (void)nextClick {
//    设置新密码
    @weakify(self);
    [[LoginVM setNewPasswordNewPassword:self.newsTextField.text confirmPassword:self.comfirTextField.text code:self.code phone:self.phone] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if ([x boolValue]) {
            [self.navigationController qmui_popViewControllerAnimated:YES completion:^{
                
            }];
        }
    }];
}

@end
