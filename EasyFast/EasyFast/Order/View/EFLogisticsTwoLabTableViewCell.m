//
//  EFLogisticsTwoLabTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFLogisticsTwoLabTableViewCell.h"

@implementation EFLogisticsTwoLabTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self hiddenCopy];
        self.leftLab.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
        self.leftLab.font = RegularFont14;
        self.rightLab.font =RegularFont14;
        [self.rightLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftLab.mas_right).equalTo(@(WidthOfScale(5.5)));
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
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
