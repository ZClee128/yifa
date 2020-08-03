//
//  EFRegAndPswTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFRegAndPswTableViewCell.h"
#import "EFFastRegViewController.h"
#import "EFFastRegViewController.h"
@interface EFRegAndPswTableViewCell ()

@property (nonatomic,strong)QMUIButton *regBtn;
@property (nonatomic,strong)QMUIButton *findBtn;

@end


@implementation EFRegAndPswTableViewCell


- (QMUIButton *)regBtn {
    if (_regBtn == nil) {
        _regBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_regBtn setTitle:@"快速注册" forState:(UIControlStateNormal)];
        [_regBtn setTitleColor:colorFE851E forState:(UIControlStateNormal)];
        _regBtn.titleLabel.font = RegularFont14;
        [[_regBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            EFFastRegViewController *vc = [[EFFastRegViewController alloc] init];
            [[UIViewController getCurrentVC].navigationController qmui_pushViewController:vc animated:YES completion:^{
                
            }];
        }];
    }
    return _regBtn;
}

- (QMUIButton *)findBtn {
    if (_findBtn == nil) {
        _findBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_findBtn setTitle:@"找回密码" forState:(UIControlStateNormal)];
        [_findBtn setTitleColor:RGB16(0xbdbdbd) forState:(UIControlStateNormal)];
        _findBtn.titleLabel.font = RegularFont14;
        [[_findBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            EFFindPasswrodViewController *vc = [[EFFindPasswrodViewController alloc] init];
            [[UIViewController getCurrentVC].navigationController qmui_pushViewController:vc animated:YES completion:^{
                
            }];
        }];
    }
    return _findBtn;
}

- (void)setUI {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB16(0xdbdbdb);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(1), WidthOfScale(11)));
    }];
    
    [self.contentView addSubview:self.regBtn];
    [self.regBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line.mas_left).equalTo(@(-WidthOfScale(20)));
        make.centerY.equalTo(line);
        make.height.equalTo(@(WidthOfScale(13)));
    }];
    
    [self.contentView addSubview:self.findBtn];
    [self.findBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line.mas_right).equalTo(@(WidthOfScale(20)));
        make.centerY.equalTo(line);
        make.height.equalTo(@(WidthOfScale(13)));
    }];
    
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
