//
//  TuanListTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "TuanListTableViewCell.h"
#import "TuanPeopleView.h"
#import "EFTeamListModel.h"
#import "TimeLabel.h"

@interface TuanListTableViewCell ()

@property (nonatomic,strong)LRAnimationProgress *progressView;
@property (nonatomic,strong)QMUILabel *numLab;
@property (nonatomic,strong)TimeLabel *timeLab;
@property (nonatomic,strong)QMUIButton *buyBtn;
@property (nonatomic,strong)CountDown *timer;
@property (nonatomic,strong)EFTeamListModel *teamModel;

@end

@implementation TuanListTableViewCell

- (LRAnimationProgress *)progressView {
    if (_progressView == nil) {
        _progressView = [[LRAnimationProgress alloc] initWithFrame:CGRectMake(0, 0, WidthOfScale(110), WidthOfScale(17))];
        _progressView.backgroundColor = [UIColor clearColor];
        _progressView.layer.cornerRadius = WidthOfScale(17)/2;
        _progressView.progressTintColors = @[RGB16(0xFF3B37),RGB16(0xFFBD20)];
//        _progressView.stripesWidth = 5;
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

-(TimeLabel *)timeLab
{
    if (_timeLab == nil) {
        _timeLab = [[TimeLabel alloc] init];
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
        [[_buyBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.btnBlock) {
                self.btnBlock();
            }
        }];
    }
    return _buyBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
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
//    self.timer = [[CountDown alloc] init];
    
}


- (void)setModel:(EFTeamListModel *)model {
    self.teamModel = model;
    self.progressView.progress = model.teamProcess / 100;
    [self.progressView setTitle:[NSString stringWithFormat:@"剩余%.f%%",100 - model.teamProcess]];
//    self.numLab.text = @"30%";
//    [self.timer countDownWithStratDate:model.currentDate finishDate:model.expireDate completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
//        if (day) {
//            self.timeLab.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld:%02ld",(long)day,(long)hour,(long)minute,(long)second];
//        }else {
//            self.timeLab.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour,(long)minute,(long)second];
//        }
//    }];
    [self.timeLab countDownWithStratDate:model.currentDate finishDate:model.expireDate];
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[TuanPeopleView class]]) {
            [view removeFromSuperview];
        }
    }
    for (int i = 0; i < model.teamOrderDtoList.count; i++) {
        TuanPeopleView *p = [[TuanPeopleView alloc] initWithFrame:CGRectMake(15, WidthOfScale(55)+i*(WidthOfScale(40)), kPHONE_WIDTH-30, WidthOfScale(30))];
        p.tag = i+300;
        [self.contentView addSubview:p];
        [p setModel:model.teamOrderDtoList[i]];
    }
    [self.contentView layoutIfNeeded];
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
