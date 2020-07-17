//
//  NSString+NSMutableAttributedString.h
//  EasyFast
//
//  Created by zclee on 2020/7/17.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (NSMutableAttributedString)

- (NSMutableAttributedString *)getAttributeWithChangeString:(NSString *)string ChangeFont:(UIFont *)changeFont textColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
