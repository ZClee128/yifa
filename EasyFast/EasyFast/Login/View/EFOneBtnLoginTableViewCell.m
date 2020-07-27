//
//  EFOneBtnLoginTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOneBtnLoginTableViewCell.h"

@interface EFOneBtnLoginTableViewCell ()

@property (nonatomic,strong)QMUIButton *loginBtn;
@end


@implementation EFOneBtnLoginTableViewCell

- (QMUIButton *)loginBtn {
    if (_loginBtn == nil) {
        _loginBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
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

- (void)setUI {
    [self.contentView addSubview:self.loginBtn];
       [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(@(WidthOfScale(60)));
           make.centerX.equalTo(self.contentView);
           make.size.mas_equalTo(CGSizeMake(WidthOfScale(300), WidthOfScale(50)));
       }];
       [self.loginBtn layoutIfNeeded];
       [self.loginBtn ViewRadius:WidthOfScale(50)/2];
       [self.loginBtn setBackgroundImage:[UIImage imageWithMixColors:@[RGB16(0xFFBD20),RGB16(0xFF3838)] size:self.loginBtn.size] forState:(UIControlStateNormal)];
}


- (void)setModel:(id)model {
    [self.loginBtn setTitle:model forState:(UIControlStateNormal)];
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
