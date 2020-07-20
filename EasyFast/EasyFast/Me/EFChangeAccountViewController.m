//
//  EFChangeAccountViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFChangeAccountViewController.h"
#import "EFAccountTableViewCell.h"

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
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFAccountTableViewCell class])];
    [cell setModel:@""];
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

@end
