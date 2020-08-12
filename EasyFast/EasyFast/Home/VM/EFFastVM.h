//
//  EFFastVM.h
//  EasyFast
//
//  Created by easyfast on 2020/8/12.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseRefreshVM.h"
#import "EFFastModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFFastVM : EFBaseRefreshVM
@property (nonatomic,strong)NSNumber *orderBy;
@property (nonatomic,strong)NSNumber *type;
@end

NS_ASSUME_NONNULL_END
