//
//  EFNewGoodsViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/9/2.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFNewGoodsViewController.h"

@interface EFNewGoodsViewController ()

@end

@implementation EFNewGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navigationBar.hidden = YES;
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-45-WidthOfScale(44)-TAB_BAR_HEIGHT);
    @weakify(self);
    self.EFTableView.scrollEnabled = NO;
    [self loadNewData];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kscrollYes object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        self.EFTableView.scrollEnabled = YES;
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kscrollNO object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        self.EFTableView.scrollEnabled = NO;
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kloadNewGoodsNoti object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self loadNewData];
    }];
    self.EFTableView.showsVerticalScrollIndicator = NO;
}

- (UIView *)listView {
    return self.view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= 0) {
        self.EFTableView.scrollEnabled = NO;
    }
}
@end
