//
//  EFQPTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFQPTableViewCell.h"

@interface EFQPTableViewCell ()

@property (nonatomic,strong)QMUILabel *leftLab;
@property (nonatomic,strong)QMUILabel *rightLab;
@property (nonatomic,strong)UIImageView *iconImageView;
@end


@implementation EFQPTableViewCell

-(QMUILabel *)leftLab
{
    if (_leftLab == nil) {
        _leftLab = [[QMUILabel alloc] init];
        _leftLab.font = MedFont15;
        _leftLab.textColor = tabbarBlackColor;
    }
    return _leftLab;
}

-(QMUILabel *)rightLab
{
    if (_rightLab == nil) {
        _rightLab = [[QMUILabel alloc] init];
        _rightLab.font = MedFont15;
        _rightLab.textColor = tabbarBlackColor;
    }
    return _rightLab;
}

-(UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] initWithImage:UIImageMake(@"less_down")];
    }
    return _iconImageView;
}


- (void)setUI {
    [self.contentView addSubview:self.leftLab];
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(16)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.rightLab];
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(105.5)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15)));
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setModel:(id)model {
    if ([model isKindOfClass:[NSArray class]]) {
        self.leftLab.text = model[0];
        self.rightLab.text = model[1];
    }
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
