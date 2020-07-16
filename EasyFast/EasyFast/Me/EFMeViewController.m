//
//  MeViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/9.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFMeViewController.h"
#import "MeHeaderView.h"

@interface EFMeViewController ()

@property (nonatomic,strong)MeHeaderView *headerView;

@end

@implementation EFMeViewController

-(MeHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[MeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(236.5))];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT - TAB_BAR_HEIGHT);
    self.gk_navigationBar.hidden = YES;
    self.EFTableView.tableHeaderView = self.headerView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
