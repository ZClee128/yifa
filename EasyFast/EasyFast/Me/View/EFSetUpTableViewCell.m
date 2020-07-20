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

@end

@implementation EFSetUpTableViewCell

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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
