//
//  TuanListSelectView.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "TuanListSelectView.h"

@interface TuanListSelectView ()

@property (nonatomic,strong)QMUIButton *leftBtn;
@property (nonatomic,strong)QMUIButton *rightBtn;

@end

@implementation TuanListSelectView

-(QMUIButton *)leftBtn
{
    if (_leftBtn == nil) {
        _leftBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        _leftBtn.titleLabel.font = RegularFont15;
        [_leftBtn setTitle:@"时间顺序" forState:(UIControlStateNormal)];
        [_leftBtn setTitleColor:colorF14745 forState:(UIControlStateNormal)];
        _leftBtn.selected = YES;
        [_leftBtn setImage:kup forState:(UIControlStateNormal)];
        _leftBtn.imagePosition = QMUIButtonImagePositionRight;
        _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(10.5), 0, 0);
        @weakify(self);
        [[_leftBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
            x.selected = !x.selected;
            @strongify(self);
            if (x.selected) {
                [x setImage:kup forState:(UIControlStateNormal)];
                [self.rightBtn setImage:knormal forState:(UIControlStateNormal)];
                [self.rightBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
                self.rightBtn.selected = NO;
                [x setTitleColor:colorF14745 forState:(UIControlStateNormal)];
            }else {
                [x setImage:kdown forState:(UIControlStateNormal)];
                [x setTitleColor:colorF14745 forState:(UIControlStateNormal)];
            }
            if (self.leftBtnBlock) {
                self.leftBtnBlock(x.selected ? 1 : 2);
            }
        }];
    }
    return _leftBtn;
}

-(QMUIButton *)rightBtn
{
    if (_rightBtn == nil) {
        _rightBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        _rightBtn.titleLabel.font = RegularFont15;
        [_rightBtn setTitle:@"剩余最少" forState:(UIControlStateNormal)];
        [_rightBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        [_rightBtn setImage:knormal forState:(UIControlStateNormal)];
        _rightBtn.imagePosition = QMUIButtonImagePositionRight;
        _rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(10.5), 0, 0);
        @weakify(self);
        [[_rightBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
            x.selected = !x.selected;
            @strongify(self);
            if (x.selected) {
                [x setImage:kup forState:(UIControlStateNormal)];
                [self.leftBtn setImage:knormal forState:(UIControlStateNormal)];
                [self.leftBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
                self.leftBtn.selected = NO;
                [x setTitleColor:colorF14745 forState:(UIControlStateNormal)];
            }else {
                [x setImage:kdown forState:(UIControlStateNormal)];
                [x setTitleColor:colorF14745 forState:(UIControlStateNormal)];
            }
            if (self.rightBtnBlock) {
                self.rightBtnBlock(x.selected ? 1 : 2);
            }
        }];
    }
    return _rightBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.leftBtn];
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(WidthOfScale(15.5)));
            make.centerY.equalTo(self);
        }];
        [self addSubview:self.rightBtn];
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftBtn.mas_right).equalTo(@(WidthOfScale(101.5)));
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

@end
