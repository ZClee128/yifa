//
//  EFSetUpTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFSetUpTableViewCell.h"

@interface EFSetUpTableViewCell ()

@property (nonatomic,strong)QMUILabel *subTitleLab;
@property (nonatomic,strong)UIImageView *moreView;
@property (nonatomic,strong)QMUILabel *titleLab;
@property (nonatomic,strong)UIImageView *headerImageView;

@end

@implementation EFSetUpTableViewCell

-(UIImageView *)headerImageView
{
    if (_headerImageView == nil) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.hidden = YES;
        _headerImageView.backgroundColor = colorEFEFEF;
    }
    return _headerImageView;
}

-(UIImageView *)moreView
{
    if (_moreView == nil) {
        _moreView = [[UIImageView alloc] init];
        _moreView.image = UIImageMake(@"more");
    }
    return _moreView;
}

-(QMUILabel *)titleLab
{
    if (_titleLab == nil) {
        _titleLab = [[QMUILabel alloc] init];
        _titleLab.font = MedFont15;
        _titleLab.textColor = tabbarBlackColor;
    }
    return _titleLab;
}

-(QMUILabel *)subTitleLab
{
    if (_subTitleLab == nil) {
        _subTitleLab = [[QMUILabel alloc] init];
        _subTitleLab.font = MedFont15;
        _subTitleLab.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
    }
    return _subTitleLab;
}


- (void)setUI {
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15.5)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.subTitleLab];
    [self.subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(43.5)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.headerImageView];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(44.5)));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(39), WidthOfScale(39)));
    }];
    [self.headerImageView layoutIfNeeded];
    [self.headerImageView ViewRadius];
    
    [self.contentView addSubview:self.moreView];
    [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15)));
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setModel:(id)model {
    if ([model isKindOfClass:[NSDictionary class]]) {
        self.titleLab.text = model[@"title"];
        self.subTitleLab.text = model[@"subTitle"];
        [self.headerImageView sd_setImageWithURL:model[@"header"] placeholderImage:UIImageMake(@"header")];
    }
}

- (void)hiddenMore {
    [self.subTitleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15.5)));
    }];
    self.moreView.hidden = YES;
}

- (void)showMore {
    [self.subTitleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(43.5)));
    }];
    self.moreView.hidden = NO;
}

- (void)hiddenHeader {
    self.headerImageView.hidden = YES;
}

- (void)showHeader {
    self.headerImageView.hidden = NO;
}

- (void)setHeaderImage:(NSString *)header {
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:header] placeholderImage:UIImageMake(@"header")];
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
