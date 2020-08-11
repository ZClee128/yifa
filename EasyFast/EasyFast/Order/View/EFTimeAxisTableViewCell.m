//
//  EFTimeAxisTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFTimeAxisTableViewCell.h"
#import "VerticalLabelBotton.h"
#import "EFLogisticsModel.h"

@interface EFTimeAxisTableViewCell ()

@property (nonatomic,strong)UIImageView *dotImageView;
@property (nonatomic,strong)UIImageView *tmpImageView;
@property (nonatomic,strong)VerticalLabelBotton *timeView;
@property (nonatomic,strong)UIView  *topLine;
@property (nonatomic,strong)UIView  *bottomLine;
@property (nonatomic,strong)UIImage *normalImage;
@property (nonatomic,strong)UIImage *selectImage;
@property (nonatomic,strong)QMUILabel *detailLab;

@property (nonatomic,strong)NSMutableAttributedString *text;
@end


@implementation EFTimeAxisTableViewCell

- (UIImageView *)tmpImageView {
    if (_tmpImageView == nil) {
        _tmpImageView = [[UIImageView alloc] init];
    }
    return _tmpImageView;
}

- (UIImageView *)dotImageView {
    if (_dotImageView == nil) {
        _dotImageView = [[UIImageView alloc] init];
    }
    return _dotImageView;
}

- (UIView *)topLine {
    if (_topLine == nil) {
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = RGB16(0xFFC18D);
    }
    return _topLine;
}

- (UIView *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = RGB16(0xFFC18D);
    }
    return _bottomLine;
}

- (VerticalLabelBotton *)timeView {
    if (_timeView == nil ) {
        _timeView = [[VerticalLabelBotton alloc] init];
        _timeView.size = CGSizeMake(WidthOfScale(35.5), WidthOfScale(25));
        _timeView.topLab.font = RegularFont13;
        _timeView.topLab.textColor = tabbarBlackColor;
        _timeView.bottomLab.font = RegularFont12;
        _timeView.bottomLab.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
        [_timeView.bottomLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_timeView.topLab.mas_bottom).equalTo(@(WidthOfScale(5.5)));
        }];
    }
    return _timeView;
}

- (QMUILabel *)detailLab {
    if (_detailLab == nil) {
        _detailLab = [[QMUILabel alloc] init];
        _detailLab.font = RegularFont12;
        _detailLab.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
        _detailLab.numberOfLines = 0;
        _detailLab.textAlignment = NSTextAlignmentLeft;
    }
    return _detailLab;
}

- (void)setUI {
    self.normalImage = [UIImage imageWithColor:RGB16(0xFFC18D) size:CGSizeMake(10, 10) cornerRadius:5];
    self.selectImage = [UIImage imageWithColor:RGB16(0xFE851E) size:CGSizeMake(9, 9) cornerRadius:9/2];
    UIImage *image = [UIImage imageWithColor:RGB16(0xFFC18D) size:CGSizeMake(15, 15) cornerRadius:15/2];
    self.selectImage = [image qmui_imageWithImageAbove:self.selectImage atPoint:CGPointMake(floor(image.size.width/2-(9/2)), floor(image.size.width/2-(9/2)))];
    
    
    [self.contentView addSubview:self.tmpImageView];
    [self.tmpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(63.5));
        make.top.equalTo(@(WidthOfScale(22)));
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.contentView addSubview:self.dotImageView];
    [self.dotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.tmpImageView);
        make.centerY.equalTo(self.tmpImageView);
    }];
    self.dotImageView.image = self.normalImage;
    
    [self.contentView addSubview:self.timeView];
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tmpImageView);
        make.left.equalTo(@(WidthOfScale(15)));
//        make.right.equalTo(self.tmpImageView.mas_left).equalTo(@(-WidthOfScale(10)));
        make.height.equalTo(@(WidthOfScale(25)));
    }];
    
    [self.timeView layoutIfNeeded];
    
    [self.contentView addSubview:self.topLine];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.tmpImageView);
        make.bottom.equalTo(self.tmpImageView.mas_top).equalTo(@(0));
        make.top.equalTo(self.contentView);
        make.width.equalTo(@(1));
    }];
    
    [self.contentView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.tmpImageView);
        make.top.equalTo(self.tmpImageView.mas_bottom).equalTo(@(0));
        make.bottom.equalTo(self.contentView);
        make.width.equalTo(@(1));
    }];
    
    [self.contentView addSubview:self.detailLab];
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(89)));
        make.top.equalTo(self.tmpImageView.mas_top).equalTo(@(-WidthOfScale(0)));
        make.right.equalTo(@(-WidthOfScale(25.5)));
        make.bottom.equalTo(@(-WidthOfScale(21)));
    }];
}

- (void)setModel:(ExpressItemModel *)model {
    NSArray *times = [model.formatTime componentsSeparatedByString:@" "];
    [self.timeView setTopTilte:times[0] bottomTitle:times[1]];
    self.text  = [[NSMutableAttributedString alloc] initWithString: model.context];
    self.text.font = RegularFont12;
    self.text.color = [tabbarBlackColor colorWithAlphaComponent:0.7];
    self.text.lineSpacing = 5; // 行间距
    self.detailLab.attributedText = self.text;
}

- (CGFloat)getCellHeight{
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(WidthOfScale(206.5), CGFLOAT_MAX) text:self.text];
    return WidthOfScale(42)+layout.textBoundingSize.height;
}

- (void)setBlack {
    self.text.color = tabbarBlackColor;
    self.detailLab.attributedText = self.text;
}

- (void)setNormal {
    self.text.color = [tabbarBlackColor colorWithAlphaComponent:0.7];
    self.detailLab.attributedText = self.text;
}

- (void)hiddenTop {
    self.topLine.hidden = YES;
}

- (void)showTop {
    self.topLine.hidden = NO;
}

- (void)hiddenBottom {
    self.bottomLine.hidden = YES;
}

- (void)showBottom {
    self.bottomLine.hidden = NO;
}

- (void)setSelectImage {
    self.dotImageView.image = self.selectImage;
}

- (void)setNormalImage {
    self.dotImageView.image = self.normalImage;
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
