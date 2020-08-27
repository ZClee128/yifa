//
//  AppFirstViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/8/26.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "AppFirstViewController.h"
#import "EFBootPageVM.h"
#import "EFBootPageView.h"
#import "EFPageControl.h"

@interface AppFirstViewController ()

@property (nonatomic,strong)UIScrollView *myScroll;
@property (nonatomic,strong)EFPageControl *myPageControl;
@end

@implementation AppFirstViewController

- (void)viewDidLoad {
    self.viewModel = [[EFBootPageVM alloc] init];
    self.gk_navigationBar.hidden = YES;
    [super viewDidLoad];
    [self setScroll];
}

- (void)setScroll {
    self.myScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT)];
    self.myScroll.contentSize = CGSizeMake(kPHONE_WIDTH*self.viewModel.dataSources.count, kPHONE_HEIGHT);
    self.myScroll.showsVerticalScrollIndicator = NO;
    self.myScroll.showsHorizontalScrollIndicator = NO;
    self.myScroll.bounces = YES;
    self.myScroll.pagingEnabled = YES;
    [self.view addSubview:self.myScroll];
    for (int i = 0; i < self.viewModel.dataSources.count ; i++) {
        EFBootpageModel *model = self.viewModel.dataSources[i];
        EFBootPageView *imageBgView = [[EFBootPageView alloc] initWithFrame:CGRectMake(i*kPHONE_WIDTH, 0, kPHONE_WIDTH, kPHONE_HEIGHT) WithModel:model];
        [self.myScroll addSubview:imageBgView];
        if (i == self.viewModel.dataSources.count - 1) {
            imageBgView.userInteractionEnabled = YES;
            UIButton *skip = [UIButton buttonWithType:(UIButtonTypeCustom)];
            skip.backgroundColor = [UIColor whiteColor];
            [skip setTitle:@"立即体验" forState:(UIControlStateNormal)];
            [skip setTitleColor:RGB16(0xFF8C4C) forState:(UIControlStateNormal)];
            skip.titleLabel.font = MedFont15;
            [imageBgView addSubview:skip];
            [skip mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(@(-WidthOfScale(78)));
                make.centerX.equalTo(imageBgView);
                make.size.mas_equalTo(CGSizeMake(WidthOfScale(130), WidthOfScale(38)));
            }];
            [skip layoutIfNeeded];
            [skip ViewRadius:WidthOfScale(38)/2];
            [[skip rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
                kSetUserDefaults(@YES, kfirstApp);
                kAppDelegate.window.rootViewController = [kAppDelegate nextRootViewController:YES];
            }];
        }
    }
    self.myPageControl = [[EFPageControl alloc] initWithFrame:CGRectMake(0, kPHONE_HEIGHT- (kPHONE_HEIGHT*30/667) - 10, kPHONE_WIDTH, 10)];
    [self.view addSubview:self.myPageControl];
    self.myPageControl.numberOfPages = self.viewModel.dataSources.count;
    self.myPageControl.currentPage = 0;
    [self.myPageControl setValue:[UIImage imageWithColor:RGB16(0xE8383E) size:CGSizeMake(10, 10)] forKeyPath:@"_currentPageImage"];
    [self.myPageControl setValue:[UIImage imageWithColor:RGB16(0xFFFFFF) size:CGSizeMake(10, 10)] forKeyPath:@"_pageImage"];
    [RACObserve(self.myScroll, contentOffset) subscribeNext:^(NSValue *value) {
        CGPoint point = value.CGPointValue;
        NSInteger index = point.x / kPHONE_WIDTH;
        self.myPageControl.currentPage = index;
    }];
}


@end
