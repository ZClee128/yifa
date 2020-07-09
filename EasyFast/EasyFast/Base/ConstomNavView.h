//
//  ConstomNavView.h
//  flag
//
//  Created by zclee on 2020/5/16.
//  Copyright © 2020 zclee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^rightBlock)(UIButton *btn);

@interface ConstomNavView : UIView

@property (nonatomic, copy) rightBlock block;

- (instancetype)initWithFrame:(CGRect)frame;

- (RACSignal *)backClick;

- (void)setNavTitle:(NSString *)text;

- (void)setRightBtns:(NSArray *)rightBtns;

- (void)hiddenBackBtn;

- (void)showBackBtn;

- (UIButton *)getLeftBtn;
@end

NS_ASSUME_NONNULL_END
