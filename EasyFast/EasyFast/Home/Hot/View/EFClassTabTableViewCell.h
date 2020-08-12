//
//  EFClassTabTableViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "EFClassifyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFClassTabTableViewCell : BaseTableViewCell

@property (nonatomic,copy)void(^selectItem)(EFClassifyModel *model);

- (void)setCollectData:(NSMutableArray *)data;
@end

NS_ASSUME_NONNULL_END
