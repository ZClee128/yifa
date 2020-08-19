//
//  EFH5DownLoadModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/19.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFH5DownLoadModel : EFBaseModel

/// H5加载地址
@property (nonatomic,strong)NSString *loadingUrl;
/// 下载地址
@property (nonatomic,strong)NSString *downloadUrl;
/// 是否下载，0：否；1：是
@property (nonatomic,assign)int isDownload;
/// H5版本号
@property (nonatomic,strong)NSString *versionNo;

@end

NS_ASSUME_NONNULL_END
