//
//  EFSearchViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFSearchViewController.h"
#import "TKTagView.h"
#import "EFSearchResultViewController.h"
@interface EFSearchViewController ()<QMUITableViewDelegate,QMUITableViewDataSource>

@property (nonatomic,strong)QMUITextField *searchField;
@property (nonatomic,strong)QMUIButton *cancle;
@property (nonatomic,strong)QMUITableView *tableView;
@property (nonatomic,strong)TKTagView *tagView;

@end

@implementation EFSearchViewController


- (TKTagView *)tagView {
    if (_tagView == nil) {
        _tagView = [[TKTagView alloc] initWithFrame:CGRectMake(15, NAVIGATION_BAR_HEIGHT + 20, kPHONE_WIDTH-30, 1)];
        _tagView.tagFontSize = 14;
        _tagView.tagTitleColorArray = @[tabbarBlackColor];
        _tagView.tagColorArray = @[colorfafafa];
        _tagView.padding = WidthOfScale(10);
    }
    return _tagView;
}

-(QMUITextField *)searchField
{
    if (_searchField == nil) {
        _searchField = [[QMUITextField alloc] initWithFrame:CGRectMake(WidthOfScale(15), STATUS_BAR_HEIGHT, WidthOfScale(300), WidthOfScale(36))];
        [_searchField ViewRadius: WidthOfScale(36)/2];
        _searchField.tintColor = colorFE851E;
        _searchField.font = RegularFont15;
        [_searchField setPlaceholderColor:colorAEAEAE];
        _searchField.placeholder = @"滑板车";
        _searchField.backgroundColor = colorEFEFEF;
        _searchField.textInsets = UIEdgeInsetsMake(0, WidthOfScale(21), 0, WidthOfScale(21));
        [_searchField becomeFirstResponder];
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
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _cancle;
}

- (QMUITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[QMUITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[QMUITableViewCell class] forCellReuseIdentifier:NSStringFromClass([QMUITableViewCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navigationBar.hidden = YES;
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.searchField];
    [self.view addSubview:self.cancle];
    [self.cancle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.left.equalTo(self.searchField.mas_right).equalTo(@(0));
        make.centerY.equalTo(self.searchField);
        make.height.equalTo(@(WidthOfScale(36)));
    }];
    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.tagView];
//    self.tagView.tagTitleArray = @[@"华为pro 30",@"无袖吊带T恤",@"滑板车"];
//    [self.tagView createTags];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QMUITableViewCell class])];
    cell.textLabel.text = @"滑板鞋";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EFSearchResultViewController *resultVC = [[EFSearchResultViewController alloc] init];
    [self.navigationController pushViewController:resultVC animated:NO];
}

@end
