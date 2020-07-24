//
//  EFOrderAddressTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOrderAddressTableViewCell.h"

@interface EFOrderAddressTableViewCell ()

@property(nonatomic,strong)UIImageView *icon;
@property (nonatomic,strong)QMUILabel *NameLab;
@property (nonatomic,strong)QMUILabel *phoneLab;
@property (nonatomic,strong)YYLabel *detailLab;

@property (nonatomic,strong)NSMutableAttributedString *text;

@end


@implementation EFOrderAddressTableViewCell

- (UIImageView *)icon {
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        _icon.image = UIImageMake(@"dizhi");
    }
    return _icon;
}

- (QMUILabel *)NameLab {
    if (_NameLab == nil) {
        _NameLab = [[QMUILabel alloc] init];
        _NameLab.font = MedFont16;
        _NameLab.textColor = tabbarBlackColor;
    }
    return _NameLab;
}

- (QMUILabel *)phoneLab {
    if (_phoneLab == nil) {
        _phoneLab = [[QMUILabel alloc] init];
        _phoneLab.font = MedFont16;
        _phoneLab.textColor = tabbarBlackColor;
    }
    return _phoneLab;
}

- (YYLabel *)detailLab {
    if (_detailLab == nil) {
        _detailLab = [[YYLabel alloc] init];
        _detailLab.numberOfLines = 0;
    }
    return _detailLab;
}

- (void)setUI {
    [self.contentView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(@(WidthOfScale(15.5)));
    }];
    
    [self.contentView addSubview:self.NameLab];
    [self.NameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(14.5)));
        make.left.equalTo(@(WidthOfScale(56.5)));
    }];
    
    [self.contentView addSubview:self.detailLab];
    [self.detailLab  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.NameLab.mas_bottom).equalTo(@(WidthOfScale(13)));
        make.left.equalTo(@(WidthOfScale(56.5)));
        make.height.equalTo(@(WidthOfScale(12.5)));
        make.right.equalTo(@(-WidthOfScale(45.5)));
    }];
    
    [self.contentView addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.NameLab.mas_right).equalTo(@(WidthOfScale(26)));
        make.centerY.equalTo(self.NameLab);
    }];
    
}

- (void)setModel:(id)model {
    self.NameLab.text = @"李啦啦";
    self.text  = [[NSMutableAttributedString alloc] initWithString: @"广东省 深圳市 南山区 桃源街道 桃花小苑B708"];
    self.text.font = RegularFont13;
    self.text.color = tabbarBlackColor;
    self.text.lineSpacing = 10; // 行间距
    self.detailLab.attributedText = self.text;
    self.phoneLab.text = @"18737528967";
}

- (CGFloat)getCellHeight{
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(WidthOfScale(272.5), CGFLOAT_MAX) text:self.text];
    [self.detailLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(layout.textBoundingSize.height));
    }];
    return WidthOfScale(62.5)+layout.textBoundingSize.height;
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
