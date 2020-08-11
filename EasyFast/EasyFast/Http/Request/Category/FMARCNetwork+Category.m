//
//  FMARCNetwork+Category.m
//  EasyFast
//
//  Created by easyfast on 2020/8/11.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "FMARCNetwork+Category.h"

@implementation FMARCNetwork (Category)

- (RACSignal *)category {
    return [self fg_getRequest:kcategory paramters:@{}];
}

- (RACSignal *)categoryByPno:(NSString *)pCode {
    return [self fg_getRequest:kcategoryByPno paramters:@{@"pCode":pCode}];
}

- (RACSignal *)thirdCategory:(NSString *)pCode size:(NSString *)size {
    return [self fg_getRequest:kthirdCategory paramters:@{@"pCode":pCode,@"size":size}];
}
@end
