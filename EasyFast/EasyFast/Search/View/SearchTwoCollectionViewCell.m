//
//  SearchTwoCollectionViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "SearchTwoCollectionViewCell.h"
#import "TKTagView.h"

@interface SearchTwoCollectionViewCell ()

@property (nonatomic,strong)UIImageView *goods;
@property (nonatomic,strong)UILabel *goodsNameLab;
@property (nonatomic,strong)TKTagView *listView;
@property (nonatomic,strong)UILabel *numLab;
@property (nonatomic,strong)UILabel *sellLab;
@property (nonatomic,strong)UILabel *priceLab;

@end

@implementation SearchTwoCollectionViewCell

-(UIImageView *)goods
{
    if (_goods == nil) {
        _goods = [[UIImageView alloc] init];
        _goods.size = CGSizeMake(WidthOfScale(167), WidthOfScale(165));
        _goods.backgroundColor = colorEFEFEF;
        _goods.image = UIImageMake(@"gg");
    }
    return _goods;
}

- (TKTagView *)listView {
    if (_listView == nil) {
        _listView = [[TKTagView alloc] init];
        _listView.tagFontSize = 12;
        _listView.tagTitleColorArray = @[tabbarRedColor];
        _listView.tagColorArray = @[RGB16(0xFFEAE9)];
    }
    return _listView;
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

-(UILabel *)numLab
{
    if (_numLab == nil) {
        _numLab = [[UILabel alloc] init];
        _numLab.font = RegularFont12;
        _numLab.textColor = tabbarBlackColor;
        _numLab.textAlignment = NSTextAlignmentLeft;
    }
    return _numLab;
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

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView ViewRadius:5];
    [self.contentView addSubview:self.goods];
    [self.goods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(167), WidthOfScale(165)));
    }];
    
    [self.contentView addSubview:self.goodsNameLab];
    [self.goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(10)));
        make.right.equalTo(@(-WidthOfScale(10)));
        make.top.equalTo(self.goods.mas_bottom).equalTo(@(WidthOfScale(11.5)));
        make.height.equalTo(@(WidthOfScale(14.5)));
    }];
    
    [self.contentView addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(10)));
        make.width.equalTo(@(WidthOfScale(167-20)));
        make.top.equalTo(self.goodsNameLab.mas_bottom).equalTo(@(WidthOfScale(6.5)));
        make.height.equalTo(@(WidthOfScale(16)));
    }];
    [self.listView layoutIfNeeded];
    
    [self.contentView addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(10)));
        make.right.equalTo(@(-WidthOfScale(10)));
        make.top.equalTo(self.listView.mas_bottom).equalTo(@(WidthOfScale(9)));
        make.height.equalTo(@(WidthOfScale(11.5)));
    }];
    
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(@(WidthOfScale(10)));
       make.top.equalTo(self.numLab.mas_bottom).equalTo(@(WidthOfScale(14)));
       make.height.equalTo(@(WidthOfScale(12.5)));
    }];
    
    [self.contentView addSubview:self.sellLab];
    [self.sellLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLab.mas_right).equalTo(@(WidthOfScale(10.5)));
        make.top.equalTo(self.numLab.mas_bottom).equalTo(@(WidthOfScale(15)));
        make.height.equalTo(@(WidthOfScale(11.5)));
    }];
    [self.contentView layoutIfNeeded];
}

- (void)setModel:(id)model {
    self.goodsNameLab.text = @"这里左右边距20像素";
    self.listView.tagTitleArray = @[@"极速",@"极货"];
    [self.listView createTags];
    self.numLab.text = @"最低采购量：100";
    self.sellLab.text = @"成交量：9999+";
    self.priceLab.text = @"7899.8";
}
@end
