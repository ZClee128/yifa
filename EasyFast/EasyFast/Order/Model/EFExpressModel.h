//
//  EFExpressModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/10.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFExpressModel : EFBaseModel
/// 内容
@property (nonatomic,strong)NSString *context;
/// 时间
@property (nonatomic,strong)NSString *create;
/// 快递状态
@property (nonatomic,strong)NSString *state;

@end

NS_ASSUME_NONNULL_END
