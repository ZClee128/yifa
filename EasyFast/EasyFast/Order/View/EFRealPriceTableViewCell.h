//
//  EFRealPriceTableViewCell.h
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFRealPriceTableViewCell : BaseTableViewCell

@property (nonatomic,copy)void(^moreClick)(QMUIButton *x);

@end

NS_ASSUME_NONNULL_END
