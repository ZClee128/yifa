//
//  EFFollowModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/6.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"
#import "EFGoodsList.h"
#import "EFTeamModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFFollowModel : EFBaseModel

@property (nonatomic,strong)NSString *city;
@property (nonatomic,assign)NSInteger followNum;
@property (nonatomic,assign)BOOL isFollow;
@property (nonatomic,strong)NSString *lookBackRate;
@property (nonatomic,strong)NSString *province;
@property (nonatomic,strong)NSString *shopIcon;
@property (nonatomic,strong)NSString *shopName;
@property (nonatomic,strong)NSString *shopNo;
@property (nonatomic,strong)NSArray *shopTagList;
@property (nonatomic,strong)NSArray<EFGoodsList *> *goodsList;
@property (nonatomic,strong)NSArray<EFTeamModel *> *teamList;
@end

NS_ASSUME_NONNULL_END
