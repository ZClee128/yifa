//
//  EFHelpTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFHelpTableViewCell.h"
#import "EFHelpModel.h"
@interface EFHelpTableViewCell ()

@property (nonatomic,strong)QMUILabel *titleLab;
@end

@implementation EFHelpTableViewCell

- (QMUILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[QMUILabel alloc] init];
        _titleLab.font = RegularFont15;
        _titleLab.textColor = tabbarBlackColor;
    }
    return _titleLab;
}

- (void)setUI {
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15.5)));
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(@(-WidthOfScale(42.5)));
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(WidthOfScale(15), 0, kPHONE_WIDTH - WidthOfScale(30), 1)];
    line.backgroundColor = RGB16(0xf2f2f2);
    [self.contentView addSubview:line];
    
    UIImageView *more = [[UIImageView alloc] initWithImage:UIImageMake(@"more")];
    [self.contentView addSubview:more];
    [more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15)));
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setModel:(EFHelpModel *)model {
    self.titleLab.text = model.title;
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
