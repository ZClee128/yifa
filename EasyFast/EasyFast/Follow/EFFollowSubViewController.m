//
//  EFFollowSubViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFollowSubViewController.h"
#import "EFFollowTableViewCell.h"
@interface EFFollowSubViewController ()

@property (nonatomic,assign)id type;

@end

@implementation EFFollowSubViewController

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
    self.gk_navLineHidden = YES;
    
    [self.EFTableView registerClass:[EFFollowTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFFollowTableViewCell class])];
}

- (UIView *)listView {
    return self.view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFFollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFFollowTableViewCell class])];
    [cell setModel:@""];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthOfScale(243);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return WidthOfScale(10);
}
@end
