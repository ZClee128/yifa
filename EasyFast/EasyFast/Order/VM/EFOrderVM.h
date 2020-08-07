//
//  EFOrderVM.h
//  EasyFast
//
//  Created by easyfast on 2020/8/7.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseRefreshVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFOrderVM : EFBaseRefreshVM

+ (RACSignal *)myOrderListpPageNum:(NSNumber *)pageNum type:(NSInteger)type;
@end

NS_ASSUME_NONNULL_END
