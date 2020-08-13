//
//  EFOrderGoodsTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/23.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOrderGoodsTableViewCell.h"
#import "EFOrderModel.h"
@interface EFOrderGoodsTableViewCell ()



@end

@implementation EFOrderGoodsTableViewCell

-(UIImageView *)goods
{
    if (_goods == nil) {
        _goods = [[UIImageView alloc] init];
        _goods.backgroundColor = colorAEAEAE;
        _goods.image = UIImageMake(@"gg");
    }
    return _goods;
}

-(QMUILabel *)goodsNameLab
{
    if (_goodsNameLab == nil) {
        _goodsNameLab = [[QMUILabel alloc] init];
        _goodsNameLab.font = MedFont14;
        _goodsNameLab.textColor = tabbarBlackColor;
        _goodsNameLab.textAlignment = NSTextAlignmentLeft;
        _goodsNameLab.numberOfLines = 2;
    }
    return _goodsNameLab;
}

-(QMUILabel *)goodsSizeLab
{
    if (_goodsSizeLab == nil) {
        _goodsSizeLab = [[QMUILabel alloc] init];
        _goodsSizeLab.font = RegularFont12;
        _goodsSizeLab.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
        _goodsSizeLab.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsSizeLab;
}

-(QMUILabel *)goodsPriceLab
{
    if (_goodsPriceLab == nil) {
        _goodsPriceLab = [[QMUILabel alloc] init];
        _goodsPriceLab.font = MedFont15;
        _goodsPriceLab.textColor = tabbarBlackColor;
        _goodsPriceLab.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsPriceLab;
}

-(QMUILabel *)goodsStatusLab
{
    if (_goodsStatusLab == nil) {
        _goodsStatusLab = [[QMUILabel alloc] init];
        _goodsStatusLab.font = MedFont14;
        _goodsStatusLab.textColor = colorFE851E;
        _goodsStatusLab.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsStatusLab;
}


-(QMUILabel *)goodsNumLab
{
    if (_goodsNumLab == nil) {
        _goodsNumLab = [[QMUILabel alloc] init];
        _goodsNumLab.font = RegularFont13;
        _goodsNumLab.textColor = tabbarBlackColor;
        _goodsNumLab.textAlignment = NSTextAlignmentRight;
    }
    return _goodsNumLab;
}

- (void)setUI {
    [self.contentView addSubview:self.goods];
    [self.goods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(15)));
        make.left.equalTo(@(WidthOfScale(15)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(100), WidthOfScale(100)));
    }];
    [self.goods layoutIfNeeded];
    [self.goods ViewRadius:5];
    
    [self.contentView addSubview:self.goodsNameLab];
    [self.goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(16.5)));
        make.left.equalTo(self.goods.mas_right).equalTo(@(WidthOfScale(13)));
        make.right.equalTo(@(-WidthOfScale(21.5)));
    }];
    
    [self.contentView addSubview:self.goodsSizeLab];
    [self.goodsSizeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsNameLab.mas_bottom).equalTo(@(WidthOfScale(9)));
        make.left.equalTo(self.goods.mas_right).equalTo(@(WidthOfScale(13)));
        make.height.equalTo(@(WidthOfScale(11.5)));
        make.right.equalTo(@(-WidthOfScale(21.5)));
    }];
    
    [self.contentView addSubview:self.goodsNumLab];
    [self.goodsNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15)));
        make.bottom.equalTo(self.goods.mas_bottom).equalTo(@(-WidthOfScale(1.5)));
    }];
    
    [self.contentView addSubview:self.goodsPriceLab];
    [self.goodsPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsSizeLab.mas_bottom).equalTo(@(WidthOfScale(28)));
        make.left.equalTo(self.goods.mas_right).equalTo(@(WidthOfScale(13)));
    }];
    
    [self.contentView addSubview:self.goodsStatusLab];
    [self.goodsStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsPriceLab.mas_right).equalTo(@(WidthOfScale(11)));
        make.centerY.equalTo(self.goodsPriceLab);
    }];
    
    
}

- (void)setModel:(EFOrderGoodsModel *)model {
    self.goodsNameLab.text = model.goodsTitle;
    self.goodsSizeLab.text = model.goodsProperty;
    self.goodsPriceLab.text = [NSString stringWithFormat:@"￥%.1f/件",model.goodsPrice];
//    self.goodsStatusLab.text = model.isAftersale ? @"已退款" : @"";
    self.goodsStatusLab.text = @"";
    self.goodsNumLab.text = [NSString stringWithFormat:@"X %ld",(long)model.quantity];
    [self.goods sd_setImageWithURL:[NSURL URLWithString:model.goodsImage] placeholderImage:UIImageMake(@"gg")];
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
