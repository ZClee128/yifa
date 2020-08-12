//
//  EFClassDetailViewController.h
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFSearchResultViewController.h"
#import "EFClassifyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFClassDetailViewController : EFSearchResultViewController
- (instancetype)initWithModel:(EFClassifyModel *)model;
@end

NS_ASSUME_NONNULL_END
