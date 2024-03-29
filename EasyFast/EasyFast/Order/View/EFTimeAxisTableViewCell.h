//
//  EFTimeAxisTableViewCell.h
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFTimeAxisTableViewCell : BaseTableViewCell


- (void)hiddenTop;

- (void)showTop;

- (void)hiddenBottom;

- (void)showBottom;

- (void)setSelectImage ;

- (void)setNormalImage;

- (CGFloat)getCellHeight;

- (void)setBlack;

- (void)setNormal;
@end

NS_ASSUME_NONNULL_END
