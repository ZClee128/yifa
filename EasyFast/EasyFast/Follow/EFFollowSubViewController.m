//
//  EFFollowSubViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFollowSubViewController.h"

@interface EFFollowSubViewController ()

@end

@implementation EFFollowSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navigationBar.hidden = YES;
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-30-TAB_BAR_HEIGHT);
    self.gk_navLineHidden = YES;
}

- (UIView *)listView {
    return self.view;
}

@end
