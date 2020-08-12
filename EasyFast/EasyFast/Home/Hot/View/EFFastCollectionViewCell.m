//
//  EFFastCollectionViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFastCollectionViewCell.h"
#import "EFFastModel.h"
@interface EFFastCollectionViewCell ()



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
        _goods.image = UIImageMake(@"gg");
    }
    return _goods;
}

- (LRAnimationProgress *)progressView {
    if (_progressView == nil) {
        _progressView = [[LRAnimationProgress alloc] initWithFrame:CGRectMake(0, 0, WidthOfScale(100), WidthOfScale(15))];
        _progressView.backgroundColor = [UIColor clearColor];
        _progressView.layer.cornerRadius = WidthOfScale(15)/2;
        _progressView.progressTintColors = @[RGB16(0xFF3B37),RGB16(0xFFBD20)];
//        _progressView.stripesWidth = 5;
        _progressView.stripesAnimated = YES;
        _progressView.hideStripes = NO;
        _progressView.hideAnnulus = NO;
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


- (void)setModel:(EFFastModel *)model {
    self.priceLab.attributedText = [[NSString stringWithFormat:@"¥%.1f",model.groupPrice] getAttributeWithChangeString:@"¥" ChangeFont:RegularFont12 textColor:self.priceLab.textColor];
    self.progressView.progress = model.teamProcess / 100;
    [self.progressView setTitle:[NSString stringWithFormat:@"剩余%.f%%",100 - model.teamProcess]];
    [self.goods sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:UIImageMake(@"")];
}
@end
