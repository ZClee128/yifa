//
//  EFGoodsList.h
//  EasyFast
//
//  Created by easyfast on 2020/8/6.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface EFTagsModel : EFBaseModel

/// 商品编码
@property (nonatomic,strong)NSString *ggNo;
/// 标签编码
@property (nonatomic,strong)NSString *ggtNo;
/// 标签的图标路径
@property (nonatomic,strong)NSString *icon;
/// 标签名称
@property (nonatomic,strong)NSString *title;
@end


@interface EFGoodsList : EFBaseModel

/// 商品编码
@property (nonatomic,strong)NSString *ggNo;
/// 商品起批量
@property (nonatomic,assign)NSInteger miniOrderLimit;
/// 商品拼团最低价
@property (nonatomic,assign)CGFloat price;
/// 商品销量
@property (nonatomic,assign)NSInteger sales;
/// 商品标签
@property (nonatomic,strong)NSArray<EFTagsModel *> *tags;
/// 商品名称
@property (nonatomic,strong)NSString *title;
/// 商品主图
@property (nonatomic,strong)NSString *url;
/// 是否收藏
@property (nonatomic,assign)BOOL isCollect;
@end

NS_ASSUME_NONNULL_END
