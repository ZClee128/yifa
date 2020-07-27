//
//  EFCodeTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFCodeTableViewCell.h"

@interface EFCodeTableViewCell ()

@property (nonatomic,strong)QMUILabel *leftLab;
@property (nonatomic,strong)QMUIButton *codeBtn;

@end


@implementation EFCodeTableViewCell

-(QMUILabel *)leftLab
{
    if (_leftLab == nil) {
        _leftLab = [[QMUILabel alloc] init];
        _leftLab.font = MedFont15;
        _leftLab.textColor = tabbarBlackColor;
    }
    return _leftLab;
}

-(QMUITextField *)codeTextField
{
    if (_codeTextField == nil) {
        _codeTextField = [[QMUITextField alloc] init];
        _codeTextField.placeholderColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
        _codeTextField.placeholder = @"请输入验证码";
        _codeTextField.tintColor = colorFE851E;
        _codeTextField.font = RegularFont15;
        _codeTextField.textColor = tabbarBlackColor;
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.maximumTextLength = 6;
        _codeTextField.clearButtonMode = UITextFieldViewModeAlways;
        @weakify(self);
        [[_codeTextField rac_signalForControlEvents:(UIControlEventEditingChanged)] subscribeNext:^(QMUITextField *x) {
            @strongify(self);
            if (self.TextValue) {
                self.TextValue(x.text);
            }
        }];
    }
    return _codeTextField;
}

-(QMUIButton *)codeBtn
{
    if (_codeBtn == nil) {
        _codeBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_codeBtn setTitle:@"重发验证码" forState:(UIControlStateNormal)];
        [_codeBtn setTitleColor:[tabbarBlackColor colorWithAlphaComponent:0.6] forState:(UIControlStateSelected)];
        [_codeBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        _codeBtn.titleLabel.font = RegularFont14;
        @weakify(self);
        [[_codeBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
            x.selected = !x.selected;
            @strongify(self);
            if (self.CodeBlock) {
                self.CodeBlock(x);
            }
        }];
    }
    return _codeBtn;
}

- (void)setUI {
    [self.contentView addSubview:self.leftLab];
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(16)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(105)));
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(@(-WidthOfScale(125)));
        make.height.equalTo(@(WidthOfScale(50)));
    }];
    
    [self.contentView addSubview:self.codeBtn];
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15)));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(100), WidthOfScale(35)));
    }];
    [self.codeBtn layoutIfNeeded];
    [self.codeBtn AddImageRadiusBorderWithColor:RGB16(0xE8E3E3) lineWidth:1 radius:WidthOfScale(35)/2];
}

- (void)setModel:(id)model {
    self.leftLab.text = model;
}

- (RACSignal *)codeSignal
{
    return [RACSignal merge:@[self.codeTextField.rac_textSignal, RACObserve(self.codeTextField, text)]];
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
