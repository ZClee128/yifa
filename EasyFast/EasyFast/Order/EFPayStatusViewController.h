//
//  EFPayStatusViewController.h
//  EasyFast
//
//  Created by easyfast on 2020/8/3.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseTableViewController.h"
#import "EFPayStatusModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFPayStatusViewController : EFBaseTableViewController

@property (nonatomic,strong)EFPayStatusModel *sModel;

- (instancetype)initWithsssNo:(NSString *)sssNo;
@end

NS_ASSUME_NONNULL_END
