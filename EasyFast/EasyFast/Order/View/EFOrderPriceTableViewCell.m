//
//  EFOrderPriceTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/23.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOrderPriceTableViewCell.h"
#import "EFOrderModel.h"

@interface EFOrderPriceTableViewCell ()

@property (nonatomic,strong)QMUILabel *numLab;
@property (nonatomic,strong)QMUILabel *priceLab;
@property (nonatomic,strong)QMUILabel *yunfeiLab;
@property (nonatomic,strong)QMUILabel *payStatusLab;

@end

@implementation EFOrderPriceTableViewCell

-(QMUILabel *)numLab
{
    if (_numLab == nil) {
        _numLab = [[QMUILabel alloc] init];
        _numLab.font = RegularFont14;
        _numLab.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
    }
    return _numLab;
}

-(QMUILabel *)priceLab
{
    if (_priceLab == nil) {
        _priceLab = [[QMUILabel alloc] init];
        _priceLab.font = MedFont16;
        _priceLab.textColor = tabbarBlackColor;
    }
    return _priceLab;
}

-(QMUILabel *)yunfeiLab
{
    if (_yunfeiLab == nil) {
        _yunfeiLab = [[QMUILabel alloc] init];
        _yunfeiLab.font = RegularFont14;
        _yunfeiLab.textColor = tabbarBlackColor;
    }
    return _yunfeiLab;
}

-(QMUILabel *)payStatusLab
{
    if (_payStatusLab == nil) {
        _payStatusLab = [[QMUILabel alloc] init];
        _payStatusLab.font = RegularFont13;
        _payStatusLab.textColor = colorF14745;
    }
    return _payStatusLab;
}

- (void)setUI {
    [self.contentView addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15)));
        make.centerY.equalTo(self.contentView);
    }];
    
    QMUILabel *all = [[QMUILabel alloc] init];
    all.font = RegularFont14;
    all.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
    all.text = @"合计";
    [self.contentView addSubview:all];
    [all mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numLab.mas_right).equalTo(@(WidthOfScale(25)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(all.mas_right).equalTo(@(WidthOfScale(4.5)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.yunfeiLab];
    [self.yunfeiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLab.mas_right).equalTo(@(WidthOfScale(0)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.payStatusLab];
    [self.payStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(16)));
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setModel:(EFOrderModel *)model {
    self.numLab.text = [NSString stringWithFormat:@"共%ld件",model.quantity];
    self.priceLab.text = [NSString stringWithFormat:@"¥%.2f",model.totalAmount];
    self.yunfeiLab.text = model.postageAmount ? [NSString stringWithFormat:@"（含运费 ¥%.2f）",model.postageAmount] : @"";
    self.payStatusLab.text = @"已付款";
    NSString *status = @"";
    switch (model.payState) {
        case 0:
            status = @"待付款";
            break;
        case 1:
            status = @"已付款";
            break;
        default:
            break;
    }
    self.payStatusLab.text = model.orderState == 800 ? @"" : status;
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
