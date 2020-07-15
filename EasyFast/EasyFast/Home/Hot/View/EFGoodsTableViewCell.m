//
//  EFGoodsTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFGoodsTableViewCell.h"
#import "TKTagView.h"

@interface EFGoodsTableViewCell()

@property (nonatomic,strong)UIImageView *goods;
@property (nonatomic,strong)UILabel *goodsNameLab;
@property (nonatomic,strong)TKTagView *listView;
@property (nonatomic,strong)UILabel *numLab;
@property (nonatomic,strong)UILabel *sellLab;
@property (nonatomic,strong)UILabel *priceLab;
@property (nonatomic,strong)QMUIButton *buyBtn;

@end

@implementation EFGoodsTableViewCell

-(UIImageView *)goods
{
    if (_goods == nil) {
        _goods = [[UIImageView alloc] init];
        _goods.size = CGSizeMake(WidthOfScale(140), WidthOfScale(140));
        [_goods ViewRadius:5];
        _goods.backgroundColor = colorEFEFEF;
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

-(QMUIButton *)buyBtn
{
    if (_buyBtn == nil) {
        _buyBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_buyBtn setTitle:@"我要拼单" forState:(UIControlStateNormal)];
        [_buyBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
        _buyBtn.titleLabel.font = MedFont13;
        [_buyBtn setBackgroundImage:[UIImage imageWithMixColors:@[RGB16(0xFFBD20),RGB16(0xFF3B37)] size:CGSizeMake(90, 27)] forState:(UIControlStateNormal)];
    }
    return _buyBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self.contentView addSubview:self.goods];
    [self.goods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(15));
        make.left.equalTo(@(15));
        make.size.mas_equalTo(CGSizeMake(140, 140));
    }];
    
    [self.contentView addSubview:self.goodsNameLab];
    [self.goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goods.mas_right).equalTo(@(15));
        make.top.equalTo(@(21));
        make.right.equalTo(@(-15));
    }];
    
    [self.contentView addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goods.mas_right).equalTo(@(15));
        make.top.equalTo(self.goodsNameLab.mas_bottom).equalTo(@(9));
        make.width.equalTo(@(WidthOfScale(190)));
        make.height.equalTo(@(16));
    }];
    [self.listView layoutIfNeeded];
    
    [self.contentView addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goods.mas_right).equalTo(@(15));
        make.top.equalTo(self.listView.mas_bottom).equalTo(@(18));
        make.right.equalTo(@(-15));
    }];
    
    [self.contentView addSubview:self.sellLab];
    [self.sellLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goods.mas_right).equalTo(@(15));
        make.top.equalTo(self.numLab.mas_bottom).equalTo(@(8));
        make.right.equalTo(@(-15));
    }];
    
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goods.mas_right).equalTo(@(15));
        make.bottom.equalTo(@(-7));
    }];
    
    [self.contentView addSubview:self.buyBtn];
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.bottom.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(90, 27));
    }];
    [self.buyBtn layoutIfNeeded];
    [self.buyBtn ViewRadius:27/2];
    
    [self.contentView layoutIfNeeded];
}


- (void)setModel:(id)model {
    self.goodsNameLab.text = @"商品名称只有一行，多余的";
    self.listView.tagTitleArray = @[@"极速发货",@"极速发货"];
    [self.listView createTags];
    self.numLab.text = @"最低采购量：100";
    self.sellLab.text = @"成交量：9999+";
    self.priceLab.text = @"7899.8";
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
