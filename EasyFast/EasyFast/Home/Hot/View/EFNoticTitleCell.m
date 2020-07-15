//
//  EFNoticTitleCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFNoticTitleCell.h"


@interface EFNoticTitleCell ()

@property (nonatomic,strong)UILabel *noticLab;
@end

@implementation EFNoticTitleCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.backgroundColor = RGB16(0xFFF5DD);
    self.noticLab = [[UILabel alloc] init];
    self.noticLab.font = RegularFont13;
    self.noticLab.textColor = RGB16(0x6C5E3D);
    self.noticLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.noticLab];
    [self.noticLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}

- (void)setTitle:(NSString *)title {
    self.noticLab.text = title;
}
@end
