//
//  FMARCNetwork+Category.h
//  EasyFast
//
//  Created by easyfast on 2020/8/11.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "FMARCNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMARCNetwork (Category)

- (RACSignal *)category;

- (RACSignal *)categoryByPno:(NSString *)pCode;

- (RACSignal *)thirdCategory:(NSString *)pCode size:(NSString *)size;
@end

NS_ASSUME_NONNULL_END
