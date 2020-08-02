//
//  EFFastTableViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFFastTableViewCell : BaseTableViewCell

@property (nonatomic,copy)void(^selectIndex)(NSInteger index);
- (void)setCollectData:(NSMutableArray *)data;

@end

NS_ASSUME_NONNULL_END
