//
//  FMARCNetwork+Login.h
//  EasyFast
//
//  Created by easyfast on 2020/8/3.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "FMARCNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMARCNetwork (Login)

- (RACSignal *)userLogin;
@end

NS_ASSUME_NONNULL_END
