//
//  MeHeaderView.m
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "MeHeaderView.h"
#import "VerticalLabelBotton.h"

@interface MeHeaderView ()

@property (nonatomic,strong)UIImageView *bgImageView;
@property (nonatomic,strong)UIImageView *headerImageView;
@property (nonatomic,strong)QMUILabel *nameLab;
@property (nonatomic,strong)QMUIButton *setupBtn;
@property (nonatomic,strong)QMUIButton *becomeBtn;
@property (nonatomic,strong)QMUIButton *vipBtn;


@end


@implementation MeHeaderView

-(UIImageView *)bgImageView
{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = UIImageMake(@"bg");
    }
    return _bgImageView;
}

-(UIImageView *)headerImageView
{
    if (_headerImageView == nil) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.image = UIImageMake(@"header");
    }
    return _headerImageView;
}

-(QMUILabel *)nameLab
{
    if (_nameLab == nil) {
        _nameLab = [[QMUILabel alloc] init];
        _nameLab.font = MedFont17;
        _nameLab.textColor = color39342F;
        _nameLab.text = @"昵称可以八个字";
    }
    return _nameLab;
}

-(QMUIButton *)setupBtn
{
    if (_setupBtn == nil) {
        _setupBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_setupBtn setImage:UIImageMake(@"setup") forState:(UIControlStateNormal)];
    }
    return _setupBtn;
}

-(QMUIButton *)becomeBtn
{
    if (_becomeBtn == nil) {
        _becomeBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_becomeBtn setTitle:@"成为商家" forState:(UIControlStateNormal)];
        [_becomeBtn setTitleColor:color39342F forState:(UIControlStateNormal)];
        _becomeBtn.titleLabel.font = RegularFont14;
        _becomeBtn.backgroundColor = colorFFF9EB;
    }
    return _becomeBtn;
}

-(QMUIButton *)vipBtn
{
    if (_vipBtn == nil) {
        _vipBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_vipBtn setTitle:@"成为VIP" forState:(UIControlStateNormal)];
        [_vipBtn setTitleColor:colorF14745 forState:(UIControlStateNormal)];
        _vipBtn.titleLabel.font = MedFont14;
    }
    return _vipBtn;
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
    [self addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self addSubview:self.headerImageView];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(25)));
        make.top.equalTo(@(WidthOfScale(65)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(75), WidthOfScale(75)));
    }];
    [self.headerImageView layoutIfNeeded];
    [self.headerImageView ViewRadius];
    
    [self addSubview:self.becomeBtn];
    [self.becomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(WidthOfScale(14.5)));
        make.top.equalTo(@(WidthOfScale(38.5)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(99.5), WidthOfScale(24)));
    }];
    [self.becomeBtn layoutIfNeeded];
    [self.becomeBtn ViewRadius:WidthOfScale(24)/2];
    
    [self addSubview:self.setupBtn];
    [self.setupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.becomeBtn.mas_left).equalTo(@(-WidthOfScale(14.5)));
        make.top.equalTo(@(WidthOfScale(40)));
    }];
    
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageView.mas_right).equalTo(@(WidthOfScale(16)));
        make.top.equalTo(self.headerImageView.mas_top).equalTo(@(WidthOfScale(12.5)));
        make.height.equalTo(@(WidthOfScale(16.5)));
        make.right.equalTo(@(-WidthOfScale(25)));
    }];
    
    [self addSubview:self.vipBtn];
    [self.vipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.headerImageView.mas_right).equalTo(@(WidthOfScale(15)));
       make.bottom.equalTo(self.headerImageView.mas_bottom).equalTo(@(-WidthOfScale(6.5)));
       make.height.equalTo(@(WidthOfScale(25)));
        make.width.equalTo(@(WidthOfScale(71.5)));
    }];
    [self.vipBtn layoutIfNeeded];
    [self.vipBtn AddImageRadiusBorderWithColor:colorF14745 lineWidth:1 radius:WidthOfScale(25)/2];
    
    UIView *bottomBg = [[UIView alloc] init];
    bottomBg.backgroundColor = RGB16(0xFFF7E4);
    [self addSubview:bottomBg];
    [bottomBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(345), WidthOfScale(70)));
    }];
    [bottomBg layoutIfNeeded];
    [bottomBg AddImageRadius:10 withUIRectCorner:UIRectCornerTopLeft|UIRectCornerTopRight];
    bottomBg.layer.masksToBounds = YES;
    
    NSArray *titles = @[@"关注店铺",@"浏览足迹",@"我的消息"];
    for (int i = 0; i<titles.count; i++) {
        VerticalLabelBotton *btn = [[VerticalLabelBotton alloc] initWithFrame:CGRectMake(i*bottomBg.width/3, WidthOfScale(22), bottomBg.width/3, WidthOfScale(37))];
        [bottomBg addSubview:btn];
        btn.tag = i+100;
        [btn setTopTilte:@"0" bottomTitle:titles[i]];
    }
}

@end
