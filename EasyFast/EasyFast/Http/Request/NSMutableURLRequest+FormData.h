//
//  NSMutableURLRequest+FormData.h
//  EasyFast
//
//  Created by easyfast on 2020/8/5.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableURLRequest (FormData)
-(void)setFormData:(NSDictionary *)formData;
@end

NS_ASSUME_NONNULL_END
