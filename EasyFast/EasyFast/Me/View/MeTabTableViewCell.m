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
        _moreBtn.tag = 999;
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
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[QMUIButton class]]) {
            if (view.tag != 999) {
                [view removeFromSuperview];
            }
        }
    }
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
        btn.tag = i+300;
        [self.contentView addSubview:btn];
        [[btn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
            @strongify(self);
            if (self.seletBtn) {
                self.seletBtn(x.tag-300);
            }
        }];
        JSBadgeView *badgeView = [[JSBadgeView alloc]initWithParentView:btn alignment:JSBadgeViewAlignmentTopRight];
        badgeView.size = CGSizeMake(WidthOfScale(19), WidthOfScale(19));
        //2、如果显示的位置不对，可以自己调整，超爽啊！
        badgeView.badgePositionAdjustment = [title isEqualToString:@"我的团购"] ? CGPointMake(-WidthOfScale(30), 8) : CGPointMake(-WidthOfScale(25), 10);
        //3、如果多个的badge,可以设置tag要辨别
        badgeView.tag = i + 400;

        //1、背景色
        badgeView.badgeBackgroundColor = colorF14745;
        //2、没有反光面
        badgeView.badgeOverlayColor = [UIColor clearColor];
        //3、外圈的颜色，默认是白色
        badgeView.badgeStrokeColor = [UIColor whiteColor];
        badgeView.badgeTextFont = RegularFont12;
        badgeView.badgeShadowSize = CGSizeMake(0, 0);
        badgeView.badgeTextShadowOffset = CGSizeMake(0, 0);
        badgeView.badgeStrokeWidth = 1;
        /*****设置数字****/
        //1、用字符串来ym
        badgeView.badgeText = [btns[i][@"num"] intValue] ? btns[i][@"num"] : nil;
        [badgeView setNeedsLayout];
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
