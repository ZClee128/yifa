//
//  EFSetUpTableViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFSetUpTableViewCell : BaseTableViewCell


- (void)hiddenMore ;

- (void)showMore;

- (void)hiddenHeader ;

- (void)showHeader;

- (void)setHeaderImage:(NSString *)header;
@end

NS_ASSUME_NONNULL_END
