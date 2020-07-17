//
//  MeTabTableViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/17.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeTabTableViewCell : BaseTableViewCell

@property (nonatomic,copy)void(^seletBtn)(NSInteger index);
@property (nonatomic,copy)void(^moreBlock)(void);

- (void)setData:(NSArray *)btns title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
