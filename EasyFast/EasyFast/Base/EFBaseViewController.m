//
//  EFBaseViewController.m
//  flag
//
//  Created by zclee on 2020/5/16.
//  Copyright © 2020 zclee. All rights reserved.
//

#import "EFBaseViewController.h"


NSString *const kFlagViewController = @"FlagViewController";
NSString *const kDayViewController = @"DayViewController";
NSString *const kFlishViewController = @"FlishViewController";


@interface EFBaseViewController ()

@property (nonatomic,strong)NSArray *hideCallBackButtonClasses;
@end

@implementation EFBaseViewController

-(ConstomNavView *)navView
{
    if (_navView == nil) {
        _navView = [[ConstomNavView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, NAVIGATION_BAR_HEIGHT)];
    }
    return _navView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBarHidden = YES;
    @weakify(self);
    [self addNav];
    [self.navView.backClick subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self backClick];
    }];
    self.hideCallBackButtonClasses = @[kDayViewController, kFlishViewController];
    [self.hideCallBackButtonClasses containsObject:NSStringFromClass(self.class)] ? [self.navView hiddenBackBtn] : [self.navView showBackBtn];
}

- (void)addNav {
    [self.view addSubview:self.navView];
}

- (void)setNavTitle:(NSString *)title {
    [self.navView setNavTitle:title];
}

- (void)setRightBtns:(NSArray *)imageNames {
    [self.navView setRightBtns:imageNames];
}

- (void)HiddenNav {
    [self.navView removeFromSuperview];
}

- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)getLeftBtn {
    return [self.navView getLeftBtn];
}
@end
