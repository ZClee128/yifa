//
//  EFFastCollectionViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFastCollectionViewCell.h"
#import "GBGradientProgressView.h"

@interface EFFastCollectionViewCell ()

@property (nonatomic,strong)UIImageView *goods;
@property (nonatomic,strong)UILabel *priceLab;
@property (nonatomic,strong)GBGradientProgressView *progressView;

@end

@implementation EFFastCollectionViewCell

-(UILabel *)priceLab
{
    if (_priceLab == nil) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.font = MedFont16;
        _priceLab.textColor = tabbarRedColor;
        _priceLab.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLab;
}

- (UIImageView *)goods {
    if (_goods == nil) {
        _goods = [[UIImageView alloc] init];
        _goods.backgroundColor = colorEFEFEF;
    }
    return _goods;
}

- (GBGradientProgressView *)progressView {
    if (_progressView == nil) {
        _progressView = [[GBGradientProgressView alloc] initWithFrame:CGRectMake(0, 0, WidthOfScale(100), WidthOfScale(15))];
        _progressView.colorArr = @[(id)[RGB16(0xFFBD20) CGColor], (id)[RGB16(0xFF3838) CGColor]];
        _progressView.backgroundProgressColor = colorEFEFEF;
    }
    return _progressView;
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
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView ViewRadius:10];
    self.contentView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.goods];
    [self.goods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.width.equalTo(@(self.contentView.width));
        make.height.equalTo(@(self.contentView.width));
    }];
    
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goods.mas_bottom).equalTo(@(WidthOfScale(14.5)));
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    [self.contentView addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLab.mas_bottom).equalTo(@(WidthOfScale(8)));
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(100), WidthOfScale(15)));
    }];
    [self.progressView layoutIfNeeded];
    [self.contentView layoutIfNeeded];
}


- (void)setModel:(id)model {
    self.priceLab.text = @"7899.00";
    self.progressView.progress = 0.6;
}
@end
