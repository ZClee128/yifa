//
//  EFSetUpViewController.h
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFSetUpViewController : EFBaseTableViewController

- (void)setBottomTile:(NSString *)title color:(UIColor *)color;
- (void)bottomClick;
@end

NS_ASSUME_NONNULL_END
