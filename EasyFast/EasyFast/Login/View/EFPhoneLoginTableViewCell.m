//
//  EFPhoneLoginTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFPhoneLoginTableViewCell.h"

@interface EFPhoneLoginTableViewCell()

@end

@implementation EFPhoneLoginTableViewCell

- (QMUILabel *)leftLab {
    if (_leftLab == nil) {
        _leftLab = [[QMUILabel alloc] init];
        _leftLab.font = MedFont15;
        _leftLab.textColor = tabbarBlackColor;
    }
    return _leftLab;
}

- (QMUITextField *)phoneTextfield {
    if (_phoneTextfield == nil) {
        _phoneTextfield = [[QMUITextField alloc] init];
        self.tintColor = colorFE851E;
        _phoneTextfield.font = RegularFont15;
        _phoneTextfield.placeholderColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
        _phoneTextfield.placeholder = @"请输入手机号";
        _phoneTextfield.keyboardType = UIKeyboardTypeNumberPad;
        @weakify(self);
        [[_phoneTextfield rac_signalForControlEvents:(UIControlEventEditingChanged)] subscribeNext:^(QMUITextField *x) {
            @strongify(self);
            if (self.TextValue) {
                self.TextValue(x.text);
            }
        }];
    }
    return _phoneTextfield;
}

- (void)setUI {
    [self.contentView addSubview:self.leftLab];
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.top.equalTo(@(WidthOfScale(34)));
    }];
    
    [self.contentView addSubview:self.phoneTextfield];
    [self.phoneTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(94.5)));
        make.right.equalTo(@(-WidthOfScale(15)));
        make.centerY.equalTo(self.leftLab);
        make.height.equalTo(@(WidthOfScale(50)));
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB16(0xf2f2f2);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(@(WidthOfScale(15)));
        make.right.equalTo(@(-WidthOfScale(15)));
        make.height.equalTo(@(1));
    }];
}

- (void)setModel:(id)model{
    self.leftLab.text = model;
}

- (void)setPlaceholder:(NSString *)place {
    self.phoneTextfield.placeholder = place;
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
