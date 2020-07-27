//
//  TuanListDetailSecsionView.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "TuanListDetailSecsionView.h"


@interface TuanListDetailSecsionView ()

@property (nonatomic,strong)QMUILabel *numLab;
@property (nonatomic,strong)QMUILabel *timeLab;
@property (nonatomic,strong)LRAnimationProgress *progressView;

@end

@implementation TuanListDetailSecsionView

- (LRAnimationProgress *)progressView {
    if (_progressView == nil) {
        _progressView = [[LRAnimationProgress alloc] initWithFrame:CGRectMake(0, 0, WidthOfScale(110), WidthOfScale(17))];
        _progressView.backgroundColor = [UIColor clearColor];
        _progressView.layer.cornerRadius = WidthOfScale(17)/2;
        _progressView.progressTintColors = @[RGB16(0xFF3B37),RGB16(0xFFBD20)];
        _progressView.stripesWidth = 5;
        _progressView.stripesAnimated = YES;
        _progressView.hideStripes = NO;
        _progressView.hideAnnulus = NO;
    }
    return _progressView;
}

-(QMUILabel *)numLab
{
    if (_numLab == nil) {
        _numLab = [[QMUILabel alloc] init];
        _numLab.font = RegularFont13;
        _numLab.textColor = tabbarBlackColor;
    }
    return _numLab;
}

-(QMUILabel *)timeLab
{
    if (_timeLab == nil) {
        _timeLab = [[QMUILabel alloc] init];
        _timeLab.font = RegularFont14;
        _timeLab.textColor = tabbarBlackColor;
    }
    return _timeLab;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15)));
        make.top.equalTo(@(WidthOfScale(21.5)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(110), WidthOfScale(17)));
    }];
    
    [self addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.progressView.mas_right).equalTo(@(WidthOfScale(10)));
        make.centerY.equalTo(self.progressView);
    }];
    
    [self addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15.5)));
        make.centerY.equalTo(self.numLab);
    }];

}


- (void)setModel:(id)model {
    self.progressView.progress = 0.6;
    self.timeLab.text = @"仅剩05:59:59";
    [self.progressView setTitle:@"剩余30%"];
}
@end
