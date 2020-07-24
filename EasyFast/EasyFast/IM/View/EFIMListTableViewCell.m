//
//  EFIMListTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFIMListTableViewCell.h"

@interface EFIMListTableViewCell ()

@property (nonatomic,strong)UIImageView *headerImageView;
@property (nonatomic,strong)QMUILabel *nameLab;
@property (nonatomic,strong)QMUILabel *contentLab;
@property (nonatomic,strong)QMUILabel *timeLab;
@property (nonatomic,strong)QMUILabel *numLab;

@end

@implementation EFIMListTableViewCell


- (UIImageView *)headerImageView {
    if (_headerImageView == nil) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.backgroundColor = colorEFEFEF;
    }
    return _headerImageView;
}

- (QMUILabel *)numLab {
    if (_numLab == nil ) {
        _numLab = [[QMUILabel alloc] init];
        _numLab.font = RegularFont13;
        _numLab.textColor = UIColor.whiteColor;
        _numLab.contentEdgeInsets = UIEdgeInsetsMake(WidthOfScale(6), WidthOfScale(7.5), WidthOfScale(6), WidthOfScale(7.5));
        _numLab.backgroundColor = colorF14745;
        _numLab.textAlignment = NSTextAlignmentCenter;
    }
    return _numLab;
}


- (QMUILabel *)contentLab {
    if (_contentLab == nil) {
        _contentLab = [[QMUILabel alloc] init];
        _contentLab.font = RegularFont13;
        _contentLab.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
    }
    return _contentLab;
}

- (QMUILabel *)timeLab {
    if (_timeLab == nil) {
        _timeLab = [[QMUILabel alloc] init];
        _timeLab.font = RegularFont13;
        _timeLab.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
    }
    return _timeLab;
}

- (QMUILabel *)nameLab {
    if (_nameLab == nil) {
        _nameLab = [[QMUILabel alloc] init];
        _nameLab.font = MedFont15;
        _nameLab.textColor = tabbarBlackColor;
    }
    return _nameLab;
}

- (void)setUI {
    [self.contentView addSubview:self.headerImageView];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15)));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(50), WidthOfScale(50)));
    }];
    [self.headerImageView layoutIfNeeded];
    [self.headerImageView ViewRadius];
    
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(21)));
        make.left.equalTo(@(WidthOfScale(80)));
    }];
    
    [self.contentView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-WidthOfScale(21.5)));
        make.left.equalTo(@(WidthOfScale(80)));
        make.right.equalTo(@(-WidthOfScale(77.5)));
    }];
    
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15.5)));
        make.top.equalTo(@(WidthOfScale(21.5)));
    }];
    
    [self.contentView addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15)));
        make.bottom.equalTo(@(-WidthOfScale(17.5)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(22), WidthOfScale(22)));
    }];
    [self.numLab layoutIfNeeded];
    self.numLab.layer.cornerRadius = WidthOfScale(22) / 2;
    self.numLab.layer.masksToBounds = YES;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(WidthOfScale(15), WidthOfScale(79), kPHONE_WIDTH - WidthOfScale(30), 1)];
    line.backgroundColor = RGB16(0xf2f2f2);
    [self.contentView addSubview:line];
}

- (void)setModel:(id)model {
    self.nameLab.text = @"张飞的店";
    self.contentLab.text = @"恭喜您获得本次平台福利，总共奖励...";
    self.timeLab.text = @"12:22";
    self.numLab.text = @"99+";
    CGSize size = [self.numLab.text boundingRectWithSize:CGSizeMake(MAXFLOAT,WidthOfScale(22)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:RegularFont13 } context:nil].size;
    if (self.numLab.text.length != 1) {
        if (size.width) {
            [self.numLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(size.width+WidthOfScale(15)));
            }];
        }
    }
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
