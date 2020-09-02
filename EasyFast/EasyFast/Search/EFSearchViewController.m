//
//  EFSearchViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFSearchViewController.h"
#import "EFSearchResultViewController.h"
#import "EFSearchVM.h"
#import "SKTagView.h"

@interface EFSearchViewController ()<QMUITableViewDelegate,QMUITableViewDataSource,QMUITextFieldDelegate>

@property (nonatomic,strong)QMUITextField *searchField;
@property (nonatomic,strong)QMUIButton *cancle;
@property (nonatomic,strong)QMUITableView *tableView;
@property (nonatomic,strong)SKTagView *tagView;
@property (nonatomic,assign)BOOL isRoot;

@end

@implementation EFSearchViewController


- (SKTagView *)tagView {
    if (_tagView == nil) {
        _tagView = [[SKTagView alloc] init];
        // 整个tagView对应其SuperView的上左下右距离
        _tagView.padding = UIEdgeInsetsMake(0, 15, 0, 15);
        // 上下行之间的距离
        _tagView.lineSpacing = 10;
        // item之间的距离
        _tagView.interitemSpacing = 10;
        // 最大宽度
        _tagView.preferredMaxLayoutWidth = kPHONE_WIDTH;
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
        _searchField.returnKeyType = UIReturnKeySearch;
        _searchField.delegate = self;
        [[RACSignal merge:@[_searchField.rac_textSignal, RACObserve(_searchField, text)]] subscribeNext:^(RACTuple *x) {
            XYLog(@"%@",x);
        }];
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
            if (self.isRoot) {
                [self.navigationController qmui_popToRootViewControllerAnimated:YES completion:^{
                    
                }];
            }else {
                [self.navigationController qmui_popViewControllerAnimated:YES completion:^{
                    
                }];
            }
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
    self.viewModel = [[EFSearchVM alloc] init];
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
    [self loadHistory];
}

- (void)loadHistory {
    @weakify(self);
    if (kUserManager.userModel != nil && kUserManager.userModel.isLogin) {
        [[EFSearchVM getSearchHistoryList] subscribeNext:^(NSArray *x) {
            @strongify(self);
            //        self.tagView.tagTitleArray = x;
            //        [self.tagView createTags];
            [self.tagView removeAllTags];
            [x enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                // 初始化标签
                SKTag *tag = [[SKTag alloc] initWithText:x[idx]];
                // 标签相对于自己容器的上左下右的距离
                tag.padding = UIEdgeInsetsMake(8, 21, 8, 21);
                // 弧度
                tag.cornerRadius = 5.0f;
                // 字体
                tag.font = RegularFont14;
                // 边框宽度
                tag.borderWidth = 0;
                // 背景
                tag.bgColor = colorfafafa;
                // 边框颜色
                //            tag.borderColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
                // 字体颜色
                tag.textColor = tabbarBlackColor;
                // 是否可点击
                tag.enable = YES;
                // 加入到tagView
                [self.tagView addTag:tag];
            }];
            // 点击事件回调
            self.tagView.didTapTagAtIndex = ^(NSUInteger idx){
                XYLog(@"点击了第%ld个",idx);
                @strongify(self);
                NSString *searchTitle = x[idx];
                EFSearchResultViewController *resultVC = [[EFSearchResultViewController alloc] initWithSearchTitle:searchTitle];
                self.isRoot = YES;
                [self.navigationController pushViewController:resultVC animated:NO];
            };
            // 获取刚才加入所有tag之后的内在高度
            CGFloat tagHeight = self.tagView.intrinsicContentSize.height;
            XYLog(@"高度%lf",tagHeight);
            self.tagView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT + 20, kPHONE_WIDTH, tagHeight);
            [self.tagView layoutSubviews];
            [self.view addSubview:self.tagView];
        }];
    }
}

- (void)recordSearch:(NSString *)text {
    @weakify(self);
    if (kUserManager.userModel != nil && kUserManager.userModel.isLogin) {
        [[[FMARCNetwork sharedInstance] recordGoodsLogType:1 category:@"" goodsNo:@"" searchText:text] subscribeNext:^(FMHttpResonse *x) {
            @strongify(self);
            [self loadHistory];
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    if (textField.text.length != 0) {
//        [self recordSearch:textField.text];
//        [self.view addSubview:self.tableView];
//    }else {
//        [self.tableView removeFromSuperview];
//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length == 0) {
        textField.text = self.searchField.placeholder;
    }
    [self recordSearch:textField.text];
    EFSearchResultViewController *resultVC = [[EFSearchResultViewController alloc] initWithSearchTitle:textField.text];
    self.isRoot = YES;
    [self.navigationController pushViewController:resultVC animated:NO];
    return YES;
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
