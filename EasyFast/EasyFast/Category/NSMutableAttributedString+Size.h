//
//  NSMutableAttributedString+Size.h
//  EasyFast
//
//  Created by zclee on 2020/7/17.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (Size)

- (CGFloat)AttributedStringFont:(UIFont*)font maxHeight:(CGFloat)height;
@end

NS_ASSUME_NONNULL_END