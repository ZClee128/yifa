//
//  EFRegAndPswTableViewCell.h
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFRegAndPswTableViewCell : BaseTableViewCell

@property (nonatomic,strong)void(^findBlock)(void);

@end

NS_ASSUME_NONNULL_END
