//
//  PayManager.m
//  EasyFast
//
//  Created by easyfast on 2020/8/17.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "PayManager.h"

@implementation PayManager

+ (instancetype)defaultManager {
    static PayManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [PayManager new];
    });
    return _sharedManager;
}

- (void)showPay:(orderPay)type resp:(id)dict{
    switch (type) {
        case wxPay:
        {
            PayReq* req = [[PayReq alloc] init];
            req.partnerId   = dict[@"partnerid"];
            req.prepayId    = dict[@"prepayid"];
            req.nonceStr    = dict[@"noncestr"];
            req.timeStamp   = [dict[@"timestamp"] doubleValue];
            req.package     = dict[@"package"];
            req.sign = dict[@"sign"];
            [WXApi sendReq:req completion:^(BOOL success) {
                
            }];
        }
            break;
        default:
        {
            [[AlipaySDK defaultService] payOrder:dict fromScheme:@"EasyFast" callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
            }];
        }
            break;
    }
}

@end
