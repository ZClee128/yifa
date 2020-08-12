//
//  EFIMListViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFIMListViewController.h"
#import "EFIMListTableViewCell.h"
#import "EFConversationViewController.h"
#import "EFIMVM.h"

@interface EFIMListViewController ()<QMUITextFieldDelegate>

@property (nonatomic,strong)QMUITextField *searchField;
@property (nonatomic,strong)QMUIButton *searchBtn;

@end

@implementation EFIMListViewController

-(QMUITextField *)searchField
{
    if (_searchField == nil) {
        _searchField = [[QMUITextField alloc] initWithFrame:CGRectMake(WidthOfScale(15), WidthOfScale(5.5), WidthOfScale(345), WidthOfScale(36))];
        [_searchField ViewRadius: WidthOfScale(36)/2];
        _searchField.tintColor = colorFE851E;
        _searchField.font = RegularFont15;
        [_searchField setPlaceholderColor:colorAEAEAE];
        _searchField.placeholder = @"搜索店铺名称";
        _searchField.backgroundColor = colorEFEFEF;
        _searchField.textInsets = UIEdgeInsetsMake(0, WidthOfScale(21), 0, WidthOfScale(21));
        _searchField.delegate = self;
        _searchField.returnKeyType =  UIReturnKeySearch;
    }
    return _searchField;
}

-(QMUIButton *)searchBtn
{
    if (_searchBtn == nil) {
        _searchBtn = [[QMUIButton alloc] initWithFrame:CGRectMake(WidthOfScale(15), WidthOfScale(5.5), WidthOfScale(345), WidthOfScale(36))];
        [_searchBtn ViewRadius: WidthOfScale(36)/2];
        _searchBtn.titleLabel.font = RegularFont15;
        [_searchBtn setTitleColor:colorAEAEAE forState:(UIControlStateNormal)];
        [_searchBtn setTitle:@"搜索店铺名称" forState:(UIControlStateNormal)];
        _searchBtn.backgroundColor = colorEFEFEF;
        [_searchBtn setImage:UIImageMake(@"search") forState:(UIControlStateNormal)];
        _searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(6.5), 0, 0);
        @weakify(self);
        [[_searchBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [UIView animateWithDuration:0.3 animations:^{
               [self.searchField becomeFirstResponder];
                self.searchBtn.hidden = YES;
            }];
            
        }];
    }
    return _searchBtn;
}

- (void)viewDidLoad {
    self.viewModel = [[EFIMVM alloc] init];
    [super viewDidLoad];
    ((EFIMVM *)self.viewModel).shopName = @"";
    self.gk_navTitle = @"我的消息";
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, WidthOfScale(51.5))];
    bg.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bg];
    [bg addSubview:self.searchField];
    [bg addSubview:self.searchBtn];
    self.EFTableView.y = NAVIGATION_BAR_HEIGHT + WidthOfScale(51.5);
    self.EFTableView.height = kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT -  WidthOfScale(51.5);
    [self.EFTableView registerClass:[EFIMListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFIMListTableViewCell class])];
    
    [self loadList];
}

- (void)loadList {
    @weakify(self);
    [[self.viewModel refreshForDown] subscribeNext:^(RACTuple  *x) {
        @strongify(self);
        [self.EFTableView.mj_header endRefreshing];
        self.EFData = x.first;
        [self.EFTableView reloadData];
    }];
}


- (void)loadNewData {
    [self loadList];
}

- (void)loadMoreData {
    @weakify(self);
    [[self.viewModel refreshForUp] subscribeNext:^(RACTuple  *x) {
        @strongify(self);
        [self.EFTableView.mj_footer endRefreshing];
        self.EFData = x.first;
        [self.EFTableView reloadData];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        self.searchBtn.hidden = NO;
    }
    ((EFIMVM *)self.viewModel).shopName = textField.text;
    [self loadList];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    ((EFIMVM *)self.viewModel).shopName = textField.text;
    [self loadList];
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.EFData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFIMListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFIMListTableViewCell class])];
    [cell setModel:self.EFData[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthOfScale(80);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    TUIKitConfig *config = [TUIKitConfig defaultConfig];
//    config.avatarType = TAvatarTypeRounded;
//    TIMConversation *conv = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:@"abc"];
//    TUIChatController *vc = [[TUIChatController alloc] initWithConversation:conv];
    
    EFConversationViewController *vc = [[EFConversationViewController alloc] init];
    [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
    
    }];
}

@end
