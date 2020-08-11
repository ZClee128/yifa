//
//  EFTimeTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFTimeTableViewCell.h"

@interface EFTimeTableViewCell ()



@end

@implementation EFTimeTableViewCell


- (QMUILabel *)leftLab {
    if (_leftLab == nil) {
        _leftLab = [[QMUILabel alloc] init];
        _leftLab.font = RegularFont12;
        _leftLab.textColor = tabbarBlackColor;
        _leftLab.textAlignment = NSTextAlignmentLeft;
    }
    return _leftLab;
}

- (QMUILabel *)rightLab {
    if (_rightLab == nil) {
        _rightLab = [[QMUILabel alloc] init];
        _rightLab.font = RegularFont12;
        _rightLab.textColor = tabbarBlackColor;
        _rightLab.textAlignment = NSTextAlignmentLeft;
    }
    return _rightLab;
}

- (QMUIButton *)CopyBtn {
    if (_CopyBtn == nil) {
        _CopyBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_CopyBtn setTitle:@"复制" forState:(UIControlStateNormal)];
        [_CopyBtn setTitleColor:RGB16(0xFE851E) forState:(UIControlStateNormal)];
        _CopyBtn.titleLabel.font = RegularFont12;
        @weakify(self);
        [[_CopyBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = self.rightLab.text;
            [MBProgressHUD showSuccess:@"复制成功"];
        }];
    }
    return _CopyBtn;
}

- (void)setUI {
    [self.contentView addSubview:self.leftLab];
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.rightLab];
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(101)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.CopyBtn];
    [self.CopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightLab.mas_right).equalTo(@(WidthOfScale(20)));
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setModel:(id)model {
    self.leftLab.text = model[0];
    self.rightLab.text = model[1];
}

- (void)hiddenCopy {
    self.CopyBtn.hidden = YES;
}

- (void)showCopy {
    self.CopyBtn.hidden = NO;
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
