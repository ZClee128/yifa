//
//  MeWebTableViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/17.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeWebTableViewCell : BaseTableViewCell<WKUIDelegate,WKNavigationDelegate>

- (RACSignal *)getCellHeight;
@end

NS_ASSUME_NONNULL_END
