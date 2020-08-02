//
//  EFCalendarCollectionViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/8/2.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFCalendarCollectionViewCell.h"


@interface EFCalendarCollectionViewCell ()

@property (nonatomic,strong)QMUILabel *weekLab;
@property (nonatomic,strong)QMUILabel *dayBtn;
@property (nonatomic,strong)UIView *dotView;

@end



@implementation EFCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.weekLab = [[QMUILabel alloc] init];
    self.weekLab.font = RegularFont14;
    self.weekLab.textColor = colorAEAEAE;
    self.weekLab.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:self.weekLab];
    [self.weekLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(15.5)));
        make.centerX.equalTo(self.contentView);
    }];
    
    self.dayBtn = [[QMUILabel alloc] init];
    self.dayBtn.font = RegularFont15;
    self.dayBtn.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:self.dayBtn];
    [self.dayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(@(WidthOfScale(41)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(25), WidthOfScale(25)));
    }];
    
    [self.dayBtn layoutIfNeeded];
    [self.dayBtn ViewRadius];
    
    self.dotView = [[UIView alloc] init];
    [self.contentView addSubview:self.dotView];
    [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(@(WidthOfScale(71)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(5), WidthOfScale(5)));
    }];
    self.dotView.backgroundColor = colorF14745;
    [self.dotView layoutIfNeeded];
    [self.dotView ViewRadius];
}

- (void)setData:(CalendarModel *)model {
    self.weekLab.text = model.week;
    self.dayBtn.text = model.day;
    if (model.isToday) {
        self.dayBtn.backgroundColor = [colorF14745 colorWithAlphaComponent:0.7];
        self.dayBtn.textColor = UIColor.whiteColor;
    }else {
        self.dayBtn.backgroundColor = UIColor.whiteColor;
        self.dayBtn.textColor = tabbarBlackColor;
    }
    if (model.isSelect) {
        self.dayBtn.backgroundColor = colorF14745;
        self.dayBtn.textColor = UIColor.whiteColor;
    }else if (!model.isToday && !model.isSelect){
        self.dayBtn.backgroundColor = UIColor.whiteColor;
        self.dayBtn.textColor = tabbarBlackColor;
    }
    self.dotView.hidden = !model.hasFoot;
}


@end
