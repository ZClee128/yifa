//
//  EFCalendarCollectionViewCell.h
//  EasyFast
//
//  Created by easyfast on 2020/8/2.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFCalendarCollectionViewCell : UICollectionViewCell

- (void)setData:(CalendarModel *)model;
@end

NS_ASSUME_NONNULL_END
