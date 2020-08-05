//
//  EFBindPhoneViewController.h
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFBindPhoneViewController : EFBaseTableViewController

@property (nonatomic,strong)NSString *codeStr;
@property (nonatomic,strong)QMUIButton *nextBtn;
- (void)setHeaderTitle:(NSString *)title;
- (void)seletNext;

@end


@interface EFCodeViewController : EFBindPhoneViewController

- (instancetype)initWithPhone:(NSString *)phone;
@end

NS_ASSUME_NONNULL_END
