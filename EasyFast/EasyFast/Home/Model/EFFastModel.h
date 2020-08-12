//
//  EFFastModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/12.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFFastModel : EFBaseModel

/// 商品编码
@property (nonatomic,strong)NSString *ggNo;
/// 拼团价
@property (nonatomic,assign)CGFloat groupPrice;
/// 拼团编码
@property (nonatomic,strong)NSString *ootNo;
/// 拼团进度
@property (nonatomic,assign)CGFloat teamProcess;
/// 商品名称
@property (nonatomic,strong)NSString *title;
/// 图片地址
@property (nonatomic,strong)NSString *url;
@end

NS_ASSUME_NONNULL_END
