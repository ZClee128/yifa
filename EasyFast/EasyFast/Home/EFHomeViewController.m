//
//  EFHomeViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/9.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFHomeViewController.h"
#import "EFHotViewController.h"

@interface EFHomeViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@property (nonatomic,strong)QMUIButton *searchBtn;
@property (nonatomic,strong)JXCategoryTitleView *jxTitleView;
@property (nonatomic,strong)JXCategoryListContainerView *listContainerView;
@end

@implementation EFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSearchBtn];
    self.jxTitleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, 30)];
    self.jxTitleView.delegate = self;
    [self.view addSubview:self.jxTitleView];
    self.jxTitleView.titles = @[@"热门", @"男装", @"鞋包",@"手机",@"电器",@"家纺",@"家纺",@"家纺",@"家纺",@"家纺"];
    self.jxTitleView.titleColorGradientEnabled = NO;
    self.jxTitleView.titleColor = tabbarBlackColor;
    self.jxTitleView.titleSelectedColor = colorF14745;
    self.jxTitleView.titleFont = RegularFont15;
    self.jxTitleView.titleSelectedFont = MedFont17;
    
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listContainerView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT+30, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-30-TAB_BAR_HEIGHT);
    [self.view addSubview:self.listContainerView];
    //关联到categoryView
    self.jxTitleView.listContainer = self.listContainerView;
}

- (void)addSearchBtn {
    self.searchBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [self.searchBtn setImage:UIImageMake(@"search") forState:(UIControlStateNormal)];
    [self.searchBtn setTitle:@"滑板车" forState:(UIControlStateNormal)];
    [self.searchBtn setTitleColor:colorAEAEAE forState:(UIControlStateNormal)];
    self.searchBtn.titleLabel.font = RegularFont14;
    self.searchBtn.frame = CGRectMake(0, 0, WidthOfScale(345), 36);
    [self.searchBtn ViewRadius:36/2];
    self.searchBtn.backgroundColor = colorEFEFEF;
    self.searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 7);
    self.gk_navTitleView = self.searchBtn;
    self.gk_navLineHidden = YES;
}



//返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 3;
}
//根据下标index返回对应遵从`JXCategoryListContentViewDelegate`协议的列表实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    EFHotViewController *hot =  [[EFHotViewController alloc] init];
    return hot;
}
@end
