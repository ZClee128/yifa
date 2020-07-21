//
//  NotiTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "NotiTableViewCell.h"

@interface NotiTableViewCell ()

@property (nonatomic,strong)QMUILabel *titleLab;
@property (nonatomic,strong)UISwitch *switchView;

@end

@implementation NotiTableViewCell

-(QMUILabel *)titleLab
{
    if (_titleLab == nil) {
        _titleLab = [[QMUILabel alloc] init];
        _titleLab.font = MedFont15;
        _titleLab.textColor = tabbarBlackColor;
    }
    return _titleLab;
}

-(UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc]initWithFrame:CGRectMake(4.0f, 16.0f, 100.0f, 28.0f)];
        [_switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
        _switchView.on = YES;
    }
    return _switchView;
}

 -(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
    }else {
        NSLog(@"关");
    }
}

- (void)setUI {
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15.5)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.switchView];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15)));
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setModel:(id)model {
    if ([model isKindOfClass:[NSArray class]]) {
        self.titleLab.text = model[0];
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
