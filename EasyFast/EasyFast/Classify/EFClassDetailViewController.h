//
//  EFClassDetailViewController.h
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseCollectionViewController.h"
#import "EFClassifyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFClassDetailViewController : EFBaseCollectionViewController
- (instancetype)initWithModel:(EFClassifyModel *)model;
@end

NS_ASSUME_NONNULL_END
