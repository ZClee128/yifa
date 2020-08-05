//
//  EFChangeAccountViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFChangeAccountViewController.h"
#import "EFAccountTableViewCell.h"
#import "LoginVM.h"
@interface EFChangeAccountViewController ()

@property (nonatomic,strong)QMUIButton *changeBtn;
@end

@implementation EFChangeAccountViewController

-(QMUIButton *)changeBtn
{
    if (_changeBtn == nil) {
        _changeBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        _changeBtn.frame = CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(50));
        [_changeBtn setTitle:@"添加账号" forState:(UIControlStateNormal)];
        [_changeBtn setTitleColor:colorF14745 forState:(UIControlStateNormal)];
        _changeBtn.titleLabel.font = MedFont15;
        _changeBtn.backgroundColor = UIColor.whiteColor;
    }
    return _changeBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"切换账号";
    [self.EFTableView registerClass:[EFAccountTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFAccountTableViewCell class])];
    self.EFTableView.tableFooterView = self.changeBtn;
    self.EFData = [[EFUserModel bg_findAll:nil] mutableCopy];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.EFData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFAccountTableViewCell class])];
    [cell setModel:self.EFData[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthOfScale(60);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[LoginVM loginOut] subscribeNext:^(id  _Nullable x) {
        
    }];
    
    for (EFUserModel *model in [EFUserModel bg_findAll:nil]) {
        if ([model.username isEqualToString:kUserManager.userModel.username]) {
            model.isLogin = NO;
            model.token = @"";
            [model bg_saveOrUpdate];
        }
    }
    
    XYLog(@">>>>%@",[EFUserModel bg_findAll:nil]);
    [self.navigationController qmui_popToRootViewControllerAnimated:NO completion:^{
        [EFOnePhoneLoginManager show];
    }];
    kAppDelegate.efTabbar.selectedIndex = 0;
}
@end
