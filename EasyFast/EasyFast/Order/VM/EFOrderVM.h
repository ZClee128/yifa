//
//  EFOrderVM.h
//  EasyFast
//
//  Created by easyfast on 2020/8/7.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseRefreshVM.h"
#import "EFOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFOrderVM : EFBaseRefreshVM

@property (nonatomic,assign)NSInteger type;
@property (nonatomic,strong)NSString *searchText;

- (RACSignal *)searchRefreshForDown;
- (RACSignal *)searchRefreshForUp;

+ (RACSignal *)myOrderDetailExpressNum:(NSString *)expressNum orderNum:(NSString *)orderNum;
@end

NS_ASSUME_NONNULL_END
