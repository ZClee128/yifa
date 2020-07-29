//
//  MeListTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/17.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "MeListTableViewCell.h"

@interface MeListTableViewCell ()

@property (nonatomic,strong)UIImageView *iconView;
@property (nonatomic,strong)UIImageView *moreView;
@property (nonatomic,strong)QMUILabel *titleLab;

@end


@implementation MeListTableViewCell


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
        _moreView.image = UIImageMake(@"more");
    }
    return _moreView;
}

-(QMUILabel *)titleLab
{
    if (_titleLab == nil) {
        _titleLab = [[QMUILabel alloc] init];
        _titleLab.font = RegularFont14;
        _titleLab.textColor = tabbarBlackColor;
    }
    return _titleLab;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setUI {
    [self.contentView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(29)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).equalTo(@(WidthOfScale(16)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.moreView];
    [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(16)));
        make.centerY.equalTo(self.contentView);
    }];
    
    UIView *line = [[UIView alloc] init];
    [self.contentView addSubview:line];
    line.backgroundColor = RGB16(0xf2f2f2);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(0));
        make.right.equalTo(@(-WidthOfScale(15)));
        make.left.equalTo(self.titleLab.mas_left).equalTo(@(0));
        make.height.equalTo(@(1));
    }];
}

- (void)setModel:(id)model {
    if ([model isKindOfClass:[NSDictionary class]]) {
        self.iconView.image = UIImageMake(model[@"icon"]);
        self.titleLab.text  = model[@"title"];
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
