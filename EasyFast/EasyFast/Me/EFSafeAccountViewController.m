//
//  EFSafeAccountViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/7/30.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFSafeAccountViewController.h"
#import "EFSetUpTableViewCell.h"
#import "EFEditPasswordViewController.h"
#import "EFBindPhoneViewController.h"

@interface EFSafeAccountViewController ()

@end

@implementation EFSafeAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.EFTableView.height = kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT - TAB_SAFE_HEIGHT;
    self.gk_navTitle = @"账号与安全";
    self.EFData = [@[@{@"title":@"会员账号",@"subTitle":kUserManager.userModel.username},
                     @{@"title":@"修改手机",@"subTitle":kUserManager.userModel.phone},
                     @{@"title":@"修改登录密码",@"subTitle":kUserManager.userModel.isPassword ? @"" : @"初始密码为123456"},@{@"title":@"注销账号",@"subTitle":@""}] mutableCopy];
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kChangePhone object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self.EFTableView reloadData];
    }];
}

- (void)setLoginOUtBtn {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.EFData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFSetUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFSetUpTableViewCell class]) forIndexPath:indexPath];
    [cell setModel:self.EFData[indexPath.row]];
    if (indexPath.row == 0) {
        [cell hiddenMore];
    }else {
        [cell showMore];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            
            break;
        }
            case 1:
        {
            EFCodeViewController *vc = [[EFCodeViewController alloc] initWithPhone:kUserManager.userModel.phone];
            [self.navigationController qmui_pushViewController:vc animated:YES completion:^{

            }];
            break;
        }
            case 2:
        {
            EFEditPasswordViewController *vc = [[EFEditPasswordViewController alloc] init];
            [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                
            }];

            break;
        }
        default:
        {
           
            break;
        }
    }
}

@end
