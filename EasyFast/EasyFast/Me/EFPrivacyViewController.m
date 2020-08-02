//
//  EFPrivacyViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFPrivacyViewController.h"
#import "EFSetUpTableViewCell.h"
#import "EFPowerViewController.h"

@interface EFPrivacyViewController ()


@end

@implementation EFPrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"隐私";
    self.EFData = [@[@{@"title":@"系统权限",@"subTitle":@"授权使用手机权限"},@{@"title":@"隐私政策",@"subTitle":@""}] mutableCopy];
    [self setBottomTile:@"联系客服" color:RGB16(0x499AFF)];
}

- (void)bottomClick {
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.EFData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFSetUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFSetUpTableViewCell class]) forIndexPath:indexPath];
    NSDictionary *dict = self.EFData[indexPath.row];
    [cell setModel:dict];
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            EFPowerViewController *power = [[EFPowerViewController alloc] init];
            [self.navigationController qmui_pushViewController:power animated:YES completion:^{
                
            }];
            break;
        }
        default:
        {
            [kH5Manager gotoUrl:@"policy" hasNav:YES navTitle:@"隐私政策"];
        }
            break;
    }
}
@end
