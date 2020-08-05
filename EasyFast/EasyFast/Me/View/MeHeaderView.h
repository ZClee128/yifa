//
//  MeHeaderView.h
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame headerBlcok:(void(^)(void))header setUpBlock:(void(^)(void))setup becomeBlock:(void(^)(void))become messageBlock:(void(^)(NSInteger index))message vipBlock:(void(^)(void))vip;
- (void)setData;
@end

NS_ASSUME_NONNULL_END
