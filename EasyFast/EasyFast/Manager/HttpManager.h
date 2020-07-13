//
//  HttpManager.h
//  EasyFast
//
//  Created by zclee on 2020/7/13.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpManager : NSObject

+ (instancetype)defaultManager;
- (NSString *)envBaseHost;
@end

NS_ASSUME_NONNULL_END
