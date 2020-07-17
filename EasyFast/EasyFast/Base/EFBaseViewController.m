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
    self.navigationController.navigationBarHidden = YES;
    self.gk_backImage = [UIImage imageNamed:@"btn_back_black"];

}

- (BOOL)prefersStatusBarHidden {
    return self.gk_statusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.gk_statusBarStyle;
}
@end
