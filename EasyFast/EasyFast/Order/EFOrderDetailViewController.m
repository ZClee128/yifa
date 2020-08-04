//
//  EFOrderDetailViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/23.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOrderDetailViewController.h"
#import "EFOrderTitleTableViewCell.h"
#import "EFOrderGoodsTableViewCell.h"
#import "EFOrderPriceTableViewCell.h"
#import "EFOrderBtnTableViewCell.h"
#import "EFLogisticsViewController.h"
#import "EFOrderMoreDetailViewController.h"
#import "EFToPayDetailViewController.h"

@interface EFOrderDetailViewController ()

@end

@implementation EFOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navigationBar.hidden = YES;
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT- 45);
    self.gk_navLineHidden = YES;
    
    [self.EFTableView registerClass:[EFOrderTitleTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFOrderTitleTableViewCell class])];
    [self.EFTableView registerClass:[EFOrderGoodsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFOrderGoodsTableViewCell class])];
    [self.EFTableView registerClass:[EFOrderPriceTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFOrderPriceTableViewCell class])];
    [self.EFTableView registerClass:[EFOrderBtnTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFOrderBtnTableViewCell class])];
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, 70)];
    self.EFTableView.tableFooterView = foot;
}

- (UIView *)listView {
    return self.view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            EFOrderTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderTitleTableViewCell class])];
            [cell setModel:@""];
            return cell;
        }
        case 2: //self.EFData.count - 2
        {
            EFOrderPriceTableViewCell *priceCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderPriceTableViewCell class])];
            [priceCell setModel:@""];
            return priceCell;
        }
          case 3: //self.EFData.count - 1
        {
            EFOrderBtnTableViewCell *btnCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderBtnTableViewCell class])];
            [btnCell setModel:@""];
            @weakify(self);
            btnCell.moreClick = ^(QMUIButton * _Nonnull x) {
                [FTPopOverMenu showFromSenderFrame:[x convertRect:x.bounds toView:nil] withMenu:@[@"退货退款"] imageNameArray:@[@""] doneBlock:^(NSInteger selectedIndex) {
                    
                } dismissBlock:^{
                    
                }];
            };
            btnCell.oneClick = ^{
                @strongify(self);
                EFLogisticsViewController *vc = [[EFLogisticsViewController alloc] init];
                [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                
                }];
            };
            btnCell.threeClick = ^{
                @strongify(self);
                EFToPayDetailViewController *vc = [[EFToPayDetailViewController alloc] init];
                [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                
                }];
            };
            return btnCell;
        }
        default:
        {
            EFOrderGoodsTableViewCell *goodCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderGoodsTableViewCell class])];
            [goodCell setModel:@""];
            return goodCell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return WidthOfScale(61);
        case 2:
            return WidthOfScale(45.5);
        case 3:
            return WidthOfScale(70);
        default:
            return WidthOfScale(130);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EFOrderMoreDetailViewController *vc = [[EFOrderMoreDetailViewController alloc] init];
    [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
        
    }];
}

@end
