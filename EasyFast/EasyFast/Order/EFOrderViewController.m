//
//  EFOrderViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/23.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOrderViewController.h"
#import "EFOrderDetailViewController.h"
#import "EFOrderSearchViewController.h"

@interface EFOrderViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate,QMUITextFieldDelegate>

@property (nonatomic,strong)JXCategoryTitleView *jxTitleView;
@property (nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property (nonatomic,strong)QMUITextField *searchField;
@property (nonatomic,strong)QMUIButton *searchBtn;
@property (nonatomic,assign) NSInteger  selectIndex;

@end

@implementation EFOrderViewController

-(QMUITextField *)searchField
{
    if (_searchField == nil) {
        _searchField = [[QMUITextField alloc] initWithFrame:CGRectMake(WidthOfScale(60), WidthOfScale(7), WidthOfScale(300), WidthOfScale(36))];
        [_searchField ViewRadius: WidthOfScale(36)/2];
        _searchField.tintColor = colorFE851E;
        _searchField.font = RegularFont15;
        [_searchField setPlaceholderColor:colorAEAEAE];
        _searchField.placeholder = @"搜索我的订单";
        _searchField.backgroundColor = colorEFEFEF;
        _searchField.textInsets = UIEdgeInsetsMake(0, WidthOfScale(21), 0, WidthOfScale(21));
        _searchField.returnKeyType = UIReturnKeySearch;//变为搜索按钮
        _searchField.delegate = self;
    }
    return _searchField;
}

-(QMUIButton *)searchBtn
{
    if (_searchBtn == nil) {
        _searchBtn = [[QMUIButton alloc] initWithFrame:CGRectMake(WidthOfScale(60), WidthOfScale(7), WidthOfScale(300), WidthOfScale(36))];
        [_searchBtn ViewRadius: WidthOfScale(36)/2];
        _searchBtn.titleLabel.font = RegularFont15;
        [_searchBtn setTitleColor:colorAEAEAE forState:(UIControlStateNormal)];
        [_searchBtn setTitle:@"搜索我的订单" forState:(UIControlStateNormal)];
        _searchBtn.backgroundColor = colorEFEFEF;
        [_searchBtn setImage:UIImageMake(@"search") forState:(UIControlStateNormal)];
        _searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(6.5), 0, 0);
        @weakify(self);
        [[_searchBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            EFOrderSearchViewController *vc = [[EFOrderSearchViewController alloc] init];
            [self.navigationController qmui_pushViewController:vc animated:NO completion:^{
                
            }];
        }];
    }
    return _searchBtn;
}

- (instancetype)initWithIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        self.selectIndex = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.gk_navigationBar addSubview:self.searchField];
    [self.gk_navigationBar addSubview:self.searchBtn];
    self.searchField.centerY = self.gk_navigationBar.centerY;
    self.jxTitleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, 45)];
    self.jxTitleView.delegate = self;
    [self.view addSubview:self.jxTitleView];
    self.jxTitleView.titles = @[@"全部",@"待付款", @"待发货",@"待收货",@"待评价"];
    self.jxTitleView.titleColorGradientEnabled = NO;
    self.jxTitleView.titleColor = tabbarBlackColor;
    self.jxTitleView.titleSelectedColor = colorF14745;
    self.jxTitleView.titleFont = RegularFont15;
    self.jxTitleView.titleSelectedFont = RegularFont15;
    self.jxTitleView.backgroundColor = UIColor.whiteColor;
    self.jxTitleView.defaultSelectedIndex = self.selectIndex;
    
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listContainerView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT+45, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-45);
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
    return self.jxTitleView.titles.count;
}
//根据下标index返回对应遵从`JXCategoryListContentViewDelegate`协议的列表实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    OrderType type;
    switch (index) {
        case 1:
            type = OrderTypePay;
            break;
        case 2:
            type = OrderTypeSend;
            break;
        case 3:
            type = OrderTypeGet;
            break;
        case 4:
            type = OrderTypeSay;
            break;
        default:
            type = OrderTypeALL;
            break;
    }
    EFOrderDetailViewController *order =  [[EFOrderDetailViewController alloc] initWithType:type severType:index+1];
    return order;
}

//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    if (textField.text.length == 0) {
//        self.searchBtn.hidden = NO;
//    }
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    NSLog(@"点击了搜索");
//    [self.searchField resignFirstResponder];
////    [[NSNotificationCenter defaultCenter] postNotificationName:kOrderSearch object:@{@"text":textField.text,@"type":@(self.jxTitleView.selectedIndex)}];
//    return YES;
//}

@end
