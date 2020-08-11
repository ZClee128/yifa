//
//  VerticalLabelBotton.m
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "VerticalLabelBotton.h"

@interface VerticalLabelBotton ()

@property (nonatomic,strong)QMUILabel *countLab;

@end

@implementation VerticalLabelBotton


-(QMUILabel *)topLab
{
    if (_topLab == nil) {
        _topLab = [[QMUILabel alloc] init];
        _topLab.font = RegularFont21;
        _topLab.textColor = color39342F;
        _topLab.textAlignment = NSTextAlignmentCenter;
    }
    return _topLab;
}

-(QMUILabel *)bottomLab
{
    if (_bottomLab == nil) {
        _bottomLab = [[QMUILabel alloc] init];
        _bottomLab.font = RegularFont13;
        _bottomLab.textColor = color39342F;
        _bottomLab.textAlignment = NSTextAlignmentCenter;
    }
    return _bottomLab;
}

-(QMUILabel *)countLab
{
    if (_countLab == nil) {
        _countLab = [[QMUILabel alloc] init];
        _countLab.font = RegularFont13;
        _countLab.textColor = color39342F;
        _countLab.textAlignment = NSTextAlignmentCenter;
        _countLab.backgroundColor = colorF14745;
    }
    return _countLab;
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
    [self addSubview:self.topLab];
    [self.topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.equalTo(self);
        make.centerX.equalTo(self);
        make.height.equalTo(@(WidthOfScale(16)));
    }];
    
    [self addSubview:self.bottomLab];
    [self.bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLab.mas_bottom).equalTo(@(WidthOfScale(8.5)));
        make.width.equalTo(self);
        make.centerX.equalTo(self);
        make.height.equalTo(@(WidthOfScale(12.5)));
    }];
    
    [self addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLab.mas_top).equalTo(@(-5));
        make.right.equalTo(self.topLab.mas_right).equalTo(@(-WidthOfScale(self.width/3.5)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(11), WidthOfScale(11)));
    }];
    [self.countLab layoutIfNeeded];
    [self.countLab ViewRadius];
}

- (void)setTopTilte:(NSString *)top bottomTitle:(NSString *)bottom {
    self.topLab.text = top;
    self.bottomLab.text = bottom;
}

- (void)hiddenDot {
    self.countLab.hidden = YES;
}

- (void)showDot {
    self.countLab.hidden = NO;
}

@end
