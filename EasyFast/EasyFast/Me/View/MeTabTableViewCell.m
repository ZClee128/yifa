//
//  MeTabTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/17.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "MeTabTableViewCell.h"

@interface MeTabTableViewCell ()

@property (nonatomic,strong)QMUILabel *titleLab;
@property (nonatomic,strong)QMUIButton *moreBtn;

@end


@implementation MeTabTableViewCell

-(QMUILabel *)titleLab
{
    if (_titleLab == nil) {
        _titleLab = [[QMUILabel alloc] init];
        _titleLab.font = MedFont17;
        _titleLab.textColor = tabbarBlackColor;
    }
    return _titleLab;
}

-(QMUIButton *)moreBtn
{
    if (_moreBtn == nil) {
        _moreBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_moreBtn setTitle:@"全部" forState:(UIControlStateNormal)];
        _moreBtn.titleLabel.font = RegularFont14;
        [_moreBtn setTitleColor:colorAEAEAE forState:(UIControlStateNormal)];
        [_moreBtn setImage:UIImageMake(@"more") forState:(UIControlStateNormal)];
        _moreBtn.imagePosition = QMUIButtonImagePositionRight;
        @weakify(self);
        [[_moreBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.moreBlock) {
                self.moreBlock();
            }
        }];
    }
    return _moreBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setUI {
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(20)));
        make.left.equalTo(@(WidthOfScale(15.5)));
    }];
    [self.contentView addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(20)));
        make.right.equalTo(@(-WidthOfScale(20.5)));
    }];
}

- (void)setData:(NSArray *)btns title:(NSString *)title {
    self.titleLab.text = title;
    @weakify(self);
    for (int i = 0 ; i < btns.count; i++) {
        QMUIButton *btn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame = CGRectMake(i*kPHONE_WIDTH/btns.count, WidthOfScale(51), kPHONE_WIDTH/btns.count, WidthOfScale(62.5));
        [btn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        [btn setTitle:btns[i][@"title"] forState:(UIControlStateNormal)];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = RegularFont14;
        [btn setImage:UIImageMake(btns[i][@"icon"]) forState:(UIControlStateNormal)];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, WidthOfScale(7.5), 0);
        btn.imagePosition = QMUIButtonImagePositionTop;
        btn.tag = i;
        [self.contentView addSubview:btn];
        [[btn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
            @strongify(self);
            if (self.seletBtn) {
                self.seletBtn(x.tag);
            }
        }];
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
