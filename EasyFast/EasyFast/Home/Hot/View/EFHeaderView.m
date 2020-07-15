//
//  EFHeaderView.m
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFHeaderView.h"

@interface EFHeaderView ()

@property (nonatomic,strong)UILabel *leftLab;
@property (nonatomic,strong)QMUIButton *rightBtn;

@end

@implementation EFHeaderView

-(UILabel *)leftLab
{
    if (_leftLab == nil) {
        _leftLab = [[UILabel alloc] init];
        _leftLab.font = MedFont17;
        _leftLab.textColor = tabbarBlackColor;
        _leftLab.textAlignment = NSTextAlignmentLeft;
    }
    return _leftLab;
}

- (QMUIButton *)rightBtn {
    if (_rightBtn == nil) {
        _rightBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_rightBtn setImage:[UIImage imageNamed:@"more"] forState:(UIControlStateNormal)];
        _rightBtn.imagePosition = QMUIButtonImagePositionRight;
        _rightBtn.titleLabel.font = RegularFont14;
        [_rightBtn setTitleColor:RGB16(0xAEAEAE) forState:(UIControlStateNormal)];
    }
    return _rightBtn;
}

- (instancetype)initWithFrame:(CGRect)frame WithLeftTitle:(NSString *)left  WithRightTitle:(NSString *)right{
    if (self = [super initWithFrame:frame]) {
        [self setUIWithLeft:left Right:right];
    }
    return self;
}

- (void)setUIWithLeft:(NSString *)left Right:(NSString *)right {
    [self addSubview:self.leftLab];
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15)));
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@(self.height));
    }];
    self.leftLab.text = left;
    
    [self addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15)));
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@(17));
    }];
    if ([right isEqualToString:@""]) {
        self.rightBtn.hidden = YES;
    }else{
        self.rightBtn.hidden = NO;
        [self.rightBtn setTitle:right forState:(UIControlStateNormal)];
    }
    
}

- (UILabel *)getLeftLab {
    return self.leftLab;
}

@end
