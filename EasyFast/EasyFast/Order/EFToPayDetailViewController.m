//
//  EFToPayDetailViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/8/3.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFToPayDetailViewController.h"
#import "EFPayTypeTableViewCell.h"

@interface EFToPayDetailViewController ()

@end

@implementation EFToPayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.EFTableView registerClass:[EFPayTypeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFPayTypeTableViewCell class])];
    self.orderArr = [@[@{@"icon":@"wxpay",@"title":@"微信支付"},@{@"icon":@"alipay",@"title":@"支付宝"}] mutableCopy];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1; //头部
        case 1:
            return 4; //商品信息
        case 2:
            return self.priceArr.count; //价格
        default:
            return self.orderArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            EFOrderAddressTableViewCell *adCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderAddressTableViewCell class])];
            [adCell setModel:@""];
            self.addressHeight = [adCell getCellHeight];
            return adCell;
        }
            case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    EFOrderShopTableViewCell *shopCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderShopTableViewCell class])];
                    [shopCell setModel:@""];
                    return shopCell;
                }
                default:
                {
                    EFOrderDetailGoodsTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderDetailGoodsTableViewCell class])];
                    [goodsCell setModel:@""];
                    return goodsCell;
                }
            }
        }
            case 2:
        {
            if (self.priceArr.count - 1 == indexPath.row) {
                EFRealPriceTableViewCell *realCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFRealPriceTableViewCell class])];
                [realCell setModel:self.priceArr[indexPath.row]];
                @weakify(self);
                realCell.moreClick = ^(QMUIButton * _Nonnull x) {
                    @strongify(self);
                    self.ismore = !x.selected;
                    [[RACScheduler mainThreadScheduler] schedule:^{
                       [self.EFTableView reloadData];
                    }];
                };
                return realCell;
            }else {
                EFOrderPriceDetailTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderPriceDetailTableViewCell class])];
                [detailCell setModel:self.priceArr[indexPath.row]];
                if (self.ismore) {
                    detailCell.hidden = NO;
                }else {
                    indexPath.row == 1 ? (detailCell.hidden = YES) : (detailCell.hidden = NO);
                }
                return detailCell;
            }
        }
            default:
        {
            EFPayTypeTableViewCell *timeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFPayTypeTableViewCell class])];
            [timeCell setModel:self.orderArr[indexPath.row]];
            return timeCell;
        }
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            return self.addressHeight;
        }
            case 1:
        {
            switch (indexPath.row) {
                case 0:
                   return WidthOfScale(48);
                default:
                return WidthOfScale(145);
            }
        }
        case 2: {
            if (self.priceArr.count - 1 == indexPath.row) {
                return WidthOfScale(39);
            }else {
                if (self.ismore) {
                   return WidthOfScale(21.5);
                }else {
                   return indexPath.row == 1 ? 0 : WidthOfScale(21.5);
                }
            }
        }
            default:
        {
            return WidthOfScale(40);
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return section == 2 ? self.headerView : nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return section == 1 ? self.lineView : nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 1 ? 20 : 0.001;
}

@end
