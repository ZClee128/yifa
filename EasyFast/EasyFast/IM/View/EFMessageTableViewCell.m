//
//  EFMessageTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/9/2.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFMessageTableViewCell.h"

@implementation EFMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.container.userInteractionEnabled = NO;
        _myTextLabel = [[UILabel alloc] init];
        _myTextLabel.numberOfLines = 0;
        _myTextLabel.font = [UIFont systemFontOfSize:15];
        _myTextLabel.textColor = tabbarBlackColor;
        [self.container addSubview:_myTextLabel];
    }
    return self;
}

- (void)fillWithData:(EFMessageCellData *)data;
{
    [super fillWithData:data];
    self.customData = data;
    self.myTextLabel.text = data.text;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.myTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(5));
        make.top.equalTo(@(5));
    }];
}
@end
