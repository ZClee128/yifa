//
//  EFPayTypeTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/8/3.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFPayTypeTableViewCell.h"
#import "EFPayModel.h"
@interface EFPayTypeTableViewCell ()

@property (nonatomic,strong)UIImageView *icon;
@property (nonatomic,strong)QMUILabel *titleLab;
@property (nonatomic,strong)UIImageView *selectIcon;

@end


@implementation EFPayTypeTableViewCell


- (UIImageView *)icon {
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        
    }
    return _icon;
}

- (UIImageView *)selectIcon {
    if (_selectIcon == nil) {
        _selectIcon = [[UIImageView alloc] init];
        _selectIcon.image = UIImageMake(@"pay_select");
    }
    return _selectIcon;
}

- (QMUILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[QMUILabel alloc] init];
        _titleLab.font = RegularFont14;
        _titleLab.textColor = tabbarBlackColor;
    }
    return _titleLab;
}

- (void)setUI {
    [self.contentView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).equalTo(@(WidthOfScale(8.5)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.selectIcon];
    [self.selectIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15.5)));
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setModel:(EFPayModel *)model {
    self.icon.image = UIImageMake(model.icon);
    self.titleLab.text = model.title;
    self.selectIcon.hidden = !model.isChoose;
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
