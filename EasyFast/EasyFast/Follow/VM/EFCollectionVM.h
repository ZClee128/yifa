//
//  EFCollectionVM.h
//  EasyFast
//
//  Created by easyfast on 2020/8/6.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseRefreshVM.h"
#import "EFGoodsList.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFCollectionVM : EFBaseRefreshVM

@property (nonatomic,assign)NSInteger type;
@property (nonatomic,assign)NSInteger sortType;

+ (RACSignal *)setCollectGoods:(NSString *)goodsNo;

+ (RACSignal *)cancelCollectGoods:(NSString *)goodsNo;
@end

NS_ASSUME_NONNULL_END
