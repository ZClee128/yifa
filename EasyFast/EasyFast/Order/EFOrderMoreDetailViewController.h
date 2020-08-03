//
//  EFOrderMoreDetailViewController.h
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseTableViewController.h"
#import "EFWuliuTableViewCell.h"
#import "EFOrderAddressTableViewCell.h"
#import "EFOrderShopTableViewCell.h"
#import "EFOrderDetailGoodsTableViewCell.h"
#import "EFOrderPriceDetailTableViewCell.h"
#import "EFRealPriceTableViewCell.h"
#import "EFTimeTableViewCell.h"
#import "TuanOtherGoodsTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFOrderMoreDetailViewController : EFBaseTableViewController
@property (nonatomic,assign)CGFloat wuliHeight;
@property (nonatomic,assign)CGFloat addressHeight;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIView *headerView;
@property (nonatomic,strong)NSMutableArray *priceArr;
@property (nonatomic,strong)NSMutableArray *orderArr;
@property (nonatomic,assign)BOOL ismore;
@end


NS_ASSUME_NONNULL_END
