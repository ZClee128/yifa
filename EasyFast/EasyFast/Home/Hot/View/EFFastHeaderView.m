//
//  EFFastHeaderView.m
//  EasyFast
//
//  Created by easyfast on 2020/9/2.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFastHeaderView.h"

@interface EFFastHeaderView ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIImageView *fastImageView;
@property (nonatomic,strong)QMUILabel *peopleLab;
@property (nonatomic,strong)QMUIButton *moreBtn;
@property (nonatomic,strong)UIScrollView *imageScrollView;

@end


@implementation EFFastHeaderView

- (UIImageView *)fastImageView {
    if (_fastImageView == nil) {
        _fastImageView = [[UIImageView alloc] initWithImage:UIImageMake(@"fast_title")];
    }
    return _fastImageView;
}

- (UIScrollView *)imageScrollView {
    if (_imageScrollView == nil) {
        _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(WidthOfScale(91), WidthOfScale(10.5), WidthOfScale(23)*2 + WidthOfScale(22), flat(WidthOfScale(24)))];
        _imageScrollView.showsVerticalScrollIndicator = NO;
        _imageScrollView.showsHorizontalScrollIndicator = NO;
        _imageScrollView.delegate = self;
    }
    return _imageScrollView;
}

- (QMUILabel *)peopleLab {
    if (_peopleLab == nil) {
        _peopleLab = [[QMUILabel alloc] init];
        _peopleLab.textColor = RGB16(0xC76114);
        _peopleLab.font = RegularFont11;
        _peopleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _peopleLab;
}

- (QMUIButton *)moreBtn {
    if (_moreBtn == nil) {
        _moreBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_moreBtn setTitle:@"查看全部" forState:(UIControlStateNormal)];
        [_moreBtn setTitleColor:RGB16(0xC76114) forState:(UIControlStateNormal)];
        _moreBtn.titleLabel.font = RegularFont12;
        _moreBtn.backgroundColor = UIColor.whiteColor;
        @weakify(self);
        [[_moreBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.moreBlock) {
                self.moreBlock();
            }
        }];
    }
    return _moreBtn;
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
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = self.frame;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:249/255.0 green:192/255.0 blue:158/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:240/255.0 green:227/255.0 blue:218/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    [self.layer addSublayer:gl];
    
    [self addSubview:self.fastImageView];
    [self.fastImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15.5)));
        make.centerY.equalTo(self);
    }];
    
    [self addSubview:self.imageScrollView];
    
    [self addSubview:self.peopleLab];
    [self.peopleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageScrollView.mas_right).equalTo(@(WidthOfScale(9.5)));
        make.centerY.equalTo(self);
        make.height.equalTo(@(WidthOfScale(11)));
    }];
    
    [self addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15)));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(70), WidthOfScale(25)));
    }];
    [self.moreBtn layoutIfNeeded];
    [self.moreBtn ViewRadius:5];
}

- (void)setModel:(id)model {
    self.peopleLab.text = @"88+万人正在抢购";
    for (int i = 0; i < 10; i++) {
        UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(i*WidthOfScale(22), 0.5, flat(WidthOfScale(23)), flat(WidthOfScale(23)))];
        [self.imageScrollView addSubview:header];
        header.image = UIImageMake(@"header");
        [header AddImageRadiusBorderWithColor:UIColor.whiteColor lineWidth:1 radius:flat(WidthOfScale(23)/2)];
        header.tag = 200+i;
    }
    __block int i = 0;
    [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        i++;
        [UIView animateWithDuration:0.3 animations:^{
           self.imageScrollView.contentOffset = CGPointMake(WidthOfScale(22)*i, 0);
        }];
        if (i == 10 - 3) {
            i = 0;
            self.imageScrollView.contentOffset = CGPointMake(0, 0);
        }
        for (UIImageView *v in self.imageScrollView.subviews) {
            if (v.tag == (i-1)+200) {
                [UIView animateWithDuration:0.3 animations:^{
                    v.alpha = 0;
                }];
            }else {
                v.alpha = 1;
            }
        }
    }];
}

@end
