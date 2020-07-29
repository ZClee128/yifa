//
//  EFFollowTableViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFFollowTableViewCell : BaseTableViewCell

@property (nonatomic,strong)UICollectionView *collect;
@property (nonatomic,strong)NSMutableArray *data;

@property (nonatomic,strong)UIImageView *headerImageView;
@property (nonatomic,strong)QMUILabel *shopNameLab;
@property (nonatomic,strong)QMUILabel *shopClassLab;
@property (nonatomic,strong)QMUILabel *followLab;
@property (nonatomic,strong)QMUILabel *adressLab;
@property (nonatomic,strong)QMUIButton *followBtn;

@end

NS_ASSUME_NONNULL_END
