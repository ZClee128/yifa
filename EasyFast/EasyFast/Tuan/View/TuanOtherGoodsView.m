//
//  TuanOtherGoodsView.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "TuanOtherGoodsView.h"

@interface TuanOtherGoodsView ()

@property (nonatomic,strong)UIImageView *goods;
@property (nonatomic,strong)UILabel *goodsNameLab;
@property (nonatomic,strong)UILabel *sellLab;
@property (nonatomic,strong)UILabel *priceLab;

@end


@implementation TuanOtherGoodsView

-(UIImageView *)goods
{
    if (_goods == nil) {
        _goods = [[UIImageView alloc] init];
        _goods.size = CGSizeMake(WidthOfScale(167), WidthOfScale(165));
        _goods.backgroundColor = colorEFEFEF;
    }
    return _goods;
}


-(UILabel *)goodsNameLab
{
    if (_goodsNameLab == nil) {
        _goodsNameLab = [[UILabel alloc] init];
        _goodsNameLab.textAlignment = NSTextAlignmentLeft;
        _goodsNameLab.font = MedFont15;
        _goodsNameLab.textColor = tabbarBlackColor;
    }
    return _goodsNameLab;
}

-(UILabel *)sellLab
{
    if (_sellLab == nil) {
        _sellLab = [[UILabel alloc] init];
        _sellLab.font = RegularFont12;
        _sellLab.textColor = tabbarBlackColor;
        _sellLab.textAlignment = NSTextAlignmentLeft;
    }
    return _sellLab;
}

- (UILabel *)priceLab {
    if (_priceLab == nil) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.font = MedFont16;
        _priceLab.textColor = tabbarRedColor;
        _priceLab.textAlignment = NSTextAlignmentLeft;
    }
    return _priceLab;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.backgroundColor = UIColor.whiteColor;
    [self ViewRadius:5];
    [self addSubview:self.goods];
    [self.goods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(167), WidthOfScale(165)));
    }];
    
    [self addSubview:self.goodsNameLab];
    [self.goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(10)));
        make.right.equalTo(@(-WidthOfScale(10)));
        make.top.equalTo(self.goods.mas_bottom).equalTo(@(WidthOfScale(11.5)));
        make.height.equalTo(@(WidthOfScale(14.5)));
    }];
    
    
    [self addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(@(WidthOfScale(10)));
       make.top.equalTo(self.goodsNameLab.mas_bottom).equalTo(@(WidthOfScale(14)));
       make.height.equalTo(@(WidthOfScale(11.5)));
    }];
    
    [self addSubview:self.sellLab];
    [self.sellLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLab.mas_right).equalTo(@(WidthOfScale(10.5)));
        make.top.equalTo(self.goodsNameLab.mas_bottom).equalTo(@(WidthOfScale(15)));
        make.height.equalTo(@(WidthOfScale(11.5)));
    }];
    [self layoutIfNeeded];
}

- (void)setModel:(id)model {
    self.goodsNameLab.text = @"这里左右边距20像素";
    self.sellLab.text = @"成交量：9999+";
    self.priceLab.attributedText = [@"¥7899.8" getAttributeWithChangeString:@"¥" ChangeFont:RegularFont12 textColor:self.priceLab.textColor];
}

@end
