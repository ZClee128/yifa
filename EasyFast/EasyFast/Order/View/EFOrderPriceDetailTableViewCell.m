//
//  EFOrderPriceDetailTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOrderPriceDetailTableViewCell.h"


@interface EFOrderPriceDetailTableViewCell ()

@property (nonatomic,strong)QMUILabel *leftLab;
@property (nonatomic,strong)QMUILabel *rightLab;

@end

@implementation EFOrderPriceDetailTableViewCell

- (QMUILabel *)leftLab {
    if (_leftLab == nil) {
        _leftLab = [[QMUILabel alloc] init];
        _leftLab.font = RegularFont12;
        _leftLab.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
        _leftLab.textAlignment = NSTextAlignmentLeft;
    }
    return _leftLab;
}

- (QMUILabel *)rightLab {
    if (_rightLab == nil) {
        _rightLab = [[QMUILabel alloc] init];
        _rightLab.font = RegularFont12;
        _rightLab.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
        _rightLab.textAlignment = NSTextAlignmentRight;
    }
    return _rightLab;
}

- (void)setUI {
    [self.contentView addSubview:self.leftLab];
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.rightLab];
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15)));
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setModel:(id)model {
    self.leftLab.text = model[0];
    self.rightLab.text = model[1];
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
