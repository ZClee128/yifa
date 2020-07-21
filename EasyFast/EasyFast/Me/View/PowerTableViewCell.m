//
//  PowerTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "PowerTableViewCell.h"

@interface PowerTableViewCell ()

@property (nonatomic,strong)QMUILabel *titleLab;
@property (nonatomic,strong)QMUILabel *subTitleLab;
@property (nonatomic,strong)QMUILabel *setupLab;

@end


@implementation PowerTableViewCell

-(QMUILabel *)titleLab
{
    if (_titleLab == nil) {
        _titleLab = [[QMUILabel alloc] init];
        _titleLab.font = MedFont15;
        _titleLab.textColor = tabbarBlackColor;
    }
    return _titleLab;
}

-(QMUILabel *)subTitleLab
{
    if (_subTitleLab == nil) {
        _subTitleLab = [[QMUILabel alloc] init];
        _subTitleLab.font = RegularFont13;
        _subTitleLab.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
        _subTitleLab.textAlignment = NSTextAlignmentLeft;
        _subTitleLab.numberOfLines = 0;
    }
    return _subTitleLab;
}

-(QMUILabel *)setupLab
{
    if (_setupLab == nil) {
        _setupLab = [[QMUILabel alloc] init];
        _setupLab.font = MedFont15;
        _setupLab.textColor = color499AFF;
    }
    return _setupLab;
}


- (void)setUI {
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15.5)));
        make.top.equalTo(@(WidthOfScale(25)));
    }];
    
    [self.contentView addSubview:self.subTitleLab];
    [self.subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15.5)));
        make.top.equalTo(self.titleLab.mas_bottom).equalTo(@(WidthOfScale(10.5)));
        make.right.equalTo(@(-WidthOfScale(114)));
    }];
    
    [self.contentView addSubview:self.setupLab];
    [self.setupLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15)));
        make.top.equalTo(@(WidthOfScale(25)));
    }];
    
    
}

- (void)setModel:(id)model {
    if ([model isKindOfClass:[NSArray class]]) {
        self.titleLab.text = model[0];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model[1]];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:(5-(self.subTitleLab.font.lineHeight - self.subTitleLab.font.pointSize))];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model[1] length])];
        self.subTitleLab.attributedText = attributedString;
        self.setupLab.text = model[2];
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
