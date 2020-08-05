//
//  EFAccountPswTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFAccountPswTableViewCell.h"
#import "EFPasswordTextField.h"
@interface EFAccountPswTableViewCell ()

@property (nonatomic,strong)EFPasswordTextField *passTextField;

@end

@implementation EFAccountPswTableViewCell

- (EFPasswordTextField *)passTextField {
    if (_passTextField == nil) {
        _passTextField = [[EFPasswordTextField alloc] init];
        _passTextField.font = RegularFont15;
        @weakify(self);
        [[_passTextField rac_signalForControlEvents:(UIControlEventEditingChanged)] subscribeNext:^(QMUITextField *x) {
            @strongify(self);
            if (self.TextValue) {
                self.TextValue(x.text);
            }
        }];
    }
    return _passTextField;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.phoneTextfield removeFromSuperview];
        [self.contentView addSubview:self.passTextField];
        [self.passTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(WidthOfScale(94.5)));
            make.right.equalTo(@(-WidthOfScale(15.5)));
            make.centerY.equalTo(self.leftLab);
            make.height.equalTo(@(WidthOfScale(50)));
        }];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)place {
    self.passTextField.placeholder = place;
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
