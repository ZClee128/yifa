//
//  EFRealPriceTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFRealPriceTableViewCell.h"

@interface EFRealPriceTableViewCell ()

@property (nonatomic,strong)QMUIButton *moreBtn;

@end

@implementation EFRealPriceTableViewCell

- (QMUIButton *)moreBtn {
    if (_moreBtn == nil) {
        _moreBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_moreBtn setImage:UIImageMake(@"more_up") forState:(UIControlStateNormal)];
        [_moreBtn setImage:UIImageMake(@"less_down") forState:(UIControlStateSelected)];
        [_moreBtn setTitleColor:colorF14745 forState:(UIControlStateNormal)];
        [_moreBtn setTitleColor:colorF14745 forState:(UIControlStateSelected)];
        _moreBtn.titleLabel.font = MedFont15;
        _moreBtn.imagePosition = QMUIButtonImagePositionRight;
        _moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(15.5), 0, 0);
        [[_moreBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
            x.selected = !x.selected;
            if (self.moreClick) {
                self.moreClick(x);
            }
        }];
    }
    return _moreBtn;
}

- (void)setUI {
    [self.contentView addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15)));
        make.top.equalTo(@(WidthOfScale(6)));
    }];
    
    QMUILabel *titleLab = [[QMUILabel alloc] init];
    titleLab.font = RegularFont15;
    titleLab.textColor = tabbarBlackColor;
    titleLab.text = @"实付款";
    [self.contentView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15)));
        make.top.equalTo(@(WidthOfScale(6.5)));
    }];
}

- (void)setModel:(id)model {
    [self.moreBtn setTitle:model[1] forState:(UIControlStateNormal)];
    [self.moreBtn setTitle:model[1] forState:(UIControlStateSelected)];
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
