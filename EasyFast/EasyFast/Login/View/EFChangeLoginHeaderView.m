//
//  EFChangeLoginHeaderView.m
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFChangeLoginHeaderView.h"

@interface EFChangeLoginHeaderView ()

@property (nonatomic,strong)QMUIButton *locationBtn;
@property (nonatomic,strong)QMUIButton *phoneBtn;
@property (nonatomic,strong)QMUIButton *accountBtn;
@property (nonatomic,strong)UIImageView *sanjiaoView;

@end


@implementation EFChangeLoginHeaderView

- (QMUIButton *)locationBtn {
    if (_locationBtn == nil) {
        _locationBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        _locationBtn.titleLabel.font = RegularFont14;
        [_locationBtn setTitle:@"本机登录" forState:(UIControlStateNormal)];
        [_locationBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
        [[_locationBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [[UIViewController getCurrentVC].navigationController qmui_popViewControllerAnimated:YES completion:^{
                
            }];
        }];
    }
    return _locationBtn;
}

- (QMUIButton *)phoneBtn {
    if (_phoneBtn == nil) {
        _phoneBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        _phoneBtn.titleLabel.font = RegularFont16;
        [_phoneBtn setTitle:@"手机登录" forState:(UIControlStateNormal)];
        [_phoneBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
        @weakify(self);
        [[_phoneBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
            @strongify(self);
            [self.sanjiaoView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.phoneBtn.mas_centerX);
                make.bottom.equalTo(self);
            }];
            if (self.selectBlock) {
                self.selectBlock(0);
            }
        }];
    }
    return _phoneBtn;
}

- (QMUIButton *)accountBtn {
    if (_accountBtn == nil) {
        _accountBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        _accountBtn.titleLabel.font = RegularFont16;
        [_accountBtn setTitle:@"账号登录" forState:(UIControlStateNormal)];
        [_accountBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
        @weakify(self);
        [[_accountBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
            @strongify(self);
            [self.sanjiaoView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.accountBtn.mas_centerX);
                make.bottom.equalTo(self);
            }];
            if (self.selectBlock) {
                self.selectBlock(1);
            }
        }];
    }
    return _accountBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:UIImageMake(@"login_bg")];
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    UIImageView *loginView = [[UIImageView alloc] initWithImage:UIImageMake(@"whiter_fast")];
    [self addSubview:loginView];
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(63.5)));
        make.centerX.equalTo(self);
    }];
    
    [self addSubview:self.locationBtn];
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(35.5)));
        make.right.equalTo(@(-WidthOfScale(16)));
    }];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColor.whiteColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(147)));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(1), WidthOfScale(15)));
    }];
    
    [self addSubview:self.phoneBtn];
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line.mas_left).equalTo(@(-WidthOfScale(56)));
        make.centerY.equalTo(line);
    }];
    
    [self addSubview:self.accountBtn];
    [self.accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line.mas_right).equalTo(@(WidthOfScale(56)));
        make.centerY.equalTo(line);
    }];
    
    self.sanjiaoView = [[UIImageView alloc] initWithImage:UIImageMake(@"sanjiao")];
    [self addSubview:self.sanjiaoView];
    [self.sanjiaoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.centerX.equalTo(self.phoneBtn.mas_centerX);
    }];
}
@end
