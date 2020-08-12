//
//  CQBadgeButton.m
//  BadgeButton
//
//  Created by caiqiang on 2019/3/11.
//  Copyright © 2019 Caiqiang. All rights reserved.
//

#import "CQBadgeButton.h"

@interface CQBadgeButton ()

/** 显示按钮角标的label */
@property (nonatomic, strong) UILabel *badgeLabel;

@end

@implementation CQBadgeButton

#pragma mark - 构造方法

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self customInitialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self customInitialize];
    }
    return self;
}

- (void)customInitialize {
    // button属性设置
    self.clipsToBounds = NO;
    [self.titleLabel setFont:RegularFont14];
    [self setTitleColor:tabbarBlackColor forState:UIControlStateNormal];
    
    //------- 角标label -------//
    self.badgeLabel = [[UILabel alloc] init];
    [self.imageView addSubview:self.badgeLabel];
    self.badgeLabel.backgroundColor = colorF14745;
    self.badgeLabel.font = RegularFont12;
    self.badgeLabel.textColor = [UIColor whiteColor];
    self.badgeLabel.layer.cornerRadius = 6;
    self.badgeLabel.clipsToBounds = YES;
    // 默认隐藏
    self.badgeLabel.hidden = YES;
}

#pragma mark - 布局变化时调整UI

- (void)layoutSubviews {
    [super layoutSubviews];
    [self refresh];
}

- (void)refresh {
    [self layoutIfNeeded];
    // 调整角标label的大小和位置
    [self.badgeLabel sizeToFit];
    self.badgeLabel.frame = CGRectMake(CGRectGetWidth(self.imageView.frame)-10, -5, CGRectGetWidth(self.badgeLabel.frame), 12);
}

#pragma mark - 显示角标

/**
 显示角标
 
 @param badgeNumber 角标数量
 */
- (void)showBadgeWithNumber:(NSInteger)badgeNumber {
    self.badgeLabel.hidden = NO;
    // 注意数字前后各留一个空格，不然太紧凑
    self.badgeLabel.text = [NSString stringWithFormat:@" %ld ",badgeNumber];
    // 赋值后调整UI
    [self refresh];
}

#pragma mark - 隐藏角标

/** 隐藏角标 */
- (void)hideBadge {
    self.badgeLabel.hidden = YES;
}

@end
