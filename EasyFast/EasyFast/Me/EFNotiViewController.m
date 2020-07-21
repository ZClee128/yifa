//
//  EFNotiViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFNotiViewController.h"
#import "NotiTableViewCell.h"
#import "EFSetUpTableViewCell.h"

@interface EFNotiViewController ()
@property (nonatomic,strong)QMUILabel *header;
@property (nonatomic,strong)QMUILabel *twoheader;
@property (nonatomic,strong)NSArray *titles;
@end

@implementation EFNotiViewController

-(QMUILabel *)header
{
    if (_header == nil) {
        _header = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(37))];
        _header.font = RegularFont13;
        _header.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
        _header.contentEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(15), 0, WidthOfScale(15));
        _header.text = @"消息通知";
    }
    return _header;
}

-(QMUILabel *)twoheader
{
    if (_twoheader == nil) {
        _twoheader = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(37))];
        _twoheader.font = RegularFont13;
        _twoheader.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
        _twoheader.contentEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(15), 0, WidthOfScale(15));
        _twoheader.text = @"系统消息设置";
    }
    return _twoheader;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"消息提醒设置";
    self.EFData = [@[@[@[@"新消息通知"],@{@"title":@"通知时段",@"subTitle":@"全天通知"}],@[@[@"声音"],@[@"振动"]]] mutableCopy];
    [self.EFTableView registerClass:[EFSetUpTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFSetUpTableViewCell class])];
    [self.EFTableView registerClass:[NotiTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NotiTableViewCell class])];
    self.titles = @[@"00.00-07.00",@"07.00-12.00",@"12.00-23.59"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [self.EFData[0] count];
        default:
            return [self.EFData[1] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    NotiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NotiTableViewCell class])];
                    [cell setModel:self.EFData[0][indexPath.row]];
                    return cell;
                }
                default:
                {
                    EFSetUpTableViewCell *setUpCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFSetUpTableViewCell class])];
                    [setUpCell setModel:self.EFData[0][indexPath.row]];
                    return setUpCell;
                }
            }
        }
        default:
        {
            NotiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NotiTableViewCell class])];
            [cell setModel:self.EFData[1][indexPath.row]];
            return cell;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return self.header;
        }
        default:
        {
            return self.twoheader;
        }
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return WidthOfScale(37);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthOfScale(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        @weakify(self);
        [[self.view createAlertViewTitleArray:self.titles textColor:tabbarBlackColor font:RegularFont15] subscribeNext:^(NSNumber *x) {
            @strongify(self);
            self.EFData = [@[@[@[@"新消息通知"],@{@"title":@"通知时段",@"subTitle":self.titles[[x intValue]]}],@[@[@"声音"],@[@"振动"]]] mutableCopy];
            [self.EFTableView reloadRow:1 inSection:0 withRowAnimation:(UITableViewRowAnimationNone)];
        }];
    }
}

@end
