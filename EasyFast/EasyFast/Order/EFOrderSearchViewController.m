//
//  EFOrderSearchViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/8/12.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOrderSearchViewController.h"
#import "EFOrderVM.h"
@interface EFOrderSearchViewController ()<QMUITextFieldDelegate>
@property (nonatomic,strong)QMUITextField *searchField;
@property (nonatomic,strong)QMUIButton *cancle;
@end

@implementation EFOrderSearchViewController


-(QMUITextField *)searchField
{
    if (_searchField == nil) {
        _searchField = [[QMUITextField alloc] initWithFrame:CGRectMake(WidthOfScale(15), STATUS_BAR_HEIGHT, WidthOfScale(300), WidthOfScale(36))];
        [_searchField ViewRadius: WidthOfScale(36)/2];
        _searchField.tintColor = colorFE851E;
        _searchField.font = RegularFont15;
        [_searchField setPlaceholderColor:colorAEAEAE];
        _searchField.placeholder = @"搜索我的订单";
        _searchField.backgroundColor = colorEFEFEF;
        _searchField.textInsets = UIEdgeInsetsMake(0, WidthOfScale(21), 0, WidthOfScale(21));
        [_searchField becomeFirstResponder];
        _searchField.returnKeyType =  UIReturnKeySearch;
        _searchField.delegate = self;
    }
    return _searchField;
}

-(QMUIButton *)cancle
{
    if (_cancle == nil) {
        _cancle = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_cancle setTitle:@"取消" forState:(UIControlStateNormal)];
        [_cancle setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        _cancle.titleLabel.font = RegularFont15;
        @weakify(self);
        [[_cancle rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:NO];
        }];
    }
    return _cancle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.EFTableView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-TAB_SAFE_HEIGHT);
    self.gk_navigationBar.hidden = YES;
    ((EFOrderVM *)self.viewModel).type = 1;
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.searchField];
    [self.view addSubview:self.cancle];
    [self.cancle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.left.equalTo(self.searchField.mas_right).equalTo(@(0));
        make.centerY.equalTo(self.searchField);
        make.height.equalTo(@(WidthOfScale(36)));
    }];
}

- (void)loadList {
    @weakify(self);
    if (self.searchField.text.length != 0) {
        @strongify(self);
        [[((EFOrderVM *)self.viewModel) searchRefreshForDown] subscribeNext:^(RACTuple *x) {
            [self.EFTableView.mj_header endRefreshing];
            self.EFData = x.first;
            [self.EFTableView reloadData];
        }];
    }
}

- (void)loadNewData {
    [self loadList];
}

- (void)loadMoreData {
    @weakify(self);
    if (self.searchField.text.length != 0) {
        [[((EFOrderVM *)self.viewModel) searchRefreshForUp] subscribeNext:^(RACTuple *x) {
            @strongify(self);
            [self.EFTableView.mj_footer endRefreshing];
            self.EFData = x.first;
            [self.EFTableView reloadData];
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
   
    ((EFOrderVM *)self.viewModel).searchText = textField.text;
    [self loadList];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    ((EFOrderVM *)self.viewModel).searchText = textField.text;
    [self loadList];
    return YES;
}

@end
