//
//  LeftTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/22.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "LeftTableViewCell.h"
#import "EFClassifyModel.h"

@interface LeftTableViewCell ()

@property (nonatomic, strong) UIImageView *flagView;
@property (nonatomic,strong)QMUILabel *titleLab;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation LeftTableViewCell


-(QMUILabel *)titleLab
{
    if (_titleLab == nil) {
        _titleLab = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, WidthOfScale(100), WidthOfScale(50))];
        _titleLab.font = RegularFont15;
        _titleLab.textColor = tabbarBlackColor;
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (void)setUI {
    self.bgView = [[UIView alloc] init];
    self.bgView.frame = CGRectMake(0, 0, WidthOfScale(100), WidthOfScale(50));
    self.bgView.backgroundColor = colorfafafa;
    [self.contentView addSubview:self.bgView];
    
    [self.contentView addSubview:self.titleLab];
    
    self.flagView = [[UIImageView alloc] init];
    self.flagView.frame = CGRectMake(0, 0, 3, WidthOfScale(50));
    self.flagView.image = [UIImage imageWithVerticalMixColors:@[RGB16(0xFFBD20),RGB16(0xFF3838)] size:self.flagView.size];
    [self.contentView addSubview:self.flagView];
}

- (void)setModel:(EFClassifyModel *)model {
    self.titleLab.text = model.title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected)
    {
        self.bgView.backgroundColor = [UIColor whiteColor];
        self.flagView.hidden = NO;
    }
    else
    {
        self.bgView.backgroundColor = colorfafafa;
        self.flagView.hidden = YES;
    }
}

@end
