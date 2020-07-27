//
//  EFPhoneTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFPhoneTableViewCell.h"

@interface EFPhoneTableViewCell ()

@property (nonatomic,strong)QMUILabel *leftLab;


@end

@implementation EFPhoneTableViewCell

-(QMUILabel *)leftLab
{
    if (_leftLab == nil) {
        _leftLab = [[QMUILabel alloc] init];
        _leftLab.font = MedFont15;
        _leftLab.textColor = tabbarBlackColor;
    }
    return _leftLab;
}

-(QMUITextField *)phoneTextField
{
    if (_phoneTextField == nil) {
        _phoneTextField = [[QMUITextField alloc] init];
        _phoneTextField.placeholderColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
        _phoneTextField.placeholder = @"请输入手机号";
        _phoneTextField.tintColor = colorFE851E;
        _phoneTextField.font = RegularFont15;
        _phoneTextField.textColor = tabbarBlackColor;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.maximumTextLength = 11;
        @weakify(self);
        [[_phoneTextField rac_signalForControlEvents:(UIControlEventEditingChanged)] subscribeNext:^(QMUITextField *x) {
            @strongify(self);
            if (self.TextValue) {
                self.TextValue(x.text);
            }
        }];
    }
    return _phoneTextField;
}

- (void)setUI {
    [self.contentView addSubview:self.leftLab];
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(16)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(105)));
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(@(-WidthOfScale(15)));
        make.height.equalTo(@(WidthOfScale(50)));
    }];
}


- (void)setModel:(id)model {
    self.leftLab.text = model;
}

- (RACSignal *)phoneSignal
{
    return [RACSignal merge:@[self.phoneTextField.rac_textSignal, RACObserve(self.phoneTextField, text)]];
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
