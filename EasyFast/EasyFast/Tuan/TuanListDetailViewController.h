//
//  TuanListDetailViewController.h
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "TuanListViewController.h"
#import "EFTeamGoodsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TuanListDetailViewController : EFBaseTableViewController

- (instancetype)initWithGGNo:(NSString *)ggNO ootNo:(NSString *)ootNo model:(EFTeamGoodsModel *)model;
@end

NS_ASSUME_NONNULL_END
