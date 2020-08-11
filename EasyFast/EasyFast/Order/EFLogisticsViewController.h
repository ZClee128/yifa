//
//  EFLogisticsViewController.h
//  EasyFast
//
//  Created by zclee on 2020/7/23.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseTableViewController.h"
#import "EFOrderVM.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFLogisticsViewController : EFBaseTableViewController
- (instancetype)initWithExpressNum:(EFOrderModel *)model;
@end

NS_ASSUME_NONNULL_END
