//
//  EFAddressTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFAddressTableViewCell.h"

@interface EFAddressTableViewCell ()

@property (nonatomic,strong)QMUILabel *nameLab;
@property (nonatomic,strong)QMUILabel *phoneLab;
@property (nonatomic,strong)YYLabel *addressLab;

@property (nonatomic,strong)QMUIButton *selectBtn;
@property (nonatomic,strong)QMUIButton *topBtn;
@property (nonatomic,strong)QMUIButton *deletBtn;
@property (nonatomic,strong)QMUIButton *editBtn;
@property (nonatomic,strong)QMUIButton *chooseBtn;

@property (nonatomic,strong)NSMutableAttributedString *text;
@end

@implementation EFAddressTableViewCell

-(QMUILabel *)nameLab
{
    if (_nameLab == nil) {
        _nameLab = [[QMUILabel alloc] init];
        _nameLab.font = MedFont16;
        _nameLab.textColor = tabbarBlackColor;
        _nameLab.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLab;
}

-(QMUILabel *)phoneLab
{
    if (_phoneLab == nil) {
        _phoneLab = [[QMUILabel alloc] init];
        _phoneLab.font = MedFont16;
        _phoneLab.textColor = tabbarBlackColor;
        _phoneLab.textAlignment = NSTextAlignmentLeft;
    }
    return _phoneLab;
}

-(YYLabel *)addressLab
{
    if (_addressLab == nil) {
        _addressLab = [[YYLabel alloc] init];
        _addressLab.textAlignment = NSTextAlignmentLeft;
        _addressLab.numberOfLines = 0;
        _addressLab.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _addressLab;
}

-(QMUIButton *)selectBtn
{
    if (_selectBtn == nil) {
        _selectBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_selectBtn setImage:UIImageMake(@"xuanze") forState:(UIControlStateNormal)];
    }
    return _selectBtn;
}

-(QMUIButton *)topBtn
{
    if (_topBtn == nil) {
        _topBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_topBtn setTitle:@"置顶" forState:(UIControlStateNormal)];
        _topBtn.titleLabel.font = RegularFont13;
        [_topBtn setTitleColor:[tabbarBlackColor colorWithAlphaComponent:0.7] forState:(UIControlStateNormal)];
    }
    return _topBtn;
}

-(QMUIButton *)deletBtn
{
    if (_deletBtn == nil) {
        _deletBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_deletBtn setTitle:@"删除" forState:(UIControlStateNormal)];
        _deletBtn.titleLabel.font = RegularFont13;
        [_deletBtn setTitleColor:[tabbarBlackColor colorWithAlphaComponent:0.7] forState:(UIControlStateNormal)];
    }
    return _deletBtn;
}

-(QMUIButton *)editBtn
{
    if (_editBtn == nil) {
        _editBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_editBtn setTitle:@"修改" forState:(UIControlStateNormal)];
        _editBtn.titleLabel.font = RegularFont13;
        [_editBtn setTitleColor:[tabbarBlackColor colorWithAlphaComponent:0.7] forState:(UIControlStateNormal)];
    }
    return _editBtn;
}

-(QMUIButton *)chooseBtn
{
    if (_chooseBtn == nil) {
        _chooseBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_chooseBtn setTitle:@"设为默认" forState:(UIControlStateNormal)];
        [_chooseBtn setTitle:@"已设为默认" forState:(UIControlStateSelected)];
        _chooseBtn.titleLabel.font = RegularFont13;
        [_chooseBtn setTitleColor:[tabbarBlackColor colorWithAlphaComponent:0.7] forState:(UIControlStateNormal)];
        [_chooseBtn setTitleColor:[tabbarBlackColor colorWithAlphaComponent:0.7] forState:(UIControlStateSelected)];
        [_chooseBtn setImage:UIImageMake(@"gou_def") forState:(UIControlStateNormal)];
        [_chooseBtn setImage:UIImageMake(@"gou_select") forState:(UIControlStateSelected)];
        _chooseBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WidthOfScale(10.5));
    }
    return _chooseBtn;
}

- (void)setUI {
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(19.5)));
        make.left.equalTo(@(WidthOfScale(15.5)));
        make.height.equalTo(@(WidthOfScale(15.5)));
    }];
    
    [self.contentView addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab.mas_right).equalTo(@(WidthOfScale(26)));
        make.centerY.equalTo(self.nameLab);
        make.height.equalTo(@(WidthOfScale(12.5)));
    }];
    
    [self.contentView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15.5)));
        make.top.equalTo(self.nameLab.mas_bottom).equalTo(@(WidthOfScale(13)));
        make.right.equalTo(@(-WidthOfScale(86)));
        make.height.equalTo(@(WidthOfScale(12.5)));
    }];
    
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(16)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15.5)));
        make.bottom.equalTo(@(-WidthOfScale(12.5)));
    }];
    
    [self.contentView addSubview:self.deletBtn];
    [self.deletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.editBtn.mas_left).equalTo(@(-WidthOfScale(35.5)));
        make.bottom.equalTo(@(-WidthOfScale(12.5)));
    }];
    
    [self.contentView addSubview:self.topBtn];
    [self.topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.deletBtn.mas_left).equalTo(@(-WidthOfScale(35)));
        make.bottom.equalTo(@(-WidthOfScale(12.5)));
    }];
    
    [self.contentView addSubview:self.chooseBtn];
    [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15.5)));
        make.bottom.equalTo(@(-WidthOfScale(11.5)));
    }];
}

- (void)setModel:(id)model {
    self.nameLab.text = @"李啦啦";
    self.phoneLab.text = @"18737528967";
    self.text  = [[NSMutableAttributedString alloc] initWithString: @"广东省 深圳市 南山区 桃源街道 桃花小苑B708广东省 深圳市 南山区 桃源街道 桃花小苑B708广东省 深圳市 南山区 桃源街道 桃花小苑B708"];
    self.text.font = MedFont13;
    self.text.color = tabbarBlackColor;
    self.text.lineSpacing = 10; // 行间距
    self.addressLab.attributedText = self.text;
}

- (CGFloat)getCellHeight{
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(kPHONE_WIDTH-WidthOfScale(101.5), CGFLOAT_MAX) text:self.text];
    [self.addressLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(layout.textBoundingSize.height));
    }];
    return WidthOfScale(99.5)+layout.textBoundingSize.height;
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
