//
//  EFFootPrint.h
//  EasyFast
//
//  Created by easyfast on 2020/8/10.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"
#import "EFGoodsList.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFFootPrint : EFBaseModel

@property (nonatomic,strong)NSArray<EFGoodsList *> *goodsList;
@property (nonatomic,strong)NSString *dateTime;

@end

NS_ASSUME_NONNULL_END
