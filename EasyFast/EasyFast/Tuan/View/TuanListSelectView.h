//
//  TuanListSelectView.h
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuanListSelectView : UIView

@property (nonatomic,copy)void(^leftBtnBlock)(NSInteger orderBy);
@property (nonatomic,copy)void(^rightBtnBlock)(NSInteger orderBy);

@end

NS_ASSUME_NONNULL_END
