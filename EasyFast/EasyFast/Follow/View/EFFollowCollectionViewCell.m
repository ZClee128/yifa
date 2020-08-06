//
//  EFFollowCollectionViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFollowCollectionViewCell.h"

@interface EFFollowCollectionViewCell()

@property (nonatomic,strong)UIImageView *goods;
@property (nonatomic,strong)QMUILabel *priceLab;

@end

@implementation EFFollowCollectionViewCell

-(UIImageView *)goods
{
    if (_goods == nil) {
        _goods = [[UIImageView alloc] init];
        _goods.backgroundColor = colorF14745;
        _goods.image = UIImageMake(@"gg");
    }
    return _goods;
}

-(QMUILabel *)priceLab
{
    if (_priceLab == nil) {
        _priceLab = [[QMUILabel alloc] init];
        _priceLab.font = RegularFont11;
        _priceLab.textColor = [UIColor whiteColor];
        _priceLab.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
        _priceLab.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLab;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}


- (void)setUI {
    [self.contentView ViewRadius:5];
    [self.contentView addSubview:self.goods];
    [self.goods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(WidthOfScale(-4)));
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.equalTo(@(55));
        make.height.equalTo(@(WidthOfScale(20)));
    }];
    [self.priceLab layoutIfNeeded];

}

- (void)setModel:(EFGoodsList *)model {
    self.priceLab.attributedText = [[NSString stringWithFormat:@"¥%.1f",model.price] getAttributeWithChangeString:@"¥" ChangeFont:RegularFont10 textColor:[UIColor whiteColor]];
    [self.priceLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@([self.priceLab.attributedText AttributedStringFont:RegularFont11 maxHeight:WidthOfScale(20)] + 18));
    }];
    [self.priceLab layoutIfNeeded];
    [self.contentView layoutIfNeeded];
    [self.priceLab ViewRadius:WidthOfScale(20)/2];
    [self.goods sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:UIImageMake(@"gg")];
}
@end
