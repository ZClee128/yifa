//
//  TuanListTableViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuanListTableViewCell : BaseTableViewCell

@property (nonatomic,copy)void(^btnBlock)(void);

@end

NS_ASSUME_NONNULL_END
