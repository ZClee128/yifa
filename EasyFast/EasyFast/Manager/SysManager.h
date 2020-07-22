//
//  SysManager.h
//  EasyFast
//
//  Created by zclee on 2020/7/22.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SysManager : NSObject

+ (instancetype)defaultManager;

- (NSInteger)locationEnable;
- (BOOL)AVAudioEnable;
- (BOOL)photoEnable;
- (BOOL)cameraEnable;
- (void)Alert:(NSString *)message;
@end

NS_ASSUME_NONNULL_END
