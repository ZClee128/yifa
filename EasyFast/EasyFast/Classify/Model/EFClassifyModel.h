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

@property (nonatomic, strong) NSString *idField;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *indexs;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *showUrl;
@property (nonatomic, strong) NSString *productUrl;
@property (nonatomic, strong) NSArray<EFClassifyModel *> *childrenList;

@end

NS_ASSUME_NONNULL_END
