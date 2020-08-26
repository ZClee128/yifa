//
//  TuanGoodsView.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "TuanGoodsView.h"
#import "EFTeamGoodsModel.h"

@interface TuanGoodsView ()

@property (nonatomic,strong)UIImageView *goods;
@property (nonatomic,strong)QMUILabel *goodsNameLab;
@property (nonatomic,strong)UILabel *numLab;
@property (nonatomic,strong)UILabel *sellLab;
@property (nonatomic,strong)UILabel *priceLab;
@property (nonatomic,strong)QMUILabel *peopleLab;

@end

@implementation TuanGoodsView

-(UIImageView *)goods
{
    if (_goods == nil) {
        _goods = [[UIImageView alloc] init];
        _goods.size = CGSizeMake(WidthOfScale(140), WidthOfScale(140));
        [_goods ViewRadius:5];
        _goods.backgroundColor = colorEFEFEF;
//        _goods.image = UIImageMake(@"gg");
    }
    return _goods;
}


-(QMUILabel *)goodsNameLab
{
    if (_goodsNameLab == nil) {
        _goodsNameLab = [[QMUILabel alloc] init];
        _goodsNameLab.textAlignment = NSTextAlignmentLeft;
        _goodsNameLab.font = MedFont15;
        _goodsNameLab.textColor = tabbarBlackColor;
        _goodsNameLab.numberOfLines = 2;
    }
    return _goodsNameLab;
}

-(UILabel *)numLab
{
    if (_numLab == nil) {
        _numLab = [[UILabel alloc] init];
        _numLab.font = RegularFont13;
        _numLab.textColor = tabbarBlackColor;
        _numLab.textAlignment = NSTextAlignmentLeft;
    }
    return _numLab;
}

-(UILabel *)sellLab
{
    if (_sellLab == nil) {
        _sellLab = [[UILabel alloc] init];
        _sellLab.font = RegularFont13;
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

-(QMUILabel *)peopleLab
{
    if (_peopleLab == nil) {
        _peopleLab = [[QMUILabel alloc] init];
        _peopleLab.font = RegularFont13;
        _peopleLab.textColor = tabbarBlackColor;
        _peopleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _peopleLab;
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
    [self addSubview:self.goods];
    [self.goods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(15)));
        make.left.equalTo(@(WidthOfScale(15)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(140), WidthOfScale(140)));
    }];
    
    [self addSubview:self.goodsNameLab];
    [self.goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goods.mas_right).equalTo(@(WidthOfScale(15.5)));
        make.top.equalTo(self).equalTo(@(WidthOfScale(20)));
        make.right.equalTo(@(WidthOfScale(-25.5)));
    }];
    
    
    [self addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goods.mas_right).equalTo(@(WidthOfScale(15.5)));
        make.top.equalTo(self.goodsNameLab.mas_bottom).equalTo(@(WidthOfScale(13)));
        make.right.equalTo(@(WidthOfScale(-15)));
        make.height.equalTo(@(WidthOfScale(12.5)));
    }];
    
    [self addSubview:self.sellLab];
    [self.sellLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goods.mas_right).equalTo(@(WidthOfScale(15.5)));
        make.top.equalTo(self.numLab.mas_bottom).equalTo(@(WidthOfScale(7.5)));
        make.right.equalTo(@(WidthOfScale(-15)));
        make.height.equalTo(@(WidthOfScale(12.5)));
    }];
    
    [self addSubview:self.peopleLab];
    [self.peopleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goods.mas_right).equalTo(@(WidthOfScale(15.5)));
        make.top.equalTo(self.sellLab.mas_bottom).equalTo(@(WidthOfScale(7.5)));
        make.right.equalTo(@(WidthOfScale(-15)));
        make.height.equalTo(@(WidthOfScale(12.5)));
    }];
    
    [self addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goods.mas_right).equalTo(@(WidthOfScale(16.5)));
        make.top.equalTo(self.peopleLab.mas_bottom).equalTo(@(WidthOfScale(15.5)));
        make.right.equalTo(@(WidthOfScale(-15)));
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = colorfafafa;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(@(WidthOfScale(10)));
    }];
}

- (void)setModel:(EFTeamGoodsModel *)model {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:(10-(self.goodsNameLab.font.lineHeight - self.goodsNameLab.font.pointSize))];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.title length])];
    self.goodsNameLab.attributedText = attributedString;
    self.numLab.text = [NSString stringWithFormat:@"最低采购量：%@",model.miniOrderQuantity];
    self.sellLab.text = [NSString stringWithFormat:@"当前总量：%@",model.stock];
    self.peopleLab.text = [NSString stringWithFormat:@"已有拼单人数：%@",model.currentTeamSize];
    self.priceLab.attributedText = [[NSString stringWithFormat:@"¥%.2f",model.miniPrice] getAttributeWithChangeString:@"¥" ChangeFont:MedFont12 textColor:self.priceLab.textColor];
    [self.goods sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:UIImageMake(@"")];
}

@end
