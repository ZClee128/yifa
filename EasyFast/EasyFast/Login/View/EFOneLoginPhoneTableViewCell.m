//
//  EFOneLoginPhoneTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOneLoginPhoneTableViewCell.h"

@interface EFOneLoginPhoneTableViewCell ()

@property (nonatomic,strong)QMUILabel *phoneLab;
@property (nonatomic,strong)QMUIButton *loginBtn;
@property (nonatomic,strong)QMUIButton *ChangeBtn;

@end

@implementation EFOneLoginPhoneTableViewCell

- (QMUILabel *)phoneLab
{
    if (_phoneLab == nil) {
        _phoneLab = [[QMUILabel alloc] init];
        _phoneLab.font = MedFont30;
        _phoneLab.textColor = tabbarBlackColor;
    }
    return _phoneLab;
}

- (QMUIButton *)loginBtn {
    if (_loginBtn == nil) {
        _loginBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_loginBtn setTitle:@"本机号码一键登录" forState:(UIControlStateNormal)];
        _loginBtn.titleLabel.font = RegularFont17;
        [_loginBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
        @weakify(self);
        [[_loginBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.loginBlock) {
                self.loginBlock();
            }
        }];
    }
    return _loginBtn;
}

- (QMUIButton *)ChangeBtn {
    if (_ChangeBtn == nil) {
        _ChangeBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_ChangeBtn setTitle:@"切换手机号" forState:(UIControlStateNormal)];
        _ChangeBtn.titleLabel.font = RegularFont17;
        [_ChangeBtn setTitleColor:colorFE851E forState:(UIControlStateNormal)];
        @weakify(self);
        [[_ChangeBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.changeBlock) {
                self.changeBlock();
            }
        }];
    }
    return _ChangeBtn;
}

- (void)setUI {
    [self.contentView addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(54)));
        make.centerX.equalTo(self.contentView);
        make.height.equalTo(@(WidthOfScale(22.5)));
    }];
    
    [self.contentView addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLab.mas_bottom).equalTo(@(WidthOfScale(55)));
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(300), WidthOfScale(50)));
    }];
    [self.loginBtn layoutIfNeeded];
    [self.loginBtn ViewRadius:WidthOfScale(50)/2];
    [self.loginBtn setBackgroundImage:[UIImage imageWithMixColors:@[RGB16(0xFFBD20),RGB16(0xFF3838)] size:self.loginBtn.size] forState:(UIControlStateNormal)];
    
    [self.contentView addSubview:self.ChangeBtn];
    [self.ChangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).equalTo(@(WidthOfScale(15)));
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(300), WidthOfScale(50)));
    }];
    [self.ChangeBtn layoutIfNeeded];
    [self.ChangeBtn AddImageRadiusBorderWithColor:colorFE851E lineWidth:1 radius:WidthOfScale(50)/2];
}

- (void)setModel:(id)model {
    self.phoneLab.text = @"139****9999";
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
