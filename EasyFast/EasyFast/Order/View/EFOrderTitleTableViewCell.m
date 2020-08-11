//
//  EFOrderTitleTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/23.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOrderTitleTableViewCell.h"
#import "EFOrderModel.h"

@interface EFOrderTitleTableViewCell ()

@property (nonatomic,strong)QMUILabel *shopNameLab;
@property (nonatomic,strong)QMUILabel *orderNoLab;
@property (nonatomic,strong)QMUILabel *payStatusLab;

@end

@implementation EFOrderTitleTableViewCell


-(QMUILabel *)shopNameLab
{
    if (_shopNameLab == nil) {
        _shopNameLab = [[QMUILabel alloc] init];
        _shopNameLab.font = MedFont14;
        _shopNameLab.textColor = tabbarBlackColor;
    }
    return _shopNameLab;
}

-(QMUILabel *)orderNoLab
{
    if (_orderNoLab == nil) {
        _orderNoLab = [[QMUILabel alloc] init];
        _orderNoLab.font = RegularFont12;
        _orderNoLab.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
    }
    return _orderNoLab;
}

-(QMUILabel *)payStatusLab
{
    if (_payStatusLab == nil) {
        _payStatusLab = [[QMUILabel alloc] init];
        _payStatusLab.font = RegularFont14;
        _payStatusLab.textColor = colorF14745;
    }
    return _payStatusLab;
}

- (void)setUI {
    [self.contentView addSubview:self.shopNameLab];
    [self.shopNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(20)));
        make.left.equalTo(@(WidthOfScale(14.5)));
        make.height.equalTo(@(WidthOfScale(13)));
    }];
    
    [self.contentView addSubview:self.orderNoLab];
    [self.orderNoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(40)));
        make.left.equalTo(@(WidthOfScale(14.5)));
        make.height.equalTo(@(WidthOfScale(11.5)));
    }];
    
    [self.contentView addSubview:self.payStatusLab];
    [self.payStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(13)));
        make.top.equalTo(@(WidthOfScale(28.5)));
    }];
}

- (void)setModel:(EFOrderModel *)model
{
    self.shopNameLab.text = model.shopTitle;
    self.orderNoLab.text = [NSString stringWithFormat:@"订单号：%@",model.orderNum];
    NSString *status = @"";
    switch (model.orderState) {
        case 100:
            status = @"";
            break;
        case 200:
            status = @"待发货";
            break;
        case 300:
            status = @"已发货";
            break;
        case 400:
            status = @"已收货";
            break;
            case 600:
            status = @"已完成";
            break;
            case 800:
            status = @"已失效";
            break;
        default:
            break;
    }
    self.payStatusLab.text = status;
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
