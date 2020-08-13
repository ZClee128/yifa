//
//  EFTeamVM.h
//  EasyFast
//
//  Created by easyfast on 2020/8/13.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseRefreshVM.h"
#import "EFTeamListModel.h"
#import "EFTeamGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFTeamVM : EFBaseRefreshVM

@property (nonatomic,strong)NSString *ggNO;
@property (nonatomic,assign)NSInteger orderBy;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,assign)BOOL teamInfo;

+ (RACSignal *)goodsSummaryGGNo:(NSString *)ggNo;

+ (RACSignal *)teamInfo:(NSString *)ootNo;
@end

NS_ASSUME_NONNULL_END
