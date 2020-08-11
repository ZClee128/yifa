//
//  EFClassifyModel.h
//  EasyFast
//
//  Created by zclee on 2020/7/22.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFClassifyModel : EFBaseModel

/// 分类代码
@property (nonatomic, strong) NSString *code;
/// 分类创建时间
@property (nonatomic, strong) NSDate *createDate;
/// APP端分类编码
@property (nonatomic, strong) NSString *ggcNo;
/// 商家端分类代码
@property (nonatomic, strong) NSString *ggcsCode;
/// 图标
@property (nonatomic, strong) NSString *icon;
/// 分类级别，1：一级分类，2：二级分类...
@property (nonatomic, strong) NSString *level;
/// 分类名称
@property (nonatomic, strong) NSString *title;
/// 更新时间
@property (nonatomic, strong) NSDate *updateDate;

@property (nonatomic, strong) NSString *pcode;
/// 下级分类数组
@property (nonatomic, strong) NSArray<EFClassifyModel *> *children;


@end

NS_ASSUME_NONNULL_END
