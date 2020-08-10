//
//  EFOrderBtnTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/23.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOrderBtnTableViewCell.h"

@interface EFOrderBtnTableViewCell ()

@property (nonatomic,strong)QMUIButton *moreBtn;
@property (nonatomic,strong)QMUIButton *oneBtn;
@property (nonatomic,strong)QMUIButton *twoBtn;
@property (nonatomic,strong)QMUIButton *threeBtn;

@end

@implementation EFOrderBtnTableViewCell

-(QMUIButton *)oneBtn
{
    if (_oneBtn == nil) {
        _oneBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_oneBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        _oneBtn.titleLabel.font = RegularFont13;
        @weakify(self);
        [[_oneBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.oneClick) {
                self.oneClick();
            }
        }];
    }
    return _oneBtn;
}

-(QMUIButton *)twoBtn
{
    if (_twoBtn == nil) {
        _twoBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_twoBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        _twoBtn.titleLabel.font = RegularFont13;
        @weakify(self);
        [[_twoBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.twoClick) {
                self.twoClick();
            }
        }];
    }
    return _twoBtn;
}

-(QMUIButton *)threeBtn
{
    if (_threeBtn == nil) {
        _threeBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_threeBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        _threeBtn.titleLabel.font = RegularFont13;
        @weakify(self);
        [[_threeBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.threeClick) {
                self.threeClick();
            }
        }];
    }
    return _threeBtn;
}


-(QMUIButton *)moreBtn
{
    if (_moreBtn == nil) {
        _moreBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_moreBtn setImage:UIImageMake(@"dian") forState:(UIControlStateNormal)];
        @weakify(self);
        [[_moreBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
            @strongify(self);
            if (self.moreClick) {
                self.moreClick(x);
            }
        }];
    }
    return _moreBtn;
}

- (void)setUI {
    [self.contentView addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(22)));
        make.left.equalTo(@(WidthOfScale(15.5)));
    }];
    
    [self.contentView addSubview:self.threeBtn];
    [self.threeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15)));
        make.top.equalTo(@(WidthOfScale(15)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(89), WidthOfScale(35)));
    }];
    [self.threeBtn layoutIfNeeded];
    [self.threeBtn AddImageRadiusBorderWithColor:RGB16(0xD6D6D6) lineWidth:1 radius:WidthOfScale(35)/2];
    
    [self.contentView addSubview:self.twoBtn];
    [self.twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.threeBtn.mas_left).equalTo(@(-WidthOfScale(15)));
        make.top.equalTo(@(WidthOfScale(15)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(89), WidthOfScale(35)));
    }];
    [self.twoBtn layoutIfNeeded];
    [self.twoBtn AddImageRadiusBorderWithColor:RGB16(0xD6D6D6) lineWidth:1 radius:WidthOfScale(35)/2];
    
    [self.contentView addSubview:self.oneBtn];
    [self.oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.twoBtn.mas_left).equalTo(@(-WidthOfScale(15)));
        make.top.equalTo(@(WidthOfScale(15)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(89), WidthOfScale(35)));
    }];
    [self.oneBtn layoutIfNeeded];
    [self.oneBtn AddImageRadiusBorderWithColor:RGB16(0xD6D6D6) lineWidth:1 radius:WidthOfScale(35)/2];
}

- (void)setModel:(id)model {
    
    [self.oneBtn setTitle:@"查看物流" forState:(UIControlStateNormal)];
    [self.twoBtn setTitle:@"确认收货" forState:(UIControlStateNormal)];
    [self.threeBtn setTitle:@"待付款" forState:(UIControlStateNormal)];
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
