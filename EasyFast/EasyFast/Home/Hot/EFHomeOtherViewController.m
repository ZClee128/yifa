//
//  EFHomeOtherViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFHomeOtherViewController.h"
#import "EFClassTabTableViewCell.h"
#import "EFGoodsTableViewCell.h"
#import "EFClassDetailViewController.h"


@interface EFHomeOtherViewController ()
@property (nonatomic,assign)id type;
@end

@implementation EFHomeOtherViewController

- (instancetype)initWithType:(id)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navigationBar.hidden = YES;
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-30-TAB_BAR_HEIGHT);
    [self.EFTableView registerClass:[EFClassTabTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFClassTabTableViewCell class])];
    [self.EFTableView registerClass:[EFGoodsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFGoodsTableViewCell class])];
}

- (UIView *)listView {
    return self.view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        default:
            return 20;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
         {
             EFClassTabTableViewCell *classCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFClassTabTableViewCell class])];
             [classCell setCollectData:[@[@1,@1,@1,@1,@1,@1,@1,@1] mutableCopy]];
             classCell.selectItem = ^(id  _Nonnull model) {
                 EFClassDetailViewController *VC = [[EFClassDetailViewController alloc] init];
                 VC.hidesBottomBarWhenPushed = YES;
                 [self.navigationController qmui_pushViewController:VC animated:YES completion:^{
                     
                 }];
             };
             return classCell;
          }
        default:
        {
            EFGoodsTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFGoodsTableViewCell class])];
            [goodsCell setModel:@""];
            return goodsCell;
        }
    }
}


- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return WidthOfScale(211.5);
        default:
            return WidthOfScale(155);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
@end
