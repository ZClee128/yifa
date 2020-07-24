//
//  EFOrderShopTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOrderShopTableViewCell.h"

@interface EFOrderShopTableViewCell ()

@property (nonatomic,strong)QMUIButton *shopNameBtn;
@property (nonatomic,strong)QMUIButton *contactBtn;

@end

@implementation EFOrderShopTableViewCell

- (QMUIButton *)shopNameBtn {
    if (_shopNameBtn == nil) {
        _shopNameBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_shopNameBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        _shopNameBtn.titleLabel.font = MedFont15;
        [_shopNameBtn setImage:UIImageMake(@"small_more") forState:(UIControlStateNormal)];
        _shopNameBtn.imagePosition = QMUIButtonImagePositionRight;
        _shopNameBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(10.5), 0, 0);
    }
    return _shopNameBtn;
}

- (QMUIButton *)contactBtn {
    if (_contactBtn == nil) {
        _contactBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_contactBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        _contactBtn.titleLabel.font = RegularFont14;
        [_contactBtn setImage:UIImageMake(@"kefu") forState:(UIControlStateNormal)];
        _contactBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WidthOfScale(10.5));
    }
    return _contactBtn;
}

- (void)setUI {
    [self.contentView addSubview:self.shopNameBtn];
    [self.shopNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(14.5)));
        make.centerY.equalTo(self.contentView);
    }];
    [self.shopNameBtn layoutIfNeeded];
    [self.contentView addSubview:self.contactBtn];
    [self.contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(14)));
        make.centerY.equalTo(self.contentView);
    }];
    [self.contactBtn layoutIfNeeded];
    UIView *line = [[UIView alloc] init];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-0));
        make.width.equalTo(@(kPHONE_WIDTH - WidthOfScale(30)));
        make.left.equalTo(@(WidthOfScale(15)));
        make.height.equalTo(@(WidthOfScale(1)));
    }];
    line.backgroundColor = RGB16(0xF2F2F2);
}

- (void)setModel:(id)model {
    [self.shopNameBtn setTitle:@"张飞的店" forState:(UIControlStateNormal)];
    [self.contactBtn setTitle:@"联系卖家" forState:(UIControlStateNormal)];
    
    
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
