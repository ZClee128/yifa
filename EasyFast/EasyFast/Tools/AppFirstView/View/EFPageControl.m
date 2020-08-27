//
//  EFPageControl.m
//  EasyFast
//
//  Created by easyfast on 2020/8/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFPageControl.h"

@implementation EFPageControl

- (instancetype)init{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void) setCurrentPage:(NSInteger)page {
    
    [super setCurrentPage:page];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        
        if (subviewIndex == page)
            
        {
            
            UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
            
            CGSize size;
            
            size.height = 10;
            
            size.width = 10;
            
            [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                         
                                         size.width,size.height)];
            [subview ViewRadius];
            
        }else {
            UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
            
            CGSize size;
            
            size.height = 10;
            
            size.width = 10;
            
            [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                         
                                         size.width,size.height)];
            [subview ViewRadius];
        }
    }
    
}

@end
