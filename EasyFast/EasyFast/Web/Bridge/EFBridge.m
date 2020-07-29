//
//  EFBridge.m
//  EasyFast
//
//  Created by easyfast on 2020/7/28.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBridge.h"

@interface EFBridge ()
@property (nonatomic,strong)WebViewJavascriptBridge *bridge;
@end

@implementation EFBridge

- (instancetype)initWithBridge:(WebViewJavascriptBridge *)bridge
{
    self = [super init];
    if (self) {
        self.bridge = bridge;
    }
    return self;
}

- (void)GetNavHeight {
    [self.bridge registerHandler:@"NavHeight" handler:^(id data, WVJBResponseCallback responseCallback) {
        XYLog(@"called with: %@", data);
        responseCallback(@{@"success":@(YES),@"data":@{@"height":@(NAVIGATION_BAR_HEIGHT)}});
    }];
    
}

- (RACSignal *)getMeListHeight {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self.bridge registerHandler:@"clientHeight" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSDictionary *dict = [self identifyData:data];
            [subscriber sendNext:@([dict[@"height"] floatValue])];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}


- (NSDictionary *)identifyData:(id)data{
    NSDictionary * dict = [[NSDictionary alloc] init];
    if ([data isKindOfClass:[NSString class]]) {
        NSString * str = (NSString *)data;
        NSData * jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError * error;
        dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    }else if ([data isKindOfClass:[NSDictionary class]]){
        dict = (NSDictionary*)data;
    }else{
//        [[SL_H5ParametersValidation alloc] alertViewtitle:@"请传入JSON对象，不支持字符串" Msg:data];
        XYLog(@"请传入JSON对象，不支持字符串>>>%@",data);
    }
    return dict;
}
@end
