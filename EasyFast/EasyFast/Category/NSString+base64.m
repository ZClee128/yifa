//
//  NSString+base64.m
//  EasyFast
//
//  Created by easyfast on 2020/8/5.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "NSString+base64.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (base64)

-(NSString *)base64EncodeString{
    //1、先转换成二进制数据
    NSData *data =[self dataUsingEncoding:NSUTF8StringEncoding];
    //2、对二进制数据进行base64编码，完成后返回字符串
    return [data base64EncodedStringWithOptions:0];
}
-(NSString *)base64DecodeString{
    //注意：该字符串是base64编码后的字符串
    //1、转换为二进制数据（完成了解码的过程）
    NSData *data=[[NSData alloc]initWithBase64EncodedString:self options:0];
    //2、把二进制数据转换成字符串
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr,(CC_LONG)strlen(cStr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02x", digest[i]];
    return  output;
}


- (BOOL)deptNumInputShouldNumber
{
    if (self.length == 0) {
        return NO;
    }
//    NSString *regex = @"^(?![\d]+$)(?![a-zA-Z]+$)(?![!#$%^&*]+$)[\da-zA-Z!#$%^&*]{6,20}$";
    NSString *regex = @"^[\\p{Punct}a-zA-Z0-9]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}

- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}


- (id)parseJSONStringToNSDictionary {
    
    NSData *JSONData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    
    id jsonObject = [NSJSONSerialization
                     
                     JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments
                     
                     error:&error];
    
    if (jsonObject != nil && error == nil){
        
        NSLog(@"反序列化成功...");
        
        if ([jsonObject isKindOfClass:[NSDictionary class]]){
            
            NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
            
            NSLog(@"反序列化后的dictionary数据 = %@", deserializedDictionary);
            
            return deserializedDictionary;
            
        }
        
        else if ([jsonObject isKindOfClass:[NSArray class]]){
            
            NSArray *deserializedArray = (NSArray *)jsonObject;
            
            NSLog(@"反序列化json后的数组 = %@", deserializedArray);
            
            return deserializedArray;
            
        }else {
            
            return nil;
            
        }
        
    }else{
        
        NSLog(@"%@", error);
        
        NSLog(@"反序列化时发生一个错误");
        
        return nil;
        
    }
    
}
@end
