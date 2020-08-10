//
//  EFAddAddressViewController.h
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseTableViewController.h"
#import "EFAdsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFAddAddressViewController : EFBaseTableViewController
- (void)nextClick;

@end


@interface EFEditAddressViewController : EFAddAddressViewController

- (instancetype)initWithModel:(EFAdsModel *)model;
@end

NS_ASSUME_NONNULL_END
