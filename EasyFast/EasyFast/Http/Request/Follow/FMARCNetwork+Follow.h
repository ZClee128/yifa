//
//  FMARCNetwork+Follow.h
//  EasyFast
//
//  Created by easyfast on 2020/8/6.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "FMARCNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMARCNetwork (Follow)

- (RACSignal *)findCollectGoodsList:(NSInteger )pageNum type:(NSInteger)type;

- (RACSignal *)findFollowShopList:(NSNumber *)pageNum;
@end

NS_ASSUME_NONNULL_END
