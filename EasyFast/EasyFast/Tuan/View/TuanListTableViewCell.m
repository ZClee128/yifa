//
//  TuanListTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "TuanListTableViewCell.h"
#import "TuanPeopleView.h"


@interface TuanListTableViewCell ()

@property (nonatomic,strong)LRAnimationProgress *progressView;
@property (nonatomic,strong)QMUILabel *numLab;
@property (nonatomic,strong)QMUILabel *timeLab;
@property (nonatomic,strong)QMUIButton *buyBtn;

@end

@implementation TuanListTableViewCell

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

-(QMUIButton *)buyBtn
{
    if (_buyBtn == nil) {
        _buyBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_buyBtn setTitle:@"拼单" forState:(UIControlStateNormal)];
        [_buyBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
        _buyBtn.titleLabel.font = MedFont15;
        _buyBtn.backgroundColor = colorF14745;
    }
    return _buyBtn;
}

- (void)setUI {
    [self.contentView addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15)));
        make.top.equalTo(@(WidthOfScale(21.5)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(110), WidthOfScale(17)));
    }];
    
//    [self.contentView addSubview:self.numLab];
//    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.progressView.mas_right).equalTo(@(WidthOfScale(10)));
//        make.centerY.equalTo(self.progressView);
//    }];
    
    [self.contentView addSubview:self.buyBtn];
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15)));
        make.top.equalTo(@(WidthOfScale(15)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(75), WidthOfScale(30)));
    }];
    [self.buyBtn layoutIfNeeded];
    [self.buyBtn ViewRadius:5];
    
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.progressView.mas_right).equalTo(@(WidthOfScale(31)));
        make.centerY.equalTo(self.progressView);
    }];
    UIView *line = [[UIView alloc ] init];
    line.backgroundColor = colorfafafa;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(kPHONE_WIDTH, WidthOfScale(10)));
    }];
}

- (void)setModel:(id)model {
    self.progressView.progress = 0.6;
    [self.progressView setTitle:@"剩余30%"];
//    self.numLab.text = @"30%";
    self.timeLab.text = @"05:59:59";
    for (int i = 0; i < 3; i++) {
        if ([self.contentView viewWithTag:300+i]) {
            TuanPeopleView *p = (TuanPeopleView *)[self.contentView viewWithTag:300+i];
            [p setModel:@""];
        }else {
            TuanPeopleView *p = [[TuanPeopleView alloc] initWithFrame:CGRectMake(15, WidthOfScale(55)+i*(WidthOfScale(40)), kPHONE_WIDTH-30, WidthOfScale(30))];
            p.tag = i+300;
            [self.contentView addSubview:p];
            [p setModel:@""];
        }
    }
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
