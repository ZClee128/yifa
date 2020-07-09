//
//  EFBaseTableViewController.h
//  flag
//
//  Created by zclee on 2020/5/18.
//  Copyright © 2020 zclee. All rights reserved.
//

#import "EFBaseViewController.h"
#import "EFBaseTableView.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFBaseTableViewController : EFBaseViewController<QMUITableViewDataSource,QMUITableViewDelegate>


@property (nonatomic,strong)EFBaseTableView *EFTableView;
@property (nonatomic,strong)NSMutableArray *EFData;
@property (nonatomic,assign)UITableViewStyle tableViewStyle;
@property (nonatomic,assign) BOOL  lineHidden;
- (void)addRefshDown;
- (void)loadNewData;
- (void)addRefshUp;
- (void)loadMoreData;
@end

NS_ASSUME_NONNULL_END
