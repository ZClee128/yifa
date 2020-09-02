//
//  EFHomeViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/9.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFHomeViewController.h"
#import "EFHotViewController.h"
#import "EFSearchViewController.h"
#import "EFHomeOtherViewController.h"
#import "EFClassifyModel.h"
#import "EFClassifyVM.h"

@interface EFHomeViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@property (nonatomic,strong)QMUIButton *searchBtn;
@property (nonatomic,strong)JXCategoryTitleView *jxTitleView;
@property (nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property (nonatomic,strong)NSMutableArray *titles;
@end

@implementation EFHomeViewController

- (NSMutableArray *)titles {
    if (_titles == nil) {
        _titles = [[NSMutableArray alloc] init];
    }
    return _titles;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.jxTitleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, 45)];
    self.jxTitleView.delegate = self;
    [self.view addSubview:self.jxTitleView];
    [self loadTopTitle];
    self.jxTitleView.titleColorGradientEnabled = NO;
    self.jxTitleView.titleColor = RGB16(0xFFB9BB);
    self.jxTitleView.titleSelectedColor = UIColor.whiteColor;
    self.jxTitleView.titleFont = RegularFont15;
    self.jxTitleView.titleSelectedFont = MedFont17;
    
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listContainerView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT+45, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-45-TAB_BAR_HEIGHT);
    [self.view addSubview:self.listContainerView];
    //关联到categoryView
    self.jxTitleView.listContainer = self.listContainerView;
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kLoginNoti object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self loadTopTitle];
    }];
}

- (void)loadTopTitle {
    [[EFClassifyVM categoryByPno:@"0"] subscribeNext:^(NSArray *x) {
        NSMutableArray *Temtitles = [[NSMutableArray alloc] init];
        if (x.count > 0) {
            self.titles = [x mutableCopy];
            [Temtitles addObject:@"热门"];
            for (EFClassifyModel *model in x) {
                [Temtitles addObject:model.title];
            }
            [NSArray bg_clearArrayWithName:kHomeCategory];
            [self.titles bg_saveArrayWithName:kHomeCategory];
        }else {
            NSArray* testResult = [NSArray bg_arrayWithName:kHomeCategory];
            self.titles = [testResult mutableCopy];
            [Temtitles addObject:@"热门"];
            for (EFClassifyModel *model in self.titles) {
                [Temtitles addObject:model.title];
            }
        }
        [self addSearchBtn];
        self.jxTitleView.titles = Temtitles;
        [self.jxTitleView reloadData];
    }];
}

- (void)addSearchBtn {
    UIImageView *bg = [[UIImageView alloc] initWithImage:UIImageMake(@"home_bg")];
    [self.view insertSubview:bg belowSubview:self.jxTitleView];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(kPHONE_WIDTH));
        make.height.equalTo(@(WidthOfScale(219)));
    }];
    
    self.searchBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [self.searchBtn setImage:UIImageMake(@"search") forState:(UIControlStateNormal)];
    [self.searchBtn setTitle:@"搜索" forState:(UIControlStateNormal)];
    [self.searchBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    self.searchBtn.titleLabel.font = RegularFont14;
    self.searchBtn.frame = CGRectMake(0, 0, WidthOfScale(345), 36);
    [self.searchBtn ViewRadius:36/2];
    self.searchBtn.backgroundColor = [colorEFEFEF colorWithAlphaComponent:0.5];
    self.searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 7);
    self.gk_navTitleView = self.searchBtn;
    self.gk_navLineHidden = YES;
    self.gk_navBackgroundColor = [UIColor clearColor];
    @weakify(self);
    [[self.searchBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        EFSearchViewController *searchVC = [[EFSearchViewController alloc] init];
        searchVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:searchVC animated:YES];
    }];
}



//返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.jxTitleView.titles.count;
}
//根据下标index返回对应遵从`JXCategoryListContentViewDelegate`协议的列表实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            EFHotViewController *hot =  [[EFHotViewController alloc] init];
            return hot;
        }
        default:
        {
            EFClassifyModel *model = self.titles[index - 1];
            EFHomeOtherViewController *other = [[EFHomeOtherViewController alloc] initWithType:model.code];
            return other;
        }
    }
    
}
@end
