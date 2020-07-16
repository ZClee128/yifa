//
//  FollowViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/9.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFollowViewController.h"
#import "EFFollowSubViewController.h"

@interface EFFollowViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@property (nonatomic,strong)JXCategoryTitleView *jxTitleView;
@property (nonatomic,strong)JXCategoryListContainerView *listContainerView;
@end

@implementation EFFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"关注列表";
    self.gk_navLineHidden = YES;
    self.jxTitleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, 45)];
    self.jxTitleView.delegate = self;
    [self.view addSubview:self.jxTitleView];
    self.jxTitleView.titles = @[@"热门", @"男装", @"鞋包",@"手机",@"电器",@"家纺",@"家纺",@"家纺",@"家纺",@"家纺"];
    self.jxTitleView.titleColorGradientEnabled = NO;
    self.jxTitleView.titleColor = tabbarBlackColor;
    self.jxTitleView.titleSelectedColor = colorF14745;
    self.jxTitleView.titleFont = RegularFont16;
    self.jxTitleView.titleSelectedFont = RegularFont17;
    self.jxTitleView.backgroundColor = UIColor.whiteColor;
    
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listContainerView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT+45, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-45-TAB_BAR_HEIGHT);
    [self.view addSubview:self.listContainerView];
    //关联到categoryView
    self.jxTitleView.listContainer = self.listContainerView;
    
    // 下划线
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    // 下划线颜
    lineView.indicatorColor = colorF14745;
    // 下划线宽度
    lineView.indicatorWidth = WidthOfScale(20);
    self.jxTitleView.indicators = @[lineView];

}


//返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 3;
}
//根据下标index返回对应遵从`JXCategoryListContentViewDelegate`协议的列表实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    EFFollowSubViewController *follow =  [[EFFollowSubViewController alloc] initWithType:@""];
    return follow;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
