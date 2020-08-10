//
//  EFWuliuTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFWuliuTableViewCell.h"
#import "EFOrderModel.h"

@interface EFWuliuTableViewCell ()

@property(nonatomic,strong)UIImageView *icon;
@property (nonatomic,strong)QMUILabel *StatusLab;
@property (nonatomic,strong)YYLabel *detailLab;

@property (nonatomic,strong)NSMutableAttributedString *text;
@end

@implementation EFWuliuTableViewCell

- (UIImageView *)icon {
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        _icon.image = UIImageMake(@"huoche");
    }
    return _icon;
}

- (QMUILabel *)StatusLab {
    if (_StatusLab == nil) {
        _StatusLab = [[QMUILabel alloc] init];
        _StatusLab.font = MedFont16;
        _StatusLab.textColor = tabbarBlackColor;
    }
    return _StatusLab;
}

- (YYLabel *)detailLab {
    if (_detailLab == nil) {
        _detailLab = [[YYLabel alloc] init];
        _detailLab.numberOfLines = 3;
    }
    return _detailLab;
}

- (void)setUI {
    [self.contentView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(@(WidthOfScale(15.5)));
    }];
    
    [self.contentView addSubview:self.StatusLab];
    [self.StatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(19)));
        make.left.equalTo(@(WidthOfScale(57)));
    }];
    
    [self.contentView addSubview:self.detailLab];
    [self.detailLab  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.StatusLab.mas_bottom).equalTo(@(WidthOfScale(12.5)));
        make.left.equalTo(@(WidthOfScale(56.5)));
        make.height.equalTo(@(WidthOfScale(52.5)));
        make.right.equalTo(@(-WidthOfScale(52.5)));
    }];
    
    UIImageView *more = [[UIImageView alloc] initWithImage:UIImageMake(@"small_more")];
    [self.contentView addSubview:more];
    [more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(@(-WidthOfScale(15)));
    }];
    
    UIView *line = [[UIView alloc] init];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-0));
        make.width.equalTo(@(kPHONE_WIDTH - WidthOfScale(30)));
        make.left.equalTo(@(WidthOfScale(15)));
        make.height.equalTo(@(WidthOfScale(1)));
    }];
    line.backgroundColor = RGB16(0xF2F2F2);
    
}

- (void)setModel:(EFOrderModel *)model {
    self.StatusLab.text = model.express.state;
    self.text  = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@,%@",model.express.create,model.express.context]];
    self.text.font = RegularFont13;
    self.text.color = tabbarBlackColor;
    self.text.lineSpacing = 10; // 行间距
    self.detailLab.attributedText = self.text;
}

- (CGFloat)getCellHeight{
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(WidthOfScale(265.5), CGFLOAT_MAX) text:self.text];
    [self.detailLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(layout.textBoundingSize.height));
    }];
    return WidthOfScale(63)+layout.textBoundingSize.height;
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
