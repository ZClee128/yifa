//
//  EFFollowSubViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFollowSubViewController.h"
#import "EFFollowTableViewCell.h"
#import "EFFollowTuanTableViewCell.h"
#import "EFFollowVM.h"
@interface EFFollowSubViewController ()

@property (nonatomic,assign)Follow type;

@end

@implementation EFFollowSubViewController

- (instancetype)initWithType:(Follow)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    self.viewModel = [[EFFollowVM alloc] init];
    self.viewModel.branches = @(10);
    [super viewDidLoad];
    self.gk_navigationBar.hidden = YES;
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-30-TAB_BAR_HEIGHT);
    self.gk_navLineHidden = YES;
    
    [self.EFTableView registerClass:[EFFollowTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFFollowTableViewCell class])];
    [self.EFTableView registerClass:[EFFollowTuanTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFFollowTuanTableViewCell class])];
    [self addRefshDown];
    [self addRefshUp];
    switch (self.type) {
        case FollowGZ:
        {
            [self FollowLoad];
            break;
        }
        default:
            break;
    }
}

- (void)FollowLoad {
    [[self.viewModel refreshForDown] subscribeNext:^(RACTuple *x) {
        [self.EFTableView.mj_header endRefreshing];
        self.EFData = x.first;
    }];
}

- (void)loadNewData {
    switch (self.type) {
        case FollowGZ:
        {
            [self FollowLoad];
            break;
        }
        default:
            break;
    }
}

- (void)loadMoreData {
    switch (self.type) {
        case FollowGZ:
        {
            [[self.viewModel refreshForUp] subscribeNext:^(id  _Nullable x) {
                [self.EFTableView.mj_footer endRefreshing];
            }];
            break;
        }
        default:
            break;
    }
}

- (UIView *)listView {
    return self.view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.EFData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFFollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFFollowTableViewCell class])];
    cell.selectIndex = ^(NSInteger index) {
        [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(NO)}];
    };
    cell.headerSelect = ^{
        [kH5Manager gotoUrl:@"shop" hasNav:NO navTitle:@"" query:@{}];
    };
    switch (self.type) {
        case FollowGZ:
        {
            [cell setModel:self.EFData[indexPath.section]];
            return cell;
        }
            case FollowGM:
        {
            [cell setModel:@""];
            return cell;
        }
        default:
        {
            EFFollowTuanTableViewCell *tuanCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFFollowTuanTableViewCell class])];
            [tuanCell setModel:@""];
            tuanCell.headerSelect = ^{
                [kH5Manager gotoUrl:@"shop" hasNav:NO navTitle:@"" query:@{}];
            };
            tuanCell.pintuanBlock = ^{
                [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(NO)}];
            };
            return tuanCell;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.type) {
        case FollowTuan:
            return WidthOfScale(327);
        default:
            return WidthOfScale(243);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return WidthOfScale(10);
}
@end
