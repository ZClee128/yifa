//
//  EFFollowSubViewController.h
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    FollowGZ, /// 关注
    FollowGM, /// 已购买
    FollowTuan, /// 团购
} Follow;

@interface EFFollowSubViewController : EFBaseTableViewController<JXCategoryListContentViewDelegate>

- (instancetype)initWithType:(Follow)type;
@end

NS_ASSUME_NONNULL_END
