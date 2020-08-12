//
//  EFOrderDetailViewController.h
//  EasyFast
//
//  Created by zclee on 2020/7/23.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    /// 全部
    OrderTypeALL,
    /// 待付款
    OrderTypePay,
    /// 待发货
    OrderTypeSend,
    /// 待收货
    OrderTypeGet,
    /// 待评价
    OrderTypeSay
} OrderType;


@interface EFOrderDetailViewController : EFBaseTableViewController<JXCategoryListContentViewDelegate>

- (instancetype)initWithType:(OrderType)type;
- (void)loadList;
@end

NS_ASSUME_NONNULL_END
