//
//  EFFollowTuanTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/29.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFollowTuanTableViewCell.h"


@interface EFTuanTimeView : UIView

@property (nonatomic,strong)UIImageView *headerImageView;
@property (nonatomic,strong)QMUILabel *nameLab;
@property (nonatomic,strong)QMUILabel *timeLab;
@property (nonatomic,strong)LRAnimationProgress *progressView;
@property (nonatomic,strong)QMUIButton *pinBtn;


- (void)setData:(id)data;
@end

@implementation EFTuanTimeView


- (UIImageView *)headerImageView {
    if (_headerImageView == nil) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.backgroundColor = UIColor.whiteColor;
    }
    return _headerImageView;
}

- (QMUILabel *)nameLab {
    if (_nameLab == nil) {
        _nameLab = [[QMUILabel alloc] init];
        _nameLab.font = RegularFont15;
        _nameLab.textColor = tabbarBlackColor;
    }
    return _nameLab;
}

- (QMUILabel *)timeLab {
    if (_timeLab == nil) {
        _timeLab = [[QMUILabel alloc] init];
        _timeLab.font = RegularFont11;
        _timeLab.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
    }
    return _timeLab;
}

- (QMUIButton *)pinBtn {
    if (_pinBtn == nil) {
        _pinBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_pinBtn setTitle:@"拼单" forState:(UIControlStateNormal)];
        [_pinBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
        _pinBtn.titleLabel.font = MedFont13;
        _pinBtn.backgroundColor = colorF14745;
    }
    return _pinBtn;
}

- (LRAnimationProgress *)progressView {
    if (_progressView == nil) {
        _progressView = [[LRAnimationProgress alloc] initWithFrame:CGRectMake(0, 0, WidthOfScale(100), WidthOfScale(15))];
        _progressView.backgroundColor = [UIColor clearColor];
        _progressView.layer.cornerRadius = WidthOfScale(15)/2;
        _progressView.progressTintColors = @[RGB16(0xFF3B37),RGB16(0xFFBD20)];
//        _progressView.stripesWidth = 5;
        _progressView.stripesAnimated = YES;
        _progressView.hideStripes = NO;
        _progressView.hideAnnulus = NO;
    }
    return _progressView;
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
    [self addSubview:self.headerImageView];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(13.5)));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(39), WidthOfScale(39)));
    }];
    [self.headerImageView layoutIfNeeded];
    [self.headerImageView ViewRadius];
    
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(62)));
        make.top.equalTo(@(WidthOfScale(25)));
        make.height.equalTo(@(WidthOfScale(14.5)));
    }];
    
    [self addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(62)));
        make.bottom.equalTo(@(-WidthOfScale(24)));
        make.height.equalTo(@(WidthOfScale(11)));
    }];
    
    [self addSubview:self.pinBtn];
    [self.pinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(13.5)));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(60), WidthOfScale(27)));
    }];
    [self.pinBtn layoutIfNeeded];
    [self.pinBtn ViewRadius:5];
    
    [self addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.pinBtn.mas_left).equalTo(@(-WidthOfScale(15)));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(100), WidthOfScale(15)));
    }];
    [self.progressView layoutIfNeeded];
}


- (void)setData:(id)data {
    self.nameLab.text = @"玛丽莲梦露";
    self.timeLab.text = @"仅剩 23:59:59";
    self.progressView.progress = 0.4;
    [self.progressView setTitle:@"剩余28%"];
}
@end





@interface EFFollowTuanTableViewCell ()

@property (nonatomic,strong)EFTuanTimeView *tuanView;

@end


@implementation EFFollowTuanTableViewCell

- (EFTuanTimeView *)tuanView {
    if (_tuanView == nil) {
        _tuanView = [[EFTuanTimeView alloc] init];
        _tuanView.backgroundColor = colorfafafa;
        _tuanView.userInteractionEnabled = YES;
        @weakify(self);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            @strongify(self);
            if (self.pintuanBlock) {
                self.pintuanBlock();
            }
        }];
        [_tuanView addGestureRecognizer:tap];
    }
    return _tuanView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.tuanView];
        [self.tuanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(WidthOfScale(15)));
            make.top.equalTo(self.headerImageView.mas_bottom).equalTo(@(WidthOfScale(18)));
            make.size.mas_equalTo(CGSizeMake(WidthOfScale(345), WidthOfScale(79)));
        }];
        
        [self.tuanView layoutIfNeeded];
        [self.tuanView ViewRadius:5];
        
        [self.collect mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tuanView.mas_bottom).equalTo(@(WidthOfScale(15)));
            make.left.equalTo(@(WidthOfScale(15)));
            make.size.mas_equalTo(CGSizeMake( WidthOfScale(375 - 15), WidthOfScale((375 - 45)/3)));
        }];
    }
    return self;
}

- (void)setModel:(id)model {
    self.shopNameLab.text = @"刘德华的店";
    self.shopClassLab.text = @"男装，女装，内衣";
    self.followLab.text = @"关注数：8255  回头率：60% ";
    self.adressLab.text = @"广东 深圳";
    [self.tuanView setData:@""];
    [self.collect reloadData];
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
