//
//  NSDictionary+Null.m
//  EasyFast
//
//  Created by easyfast on 2020/8/14.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "NSDictionary+Null.h"

@implementation NSDictionary (Null)

- (NSDictionary *)deleteNull{
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    for (NSString *keyStr in self.allKeys) {
        
        if ([[self objectForKey:keyStr] isEqual:[NSNull null]]) {
            
            [mutableDic setObject:@"" forKey:keyStr];
        }
        else{
            
            [mutableDic setObject:[self objectForKey:keyStr] forKey:keyStr];
        }
    }
    return mutableDic;
}
@end
