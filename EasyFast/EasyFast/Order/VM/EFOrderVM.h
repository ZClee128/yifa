//
//  EFOrderVM.h
//  EasyFast
//
//  Created by easyfast on 2020/8/7.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseRefreshVM.h"
#import "EFOrderModel.h"
#import "EFLogisticsModel.h"
#import "EFGoodsList.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFOrderVM : EFBaseRefreshVM

@property (nonatomic,assign)NSInteger type;
@property (nonatomic,strong)NSString *searchText;

- (RACSignal *)searchRefreshForDown;
- (RACSignal *)searchRefreshForUp;

+ (RACSignal *)myOrderDetailExpressNum:(NSString *)expressNum orderNum:(NSString *)orderNum;

+ (RACSignal *)confirmReceiptExpressNum:(NSString *)expressNum orderNum:(NSString *)orderNum;

+ (RACSignal *)urgedDeliveryOrderNum:(NSString *)orderNum;

+ (RACSignal *)orderExpressExpressNum:(NSString *)expressNum orderNum:(NSString *)orderNum;

- (RACSignal *)newGoodsRefreshForDown:(NSString *)sssNO;

- (RACSignal *)newGoodsRefreshForUp:(NSString *)sssNO;

+ (RACSignal *)refreshOrder:(NSString *)orderNum;
@end

NS_ASSUME_NONNULL_END
