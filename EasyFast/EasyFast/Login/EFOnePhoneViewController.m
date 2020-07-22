//
//  EFOnePhoneViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/22.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOnePhoneViewController.h"
#import "EFBindPhoneViewController.h"

@interface EFOnePhoneViewController ()

@property(nonatomic,strong)QMUILabel *titleLab;
@property(nonatomic,strong)QMUILabel *phoneLab;
@property (nonatomic,strong)QMUIButton *oneBtn;

@end

@implementation EFOnePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"绑定手机";
    self.view.backgroundColor = UIColor.whiteColor;
    [self setUI];
    JVAuthConfig *config = [[JVAuthConfig alloc] init];
    config.appKey = @"dd10c0e76e97072558cf1d77";
    [JVERIFICATIONService setupWithConfig:config];
    if(![JVERIFICATIONService checkVerifyEnable]) {
        NSLog(@"当前网络环境不支持认证！");
        return;
    }
    [JVERIFICATIONService getToken:5000 completion:^(NSDictionary *result) {
        NSLog(@"getToken result:%@", result);
        //TODO:获取token后相关操作
    }];
}

- (void)setTitleLabTitle:(NSString *)title {
    self.titleLab.text = title;
}

- (void)setOneBtnTitle:(NSString *)title {
    [self.oneBtn setTitle:title forState:(UIControlStateNormal)];
}

- (void)setUI {
    self.titleLab = [[QMUILabel alloc] init];
    self.titleLab.font = RegularFont17;
    self.titleLab.textColor = tabbarBlackColor;
    self.titleLab.text = @"绑定本机";
    [self.view addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(NAVIGATION_BAR_HEIGHT+WidthOfScale(50)));
        make.centerX.equalTo(self.view);
    }];
    
    self.phoneLab = [[QMUILabel alloc] init];
    self.phoneLab.font = MedFont30;
    self.phoneLab.textColor = tabbarBlackColor;
    self.phoneLab.text = @"139****9999";
    [self.view addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).equalTo(@(WidthOfScale(24.5)));
        make.centerX.equalTo(self.view);
    }];
    
    self.oneBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [self.oneBtn setTitle:@"一键绑定" forState:(UIControlStateNormal)];
    [self.oneBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    self.oneBtn.titleLabel.font = MedFont17;
    self.oneBtn.backgroundColor = colorF14745;
    [self.view addSubview:self.oneBtn];
    [self.oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLab.mas_bottom).equalTo(@(WidthOfScale(50)));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(300), WidthOfScale(50)));
    }];
    [self.oneBtn layoutIfNeeded];
    [self.oneBtn ViewRadius:WidthOfScale(50)/2];
    @weakify(self);
    [[self.oneBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self oneBtnClick];
    }];
    
    QMUIButton *change = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [change setTitle:@"更换手机" forState:(UIControlStateNormal)];
    [change setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
    change.titleLabel.font = RegularFont15;
    [self.view addSubview:change];
    [change mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.oneBtn.mas_bottom).equalTo(@(WidthOfScale(20)));
        make.centerX.equalTo(self.view);
    }];
    [[change rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self changClick];
    }];
}

- (void)changClick {
    EFBindPhoneViewController *bind = [[EFBindPhoneViewController alloc] init];
    [self.navigationController qmui_pushViewController:bind animated:YES completion:^{
        
    }];
}

- (void)oneBtnClick {
    
}

@end
