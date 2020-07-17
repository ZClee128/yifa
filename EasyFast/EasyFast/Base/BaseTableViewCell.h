//
//  BaseTableViewCell.h
//  flag
//
//  Created by zclee on 2020/5/18.
//  Copyright © 2020 zclee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewCell : UITableViewCell

- (void)setUI;
- (void)setModel:(id)model;
@end

NS_ASSUME_NONNULL_END
