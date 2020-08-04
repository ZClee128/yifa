//
//  EFAddressViewController.h
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFAddressViewController : EFBaseTableViewController

@property (nonatomic,copy)void(^chooseAddress)(NSString *str);

@end

NS_ASSUME_NONNULL_END
