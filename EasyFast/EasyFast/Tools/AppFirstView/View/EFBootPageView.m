//
//  EFBootPageView.m
//  EasyFast
//
//  Created by easyfast on 2020/8/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBootPageView.h"

@interface EFBootPageView()

@property (nonatomic,strong)UIImageView *imageview;
@property (nonatomic,strong)QMUILabel *TitleLab;
@property (nonatomic,strong)QMUILabel *SubTitleLab;

@end

@implementation EFBootPageView

- (UIImageView *)imageview {
    if (_imageview == nil) {
        _imageview = [[UIImageView alloc] init];
        _imageview.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageview;
}

- (QMUILabel *)TitleLab {
    if (_TitleLab == nil) {
        _TitleLab = [[QMUILabel alloc] init];
        _TitleLab.font = MedFont23;
        _TitleLab.textColor = RGB16(0xFFFAF1);
    }
    return _TitleLab;
}

- (QMUILabel *)SubTitleLab {
    if (_SubTitleLab == nil) {
        _SubTitleLab = [[QMUILabel alloc] init];
        _SubTitleLab.font = MedFont23;
        _SubTitleLab.textColor = RGB16(0xFFFAF1);
    }
    return _SubTitleLab;
}


- (instancetype)initWithFrame:(CGRect)frame WithModel:(EFBootpageModel *)model
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = model.bacgroudColor;
        [self addSubview:self.imageview];
        self.imageview.image = UIImageMake(model.bgImage);
        [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.width.equalTo(@(kPHONE_WIDTH));
            make.height.equalTo(@(WidthOfScale(475)));
            make.centerX.equalTo(self);
        }];
        
        [self addSubview:self.TitleLab];
        self.TitleLab.text = model.title;
        [self.TitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageview.mas_bottom).equalTo(@(WidthOfScale(model.titletop)));
            make.height.equalTo(@(WidthOfScale(22)));
            make.centerX.equalTo(self);
        }];
        
        [self addSubview:self.SubTitleLab];
        self.SubTitleLab.text = model.subTitle;
        [self.SubTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.TitleLab.mas_bottom).equalTo(@(WidthOfScale(13)));
            make.height.equalTo(@(WidthOfScale(22)));
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

@end
