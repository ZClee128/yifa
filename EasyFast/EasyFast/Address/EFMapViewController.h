//
//  EFMapViewController.h
//  EasyFast
//
//  Created by easyfast on 2020/7/30.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseViewController.h"
#import "cityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFMapViewController : EFBaseViewController

@property (nonatomic,copy)void(^seletCity)(cityModel *model);

@end

NS_ASSUME_NONNULL_END
