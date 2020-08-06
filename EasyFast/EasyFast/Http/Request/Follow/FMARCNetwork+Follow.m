//
//  FMARCNetwork+Follow.m
//  EasyFast
//
//  Created by easyfast on 2020/8/6.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "FMARCNetwork+Follow.h"

@implementation FMARCNetwork (Follow)

- (RACSignal *)findFollowShopList:(NSNumber *)pageNum {
    return [self fg_postRequest:kfindFollowShopList paramters:@{@"pageNum":pageNum}];
}
@end
