//
//  EFBaseModel.m
//  EasyFast
//
//  Created by zclee on 2020/7/17.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

@implementation EFBaseModel

- (NSString *)description{
    unsigned int count;
    const char *clasName    = object_getClassName(self);
    NSMutableString *string = [NSMutableString stringWithFormat:@"<%s: %p>:[ \n",clasName, self];
    Class clas              = NSClassFromString([NSString stringWithCString:clasName encoding:NSUTF8StringEncoding]);
    Ivar *ivars             = class_copyIvarList(clas, &count);
    
    for (int i = 0; i < count; i++) {
        
        @autoreleasepool {
            
            Ivar       ivar  = ivars[i];
            const char *name = ivar_getName(ivar);
            
            //得到类型
            NSString *type   = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
            NSString *key    = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id       value   = [self valueForKey:key];
            
            //确保BOOL值输出的是YES 或 NO
            if ([type isEqualToString:@"B"]) {
                value = (value == 0 ? @"NO" : @"YES");
            }
            
            [string appendFormat:@"\t%@: %@\n",[self deleteUnderLine:key], value];
        }
    }
    
    [string appendFormat:@"]"];
    
    return string;
}

/// 去掉下划线
- (NSString *)deleteUnderLine:(NSString *)string{
    
    if ([string hasPrefix:@"_"]) {
        return [string substringFromIndex:1];
    }
    return string;
}

// 当 JSON 转为 Model 完成后，该方法会被调用。
// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    //处理字符串为null 改为@""，并处理时间字符串
    for (NSDictionary * key in [self bk_properties_string]) {
        if ([self valueForKey:key[@"key"]]==nil) {
            // NSLog(@"-----------------");
            if ([key[@"isStr"] boolValue]) {
                [self setValue:@"" forKey:key[@"key"]];
            }else{
                [self setValue:@[] forKey:key[@"key"]];
            }
        }
    }
        XYLog(@"dic ==> %@",self);
    return YES;
}

//返回类型为NSString的成员变量
-(NSArray *)bk_properties_string{
    // 获取所有的成员变量
    unsigned int count = 0;// 记录属性个数
    Ivar * varList = class_copyIvarList([self class], &count);
    // 遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i<count; ++i) {
        Ivar ivar = varList[i];
        NSString *ivarname = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if ([ivarname hasPrefix:@"_"]) {
            //把 _ 去掉，读取后面的
            ivarname = [ivarname substringFromIndex:1];
        }
        //2.获取成员变量类型
        NSString * ivartype = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        //把包含 @\" 的去掉，如 "@\"nsstring\"";-="">
        NSString * ivarType = [ivartype stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"@\""]];
        
        //        NSLog(@"ivarType=%@,ivarname=%@",[self typeWithIvarType:ivarType],ivarname);
        //3.获取类型为NSString的成员变量，加到数组进行返回
        if ([[self typeWithIvarType:ivarType] isEqualToString:@"NSString"]) {
            [mArray addObject:@{@"key":ivarname,@"isStr":@(YES)}];
        }else if ([[self typeWithIvarType:ivarType] isEqualToString:@"NSArray"]) {
            [mArray addObject:@{@"key":ivarname,@"isStr":@(NO)}];
        }
    }
    return mArray;
}

//数据类型判断
-(NSString*)typeWithIvarType:(NSString*)ivarType{
    NSString * typeString = @"";
    if(![ivarType isKindOfClass:[NSString class]]){
        return typeString;
    }
    if([ivarType isEqualToString:@"i"]){
        typeString = @"int";
    }else if([ivarType isEqualToString:@"f"]){
        typeString = @"float";
    }else if([ivarType isEqualToString:@"d"]){
        typeString = @"double|CGFloat";
    }else if([ivarType isEqualToString:@"q"]){
        typeString = @"NSInteger";
    }else if([ivarType isEqualToString:@"B"]){
        typeString = @"BOOL";
    }else{
        typeString = ivarType;
    }
//    XYLog(@">>>>>>%@,%@",typeString,ivarType);
    return typeString;
    
}

@end
