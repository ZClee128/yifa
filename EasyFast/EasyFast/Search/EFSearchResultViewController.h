//
//  EFSearchResultViewController.h
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseCollectionViewController.h"
#import "EFGoodsList.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFSearchResultViewController : EFBaseCollectionViewController

@property (nonatomic,assign) BOOL isOne;
//@property (nonatomic,strong)UICollectionView *collect;
//@property (nonatomic,strong)NSMutableArray *data;
//@property (nonatomic,strong)UICollectionViewFlowLayout *flow;
- (UIView *)headerView;
- (void)setSearch;
- (void)loadList;
- (instancetype)initWithSearchTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
