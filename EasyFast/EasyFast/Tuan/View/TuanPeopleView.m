//
//  TuanPeopleView.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "TuanPeopleView.h"
#import "EFTeamListModel.h"
@interface TuanPeopleView ()

@property (nonatomic,strong)UIImageView *headerImageView;
@property (nonatomic,strong)QMUILabel *nameLab;
@property (nonatomic,strong)QMUILabel *numLab;
@property (nonatomic,strong)QMUILabel *timeLab;

@end

@implementation TuanPeopleView

-(UIImageView *)headerImageView
{
    if (_headerImageView == nil) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.size = CGSizeMake(WidthOfScale(30), WidthOfScale(30));
        [_headerImageView ViewRadius];
        _headerImageView.backgroundColor = colorEFEFEF;
    }
    return _headerImageView;
}

-(QMUILabel *)nameLab
{
    if (_nameLab == nil) {
        _nameLab = [[QMUILabel alloc] init];
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = RegularFont14;
        _nameLab.textColor = tabbarBlackColor;
    }
    return _nameLab;
}

-(QMUILabel *)numLab
{
    if (_numLab == nil) {
        _numLab = [[QMUILabel alloc] init];
        _numLab.font = RegularFont14;
        _numLab.textColor = tabbarBlackColor;
        _nameLab.textAlignment = NSTextAlignmentLeft;
    }
    return _numLab;
}

-(QMUILabel *)timeLab
{
    if (_timeLab == nil) {
        _timeLab = [[QMUILabel alloc] init];
        _timeLab.font = RegularFont14;
        _timeLab.textColor = tabbarBlackColor;
        _timeLab.textAlignment = NSTextAlignmentRight;
    }
    return _timeLab;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headerImageView];
        [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(WidthOfScale(30), WidthOfScale(30)));
        }];
        
        [self addSubview:self.nameLab];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerImageView.mas_right).equalTo(@(WidthOfScale(7.5)));
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(WidthOfScale(66), WidthOfScale(13)));
        }];
        
        [self addSubview:self.numLab];
        [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLab.mas_right).equalTo(@(WidthOfScale(27.5)));
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(WidthOfScale(89), WidthOfScale(13)));
        }];
        
        [self addSubview:self.timeLab];
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(WidthOfScale(97.5), WidthOfScale(13.5)));
        }];
    }
    return self;
}

- (void)setModel:(TeamOrderDtoModel *)model {
    self.nameLab.text = model.nickName;
    self.numLab.text = [NSString stringWithFormat:@"购买量：%@",model.quantity];
    self.timeLab.text = [NSString stringWithFormat:@"%@发起",[model.createDate DateToStringFormatter:@"MM.dd HH:mm"]];
}

@end
