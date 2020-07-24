//
//  EFHelpViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFHelpViewController.h"
#import "EFHelpTableViewCell.h"

@interface EFHelpViewController ()<QMUITextFieldDelegate>

@end

@implementation EFHelpViewController

-(QMUITextField *)searchField
{
    if (_searchField == nil) {
        _searchField = [[QMUITextField alloc] initWithFrame:CGRectMake(WidthOfScale(15), WidthOfScale(5.5), WidthOfScale(345), WidthOfScale(36))];
        [_searchField ViewRadius: WidthOfScale(36)/2];
        _searchField.tintColor = colorFE851E;
        _searchField.font = RegularFont15;
        [_searchField setPlaceholderColor:colorAEAEAE];
        _searchField.placeholder = @"搜索问题";
        _searchField.backgroundColor = colorEFEFEF;
        _searchField.textInsets = UIEdgeInsetsMake(0, WidthOfScale(21), 0, WidthOfScale(21));
        _searchField.delegate = self;
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
        [_searchBtn setTitle:@"搜索问题" forState:(UIControlStateNormal)];
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
    [super viewDidLoad];
    self.gk_navTitle = @"我的客服";
    self.EFTableView.y = NAVIGATION_BAR_HEIGHT + WidthOfScale(51.5);
    self.EFTableView.height = kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT -  WidthOfScale(51.5) - WidthOfScale(50);
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, WidthOfScale(51.5))];
    bg.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bg];
    [bg addSubview:self.searchField];
    [bg addSubview:self.searchBtn];
    [self.EFTableView registerClass:[EFHelpTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFHelpTableViewCell class])];
    
    self.kefu = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [self.kefu setImage:UIImageMake(@"kefu") forState:(UIControlStateNormal)];
    [self.kefu setTitle:@"人工客服" forState:(UIControlStateNormal)];
    self.kefu.backgroundColor = UIColor.whiteColor;
    self.kefu.titleLabel.font = RegularFont14;
    [self.kefu setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
    self.kefu.imagePosition = QMUIButtonImagePositionLeft;
    self.kefu.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WidthOfScale(10.5));
    [self.view addSubview:self.kefu];
    [[self.kefu rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    [self.kefu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.equalTo(@(kPHONE_WIDTH));
        make.height.equalTo(@(WidthOfScale(50)));
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        self.searchBtn.hidden = NO;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  5;//self.EFData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFHelpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFHelpTableViewCell class])];
    [cell setModel:@"为什么一直是拼单状态"];
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthOfScale(44);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [self.EFTableView viewWithTag:500];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(59))];
        view.tag = 500;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(10))];
        line.backgroundColor = colorfafafa;
        [view addSubview:line];
        
        QMUILabel *titleLab = [[QMUILabel alloc] initWithFrame:CGRectMake(0, WidthOfScale(10), kPHONE_WIDTH, WidthOfScale(49))];
        [view addSubview:titleLab];
        titleLab.contentEdgeInsets = UIEdgeInsetsMake(WidthOfScale(20), WidthOfScale(14), WidthOfScale(14.5), 0);
        titleLab.backgroundColor = UIColor.whiteColor;
        titleLab.font = MedFont15;
        titleLab.textColor = tabbarBlackColor;
        titleLab.textAlignment = NSTextAlignmentLeft;
        titleLab.text = @"常见问题";
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return WidthOfScale(59);
}
@end
