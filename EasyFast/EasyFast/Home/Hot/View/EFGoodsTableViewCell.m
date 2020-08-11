//
//  EFGoodsTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFGoodsTableViewCell.h"
#import "TKTagView.h"
#import "EFGoodsList.h"

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
        @weakify(self);
        [[_buyBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.btnSelect) {
                self.btnSelect();
            }
        }];
    }
    return _buyBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setUI {
    [self.contentView addSubview:self.goods];
    [self.goods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-0));
        make.left.equalTo(@(WidthOfScale(15)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(140), WidthOfScale(140)));
    }];
    
    [self.contentView addSubview:self.goodsNameLab];
    [self.goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goods.mas_right).equalTo(@(WidthOfScale(15)));
        make.top.equalTo(self.goods.mas_top).equalTo(@(WidthOfScale(6)));
        make.right.equalTo(@(WidthOfScale(-15)));
    }];
    
    [self.contentView addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goods.mas_right).equalTo(@(WidthOfScale(15)));
        make.top.equalTo(self.goodsNameLab.mas_bottom).equalTo(@(WidthOfScale(9)));
        make.width.equalTo(@(WidthOfScale(190)));
        make.height.equalTo(@(WidthOfScale(16)));
    }];
    [self.listView layoutIfNeeded];
    
    [self.contentView addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goods.mas_right).equalTo(@(WidthOfScale(15)));
        make.top.equalTo(self.listView.mas_bottom).equalTo(@(WidthOfScale(18)));
        make.right.equalTo(@(WidthOfScale(-15)));
    }];
    
    [self.contentView addSubview:self.sellLab];
    [self.sellLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goods.mas_right).equalTo(@(WidthOfScale(15)));
        make.top.equalTo(self.numLab.mas_bottom).equalTo(@(WidthOfScale(8)));
        make.right.equalTo(@(WidthOfScale(-15)));
    }];
    
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goods.mas_right).equalTo(@(WidthOfScale(15)));
        make.bottom.equalTo(@(-0));
    }];
    
    [self.contentView addSubview:self.buyBtn];
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.bottom.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(90), WidthOfScale(27)));
    }];
    [self.buyBtn layoutIfNeeded];
    [self.buyBtn ViewRadius:WidthOfScale(27)/2];
    
    [self.contentView layoutIfNeeded];
}


- (void)setModel:(EFGoodsList *)model {
    self.goodsNameLab.text = model.title;
    if (model.tags.count != 0) {
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        for (EFTagsModel *tag in model.tags) {
            [titles addObject:tag.title];
        }
        self.listView.tagTitleArray = titles;
        [self.listView createTags];
    }
    self.numLab.text = [NSString stringWithFormat:@"最低采购量：%ld",model.miniOrderLimit];
    self.sellLab.text = [NSString stringWithFormat:@"成交量：%ld",model.sales];
    self.priceLab.attributedText = [[NSString stringWithFormat:@"¥%.1f",model.price] getAttributeWithChangeString:@"¥" ChangeFont:RegularFont12 textColor:self.priceLab.textColor];
    [self.goods sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:UIImageMake(@"gg")];
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
