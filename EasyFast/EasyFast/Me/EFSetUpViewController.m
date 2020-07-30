//
//  EFSetUpViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFSetUpViewController.h"
#import "EFSetUpVM.h"
#import "EFSetUpTableViewCell.h"
#import "EFChangeAccountViewController.h"
#import "EFPrivacyViewController.h"
#import "EFNotiViewController.h"
#import "EFSafeAccountViewController.h"

@interface EFSetUpViewController ()

@property (nonatomic,strong)QMUIButton *loginOutBtn;

@end

@implementation EFSetUpViewController

-(QMUIButton *)loginOutBtn
{
    if (_loginOutBtn == nil) {
        _loginOutBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_loginOutBtn setTitle:@"退出登录" forState:(UIControlStateNormal)];
        [_loginOutBtn setTitleColor:colorF14745 forState:(UIControlStateNormal)];
        _loginOutBtn.titleLabel.font = MedFont15;
        _loginOutBtn.backgroundColor = UIColor.whiteColor;
        @weakify(self);
        [[_loginOutBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self bottomClick];
        }];
    }
    return _loginOutBtn;
}

- (void)bottomClick {
    
}

- (void)viewDidLoad {
    self.viewModel = [[EFSetUpVM alloc] init];
    [super viewDidLoad];
    self.gk_navTitle = @"设置";
    self.EFTableView.height = kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT - WidthOfScale(50) - TAB_SAFE_HEIGHT;
    [self.EFTableView registerClass:[EFSetUpTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFSetUpTableViewCell class])];
    [self setLoginOUtBtn];
}

- (void)setLoginOUtBtn {
    [self.view addSubview:self.loginOutBtn];
    [self.loginOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(WidthOfScale(50)+TAB_SAFE_HEIGHT));
        make.width.equalTo(@(kPHONE_WIDTH));
    }];
}

- (void)setBottomTile:(NSString *)title color:(UIColor *)color {
    [self.loginOutBtn setTitle:title forState:(UIControlStateNormal)];
    [self.loginOutBtn setTitleColor:color forState:(UIControlStateNormal)];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [self.viewModel.dataSources[0] count];
        default:
            return [self.viewModel.dataSources[1] count];;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFSetUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFSetUpTableViewCell class]) forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
        {
            NSDictionary *dict = self.viewModel.dataSources[0][indexPath.row];
            [cell setModel:dict];
            return cell;
        }
        default:
        {
            NSDictionary *dict = self.viewModel.dataSources[1][indexPath.row];
            [cell setModel:dict];
            if (indexPath.row == 3) {
                [cell hiddenMore];
            }else {
                [cell showMore];
            }
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    EFChangeAccountViewController *vc = [[EFChangeAccountViewController alloc] init];
                    [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                        
                    }];
                }
                    break;
                case 1:
                {
                    EFSafeAccountViewController *vc = [[EFSafeAccountViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                        
                    }];
                }
                    break;
                default:
                {
                    EFPrivacyViewController *vc = [[EFPrivacyViewController alloc] init];
                    [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                        
                    }];
                }
                    break;
            }
            
            break;
        }
        default:
        {
            switch (indexPath.row) {
                case 0:
                {
                    EFNotiViewController *vc = [[EFNotiViewController alloc] init];
                    [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                        
                    }];
                    break;
                }
                default:
                    break;
            }
        }
    }
}
@end
