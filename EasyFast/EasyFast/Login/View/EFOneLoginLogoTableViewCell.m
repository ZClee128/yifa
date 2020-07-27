//
//  EFOneLoginTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOneLoginLogoTableViewCell.h"


@interface EFOneLoginLogoTableViewCell()

@end

@implementation EFOneLoginLogoTableViewCell


- (void)setUI {
    UIImageView *logo = [[UIImageView alloc] init];
    logo.image = UIImageMake(@"fast");
    [self.contentView addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(97.5)));
        make.centerX.equalTo(self.contentView);
    }];
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
