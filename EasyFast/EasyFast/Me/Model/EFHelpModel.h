//
//  EFHelpModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/12.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFHelpModel : EFBaseModel

/// 文本内容
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSDate *createDate;
/// 来源，1：APP；
@property (nonatomic,strong)NSString *source;
/// 编号
@property (nonatomic,strong)NSString *sshcNo;
/// 标题
@property (nonatomic,strong)NSString *title;
/// 链接地址
@property (nonatomic,strong)NSString *url;

@end

NS_ASSUME_NONNULL_END
