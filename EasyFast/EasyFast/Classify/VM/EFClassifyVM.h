//
//  EFClassifyVM.h
//  EasyFast
//
//  Created by easyfast on 2020/8/11.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseRefreshVM.h"
#import "EFClassifyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFClassifyVM : EFBaseRefreshVM

+ (RACSignal *)category;

+ (RACSignal *)categoryByPno:(NSString *)pCode;

+ (RACSignal *)thirdCategory:(NSString *)pCode size:(NSString *)size;
@end

NS_ASSUME_NONNULL_END
