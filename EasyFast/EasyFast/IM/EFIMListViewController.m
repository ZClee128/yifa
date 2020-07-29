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

@interface EFIMListViewController ()

@end

@implementation EFIMListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"我的消息";
    self.EFTableView.height = self.EFTableView.height + WidthOfScale(50);
    [self.searchBtn setTitle:@"搜索店铺名称" forState:(UIControlStateNormal)];
    self.searchField.placeholder = @"搜索店铺名称";
    [self.EFTableView registerClass:[EFIMListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFIMListTableViewCell class])];
    self.kefu.hidden = YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFIMListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFIMListTableViewCell class])];
    [cell setModel:@""];
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
