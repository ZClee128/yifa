//
//  EFFastTuanListCollectionViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/8/3.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFastTuanListCollectionViewCell.h"
#import "EFFastModel.h"
@interface EFFastTuanListCollectionViewCell ()

@property (nonatomic,strong)QMUILabel *goodsNameLab;

@end

@implementation EFFastTuanListCollectionViewCell

- (QMUILabel *)goodsNameLab {
    if (_goodsNameLab == nil) {
        _goodsNameLab = [[QMUILabel alloc] init];
        _goodsNameLab.font = RegularFont14;
        _goodsNameLab.textColor = tabbarBlackColor;
        _goodsNameLab.textAlignment = NSTextAlignmentCenter;
    }
    return _goodsNameLab;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.goodsNameLab];
        
        [self.priceLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goods.mas_bottom).equalTo(@(WidthOfScale(9.5)));
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.height.equalTo(@(WidthOfScale(14.5)));
        }];
        
        [self.goodsNameLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.priceLab.mas_bottom).equalTo(@(WidthOfScale(9.5)));
            make.left.equalTo(@(WidthOfScale(15)));
            make.right.equalTo(@(-WidthOfScale(15)));
            make.height.equalTo(@(WidthOfScale(13.5)));
        }];
        
        [self.progressView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodsNameLab.mas_bottom).equalTo(@(WidthOfScale(13)));
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(WidthOfScale(117), WidthOfScale(18)));
        }];
        [self.progressView layoutIfNeeded];
        [self.contentView layoutIfNeeded];
    }
    return self;
}

- (void)setModel:(EFFastModel *)model {
    self.priceLab.attributedText = [[NSString stringWithFormat:@"¥%.1f",model.groupPrice] getAttributeWithChangeString:@"¥" ChangeFont:RegularFont12 textColor:self.priceLab.textColor];
    self.progressView.progress = model.teamProcess / 100;
    [self.progressView setTitle:[NSString stringWithFormat:@"剩余%.f%%",100-model.teamProcess]];
    self.goodsNameLab.text = model.title;
    [self.goods sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:UIImageMake(@"")];
}

@end
