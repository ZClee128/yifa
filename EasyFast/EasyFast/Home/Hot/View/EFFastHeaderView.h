//
//  EFFastHeaderView.h
//  EasyFast
//
//  Created by easyfast on 2020/9/2.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EFFastHeaderView : UIView

@property (nonatomic,copy)void(^moreBlock)(void);
- (void)setModel:(id)model;
@end

NS_ASSUME_NONNULL_END
