//
//  HttpManager.m
//  EasyFast
//
//  Created by zclee on 2020/7/13.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager

+ (instancetype)defaultManager {
    static HttpManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [HttpManager new];
    });
    return _sharedManager;
}



- (NSString *)envBaseHost {
    NSString *host = nil;
    if (EF == 1) {
        host = BaseUrl;
    } else if (EFDEV == 1) {
        host = DevUrl;
    } else if (EFTEST == 1) {
        host = TestUrl;
    }
    return host;
}

@end
