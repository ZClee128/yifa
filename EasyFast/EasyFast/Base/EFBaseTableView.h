//
//  EFBaseTableView.h
//  flag
//
//  Created by zclee on 2020/5/18.
//  Copyright © 2020 zclee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EFBaseTableView : UITableView

@property (nonatomic,assign)BOOL isOpenHit;

+ (instancetype)defaultTableView:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource style:(UITableViewStyle)style;

@end

NS_ASSUME_NONNULL_END
