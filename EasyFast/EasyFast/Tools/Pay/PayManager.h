//
//  PayManager.h
//  EasyFast
//
//  Created by easyfast on 2020/8/17.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    wxPay,
    aliPay,
} orderPay;


@interface PayManager : NSObject
+ (instancetype)defaultManager;

- (void)showPay:(orderPay)type resp:(id)dict;
@end

NS_ASSUME_NONNULL_END
