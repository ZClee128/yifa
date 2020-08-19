//
//  EFAppUpdateModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/19.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFAppUpdateModel : EFBaseModel

/// APP版本号
@property (nonatomic,strong)NSString *appVersion;
/// 下载地址
@property (nonatomic,strong)NSString *downloadUrl;
/// 0 不更新 1更新 2强制更新
@property (nonatomic,assign)int isUpdate;
/// 更新内容
@property (nonatomic,strong)NSString *updateContext;
@end

NS_ASSUME_NONNULL_END
