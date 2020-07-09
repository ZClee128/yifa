//
//  EFBaseTableView.m
//  flag
//
//  Created by zclee on 2020/5/18.
//  Copyright © 2020 zclee. All rights reserved.
//

#import "EFBaseTableView.h"

@implementation EFBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            self.estimatedRowHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            self.estimatedSectionFooterHeight = 0;
        }else {
            if (@available(iOS 13.0, *)) {
                self.automaticallyAdjustsScrollIndicatorInsets = NO;
            } else {
                // Fallback on earlier versions
            }
        }
    }
    return self;
}

+ (instancetype)defaultTableView:(id<QMUITableViewDelegate>)delegate dataSource:(id<QMUITableViewDataSource>)dataSource style:(UITableViewStyle)style
{
    EFBaseTableView *tableView = [[EFBaseTableView alloc] initWithFrame:CGRectMake(0.0, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, (kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT)) style:style];
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;
    tableView.backgroundColor = UIColor.whiteColor;
    return tableView;
}

@end
