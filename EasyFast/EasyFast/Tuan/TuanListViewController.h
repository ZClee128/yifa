//
//  TuanListViewController.h
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseTableViewController.h"
#import "TuanGoodsView.h"
NS_ASSUME_NONNULL_BEGIN

@interface TuanListViewController : EFBaseTableViewController
@property (nonatomic,strong)TuanGoodsView *goodsHeaderView;
- (instancetype)initWithGGNo:(NSString *)ggNO;
@end

NS_ASSUME_NONNULL_END
