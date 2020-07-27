//
//  UITextField+Extension.h
//  ZLK
//
//  Created by it on 16/10/8.
//  Copyright © 2016年 zlgw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (MyExtension)

-(void)setLeftViewAtImageName:(NSString *)imageName;

-(void)setRightViewWithimageName:(NSString *)imageName click:(void(^)(QMUIButton *rightImageView))next;

-(void)setRightViewCloseWithimageName:(NSString *)imageName click:(void (^)(UIButton *rightImageView))next close:(void(^)(UIButton *closeBtn))closeBtn clickCloseBtn:(void(^)(void))compelect;

- (void)changTextWithNSString:(NSString *)text;

@end
