//
//  AppFirstViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/8/26.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "AppFirstViewController.h"
#import "EFBootPageVM.h"

@interface AppFirstViewController ()

@property (nonatomic,strong)UIScrollView *myScroll;

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
//        XQCBootpageView *imageBgView = [[XQCBootpageView alloc] initWithFrame:CGRectMake(i*kPHONE_WIDTH, 0, kPHONE_WIDTH, kPHONE_HEIGHT- (kPHONE_HEIGHT*43/667) - 8) Model:model];
        UIImageView *imageBgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*kPHONE_WIDTH, 0, kPHONE_WIDTH, kPHONE_HEIGHT)];
        [self.myScroll addSubview:imageBgView];
        imageBgView.contentMode = UIViewContentModeScaleAspectFit;
        imageBgView.image = [UIImage imageNamed:model.bgImage];
        if (i == self.viewModel.dataSources.count - 1) {
            imageBgView.userInteractionEnabled = YES;
            UIButton *skip = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [imageBgView addSubview:skip];
            [skip mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(@(-WidthOfScale(78)));
                make.centerX.equalTo(imageBgView);
                make.size.mas_equalTo(CGSizeMake(WidthOfScale(130), WidthOfScale(38)));
            }];
            [[skip rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
                kSetUserDefaults(@YES, kfirstApp);
                kAppDelegate.window.rootViewController = [kAppDelegate nextRootViewController:YES];
            }];
        }
    }
    
}


@end
