//
//  EFOrderDetailGoodsTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOrderDetailGoodsTableViewCell.h"

@interface EFOrderDetailGoodsTableViewCell ()

@property (nonatomic,strong)QMUIButton *moreBtn;

@end

@implementation EFOrderDetailGoodsTableViewCell

-(QMUIButton *)moreBtn
{
    if (_moreBtn == nil) {
        _moreBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_moreBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        _moreBtn.titleLabel.font = RegularFont13;
        [_moreBtn setTitle:@"申请售后" forState:(UIControlStateNormal)];
        @weakify(self);
        [[_moreBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.moreClick) {
                self.moreClick();
            }
        }];
    }
    return _moreBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.moreBtn];
        [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(-0));
            make.right.equalTo(@(-WidthOfScale(14.5)));
            make.size.mas_equalTo(CGSizeMake(WidthOfScale(89), WidthOfScale(35)));
        }];
        [self.moreBtn layoutIfNeeded];
        [self.moreBtn AddImageRadiusBorderWithColor:RGB16(0xD6D6D6) lineWidth:1 radius:WidthOfScale(35)/2];
        
        [self.goods mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(WidthOfScale(80), WidthOfScale(80)));
        }];
        [self.goods layoutIfNeeded];
        self.goods.layer.cornerRadius = 5;
        self.goods.layer.masksToBounds = YES;
        [self.goodsPriceLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodsSizeLab.mas_bottom).equalTo(@(WidthOfScale(15)));
        }];
        [self.contentView layoutIfNeeded];
    }
    return self;
}

- (void)setModel:(id)model {
    self.goodsNameLab.text = @"商品名称复古宫廷风台灯具灯罩，可以换行，最多两行";
    self.goodsSizeLab.text = @"属性:蓝色（不包含灯泡） 中码";
    self.goodsPriceLab.text = @"￥799/件";
    self.goodsNumLab.text = @"X 300";
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
