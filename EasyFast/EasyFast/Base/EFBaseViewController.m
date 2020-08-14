//
//  EFBaseViewController.m
//  flag
//
//  Created by zclee on 2020/5/16.
//  Copyright © 2020 zclee. All rights reserved.
//

#import "EFBaseViewController.h"

@interface EFBaseViewController ()


@end

@implementation EFBaseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = colorfafafa;
//    self.navigationController.navigationBarHidden = YES;
    self.gk_backImage = [UIImage imageNamed:@"btn_back_black"];
    if (NSFoundationVersionNumber>=NSFoundationVersionNumber_iOS_8_0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
//    QMUIButton *leftItem = [QMUIButton buttonWithType:UIButtonTypeSystem];
//    [leftItem setImage:[UIImage imageNamed:@"btn_back_black"] forState:UIControlStateNormal];
//    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
//    [rightView addSubview:leftItem];
//    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
//    self.gk_navigationItem.leftBarButtonItem = leftBarItem;
    
    self.gk_navTitleFont = MedFont17;
    self.gk_navTitleColor = tabbarBlackColor;
    self.gk_navItemLeftSpace = WidthOfScale(0);
    self.gk_navLineHidden = YES;
    self.gk_navShadowColor = RGB16(0xf2f2f2);
}

- (BOOL)prefersStatusBarHidden {
    return self.gk_statusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.gk_statusBarStyle;
}
@end
