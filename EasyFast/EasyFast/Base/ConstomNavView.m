//
//  ConstomNavView.m
//  flag
//
//  Created by zclee on 2020/5/16.
//  Copyright © 2020 zclee. All rights reserved.
//

#import "ConstomNavView.h"



@interface ConstomNavView ()

@property (nonatomic,strong)UILabel *TitleLab;
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)NSArray *rightBtns;

@end

@implementation ConstomNavView

-(UILabel *)TitleLab
{
    if (_TitleLab == nil) {
        _TitleLab = [[UILabel alloc] init];
        _TitleLab.font = [UIFont runtimeFitFont:18 weight:(UIFontWeightSemibold)];
        _TitleLab.textColor = RGB16(0x333333);
    }
    return _TitleLab;
}

-(UIButton *)leftBtn
{
    if (_leftBtn == nil) {
        _leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_leftBtn setImage:[UIImage imageNamed:@"nav_button_back"] forState:(UIControlStateNormal)];
    }
    return _leftBtn;
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
    [self addSubview:self.TitleLab];
    [self.TitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(9 + STATUS_BAR_HEIGHT));
        make.centerX.equalTo(self);
    }];
    [self addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.centerY.equalTo(self.TitleLab);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}

- (void)setNavTitle:(NSString *)text {
    self.TitleLab.text = text;
}

/// 设置右按钮
/// @param rightBtns 传入图片名字，顺序从右往左
- (void)setRightBtns:(NSArray *)rightBtns {
    @weakify(self);
    for (int i = 0; i < rightBtns.count; i++) {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        UIImage *image = [UIImage imageNamed:rightBtns[i]];
        [btn setImage:image forState:(UIControlStateNormal)];
        [self addSubview:btn];
        btn.tag = i;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-(i*image.size.width + 10)));
            make.centerY.equalTo(self.TitleLab);
        }];
        [[btn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(UIButton *xBtn) {
            @strongify(self);
            if (self.block) {
                self.block(xBtn);
            }
        }];
    }
}

- (void)hiddenBackBtn {
    self.leftBtn.hidden = YES;
}

- (void)showBackBtn {
    self.leftBtn.hidden = NO;
}

- (RACSignal *)backClick {
    return [self.leftBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)];
}

- (UIButton *)getLeftBtn {
    return self.leftBtn;
}

@end
