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
#import "EFLogisticsTwoLabTableViewCell.h"
#import "EFTimeAxisTableViewCell.h"

@interface EFLogisticsViewController ()

@property (nonatomic,strong)NSMutableArray *wuliuArr;
@property (nonatomic,assign)CGFloat cellHeight;
@end

@implementation EFLogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"查看物流";
    [self.EFTableView registerClass:[LogisticsHeaderTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LogisticsHeaderTableViewCell class])];
    [self.EFTableView registerClass:[EFLogisticsTwoLabTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFLogisticsTwoLabTableViewCell class])];
    [self.EFTableView registerClass:[EFTimeAxisTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFTimeAxisTableViewCell class])];
    self.wuliuArr = [@[@[@"快递公司：",@"货拉拉"],@[@"收货地址：",@"广东省深圳市南山区大新时代广场1302"],@[@"订单号：",@"SF10752482411"]] mutableCopy];
    self.EFData = [@[@1,@1,@1,@1,@1,@1] mutableCopy];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return self.wuliuArr.count;
        default:
            return self.EFData.count;
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
        case 1:
        {
            EFLogisticsTwoLabTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFLogisticsTwoLabTableViewCell class])];
            [titleCell setModel:self.wuliuArr[indexPath.row]];
            return titleCell;
        }
        default:
        {
            EFTimeAxisTableViewCell *timeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFTimeAxisTableViewCell class])];
            [timeCell setModel:@""];
            indexPath.row == 0 ? [timeCell hiddenTop] : [timeCell showTop];
            indexPath.row == 0 ? [timeCell setSelectImage] : [timeCell setNormalImage];
            indexPath.row == self.EFData.count - 1 ? [timeCell hiddenBottom] : [timeCell showBottom];
            self.cellHeight = [timeCell getCellHeight];
            return timeCell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return WidthOfScale(120);
        case 1:
            return WidthOfScale(28);
        default:
            return self.cellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 1 ? WidthOfScale(37) : 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *line = [self.EFTableView viewWithTag:600];
    if (line == nil) {
        line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(37))];
        line.backgroundColor = UIColor.whiteColor;
        line.tag = 600;
    }
    return section == 1 ? line : nil ;
}



@end
