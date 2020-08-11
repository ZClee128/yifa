//
//  EFOrderDetailGoodsTableViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOrderDetailGoodsTableViewCell.h"
#import "EFOrderModel.h"
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
        self.moreBtn.layer.borderColor = RGB16(0xD6D6D6).CGColor;
        self.moreBtn.layer.borderWidth = 1;
        self.moreBtn.layer.cornerRadius = WidthOfScale(35)/2;
        self.moreBtn.layer.masksToBounds = YES;
        
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

- (void)setModel:(EFOrderGoodsModel *)model {
    self.goodsNameLab.text = model.goodsTitle;
    self.goodsSizeLab.text = model.goodsProperty;
    self.goodsPriceLab.text = [NSString stringWithFormat:@"￥%.1f/件",model.goodsPrice];
    self.goodsStatusLab.text = model.isAftersale ? @"已退款" : @"";
    self.goodsNumLab.text = [NSString stringWithFormat:@"X %ld",model.quantity];
    [self.goods sd_setImageWithURL:[NSURL URLWithString:model.goodsImage] placeholderImage:UIImageMake(@"gg")];
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
