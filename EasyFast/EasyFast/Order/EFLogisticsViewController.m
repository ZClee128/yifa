//
//  EFLogisticsViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/23.
//  Copyright © 2020 EasyFast. All rights reserved.
//

// 物流
#import "EFLogisticsViewController.h"
#import "LogisticsHeaderTableViewCell.h"

@interface EFLogisticsViewController ()

@end

@implementation EFLogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"查看物流";
    [self.EFTableView registerClass:[LogisticsHeaderTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LogisticsHeaderTableViewCell class])];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            {
                LogisticsHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LogisticsHeaderTableViewCell class])];
                [cell setModel:@""];
                return cell;
            }
        default:
            return [[UITableViewCell alloc] init];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
           return WidthOfScale(120);
        default:
            return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

@end
