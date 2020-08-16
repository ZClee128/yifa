//
//  EFFastRegViewController.h
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFFastRegViewController : EFBaseTableViewController
@property (nonatomic,strong)QMUIButton *nextBtn;
@property (nonatomic,strong)NSString *phoneText;
@property (nonatomic,strong)NSString *codeStr;
- (void)nextClick;
@end


@interface EFFindPasswrodViewController : EFFastRegViewController

@end

NS_ASSUME_NONNULL_END
