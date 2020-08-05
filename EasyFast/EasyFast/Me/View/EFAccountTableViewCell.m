//
//  EFAccountTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFAccountTableViewCell.h"


@interface EFAccountTableViewCell ()

@property (nonatomic,strong)UIImageView *iconView;
@property (nonatomic,strong)UIImageView *moreView;
@property (nonatomic,strong)QMUILabel *titleLab;

@end

@implementation EFAccountTableViewCell

-(UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

-(UIImageView *)moreView
{
    if (_moreView == nil) {
        _moreView = [[UIImageView alloc] init];
        _moreView.image = UIImageMake(@"xuanze");
    }
    return _moreView;
}

-(QMUILabel *)titleLab
{
    if (_titleLab == nil) {
        _titleLab = [[QMUILabel alloc] init];
        _titleLab.font = RegularFont15;
        _titleLab.textColor = tabbarBlackColor;
    }
    return _titleLab;
}

- (void)setUI {
    [self.contentView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15)));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(39), WidthOfScale(39)));
    }];
    [self.iconView layoutIfNeeded];
    [self.iconView ViewRadius];
    
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).equalTo(@(WidthOfScale(16)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.moreView];
    [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15.5)));
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setModel:(EFUserModel *)model {
    self.titleLab.text = model.username;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.headImgUrl] placeholderImage:UIImageMake(@"header")];
    self.moreView.hidden = !model.isLogin;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
