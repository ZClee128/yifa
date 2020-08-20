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

//appId = wx2456b611d95ac358;
//body = "<null>";
//nonceStr = 4ophIzx5KThjF44y;
//package = "Sign=WXPay";
//partnerid = "<null>";
//paySign = 82AA29A9978186B7D17AA81334F58D56;
//prepayId = wx20101601893105e3d9f675777e936e0000;
//success = 1;
//timeStamp = 1597889762;
- (void)showPay:(orderPay)type resp:(id)dict{
    switch (type) {
        case wxPay:
        {
            PayReq* req = [[PayReq alloc] init];
            req.partnerId   = dict[@"partnerid"];
            req.prepayId    = dict[@"prepayId"];
            req.nonceStr    = dict[@"nonceStr"];
            req.timeStamp   = [dict[@"timeStamp"] doubleValue];
            req.package     = dict[@"package"];
            req.sign = dict[@"paySign"];
            [WXApi sendReq:req completion:^(BOOL success) {
                
            }];
        }
            break;
        default:
        {
            [[AlipaySDK defaultService] payOrder:dict[@"body"] fromScheme:@"EasyFast" callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
            }];
        }
            break;
    }
}

@end
