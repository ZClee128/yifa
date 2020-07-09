//
//  EFBaseViewController.h
//  flag
//
//  Created by zclee on 2020/5/16.
//  Copyright © 2020 zclee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstomNavView.h"
#import "EFBaseRefreshVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFBaseViewController : UIViewController

@property (nonatomic,strong) ConstomNavView *navView;
//MVVM中的VM，默认为nil，声明为nullable是为了在dealloc中做一些方法交换的事情，父类中对此属性做了建言，不允许为nil，所以子类必须在[super viewDidLoad]执行前初始化这个对象
@property (nonatomic, strong, nullable) EFBaseRefreshVM *viewModel;



/// 设置导航栏text
- (void)setNavTitle:(NSString *)title;


/// 设置右按钮
/// @param imageNames  传入图片名字，顺序从右往左
- (void)setRightBtns:(NSArray *)imageNames;


- (void)backClick;

- (void)HiddenNav;

- (UIButton *)getLeftBtn;
@end

NS_ASSUME_NONNULL_END
