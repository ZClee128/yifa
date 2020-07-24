//
//  EFTimeTableViewCell.h
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFTimeTableViewCell : BaseTableViewCell

@property (nonatomic,strong)QMUILabel *leftLab;
@property (nonatomic,strong)QMUILabel *rightLab;
@property (nonatomic,strong)QMUIButton *CopyBtn;
@property (nonatomic,copy)void(^copyBlock)(void);

- (void)hiddenCopy;

- (void)showCopy;
@end

NS_ASSUME_NONNULL_END
