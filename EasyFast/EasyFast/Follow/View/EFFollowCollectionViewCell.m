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
@property (nonatomic,strong)QMUIButton *priceLab;

@end

@implementation EFFollowCollectionViewCell

-(UIImageView *)goods
{
    if (_goods == nil) {
        _goods = [[UIImageView alloc] init];
        _goods.backgroundColor = colorF14745;
    }
    return _goods;
}

-(QMUIButton *)priceLab
{
    if (_priceLab == nil) {
        _priceLab = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        _priceLab.contentEdgeInsets = UIEdgeInsetsMake(WidthOfScale(6), WidthOfScale(9), WidthOfScale(6), WidthOfScale(9));
        _priceLab.titleLabel.font = RegularFont11;
        [_priceLab setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _priceLab.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
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
    [self.priceLab ViewRadius:WidthOfScale(20)/2];
}

- (void)setModel:(id)model {
    [self.priceLab setTitle:@"¥999.8" forState:(UIControlStateNormal)];
    [self.priceLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(55));
    }];
}
@end
