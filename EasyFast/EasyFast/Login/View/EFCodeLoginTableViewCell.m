//
//  EFCodeLoginTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFCodeLoginTableViewCell.h"

@interface EFCodeLoginTableViewCell ()

@property (nonatomic,strong)QMUIButton *sendCodeBtn;
@end


@implementation EFCodeLoginTableViewCell

- (QMUIButton *)sendCodeBtn {
    if (_sendCodeBtn == nil) {
        _sendCodeBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        _sendCodeBtn.titleLabel.font = RegularFont14;
        [_sendCodeBtn setTitle:@"发送验证码" forState:(UIControlStateNormal)];
        [_sendCodeBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        [[_sendCodeBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
            if (self.CodeBlock) {
                self.CodeBlock(x);
            }
        }];
    }
    return _sendCodeBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = RGB16(0xf2f2f2);
        [self.contentView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-WidthOfScale(115)));
            make.centerY.equalTo(self.leftLab);
            make.size.mas_equalTo(CGSizeMake(1, WidthOfScale(15)));
        }];
        
        [self.phoneTextfield mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(WidthOfScale(94.5)));
            make.right.equalTo(line2.mas_left).equalTo(@(-WidthOfScale(10)));
            make.centerY.equalTo(self.leftLab);
            make.height.equalTo(@(WidthOfScale(50)));
        }];
        
        [self.contentView addSubview:self.sendCodeBtn];
        [self.sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line2.mas_right).equalTo(@(WidthOfScale(15)));
            make.centerY.equalTo(self.leftLab);
        }];
    }
    return self;
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
