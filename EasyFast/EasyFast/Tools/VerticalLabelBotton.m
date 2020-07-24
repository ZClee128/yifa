//
//  VerticalLabelBotton.m
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "VerticalLabelBotton.h"

@interface VerticalLabelBotton ()



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
}

- (void)setTopTilte:(NSString *)top bottomTitle:(NSString *)bottom {
    self.topLab.text = top;
    self.bottomLab.text = bottom;
}

@end
