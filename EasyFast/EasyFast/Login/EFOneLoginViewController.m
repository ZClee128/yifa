//
//  EFOneLoginViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOneLoginViewController.h"
#import "EFOneLoginLogoTableViewCell.h"
#import "EFOneLoginPhoneTableViewCell.h"
#import "EFRegAndPswTableViewCell.h"
#import "EFThreeLoginTableViewCell.h"
#import "EFChangeLoginViewController.h"
#import "EFOnePhoneLoginManager.h"

@interface EFOneLoginViewController ()

@end

@implementation EFOneLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT);
    self.EFTableView.backgroundColor = UIColor.whiteColor;
    self.gk_navigationBar.hidden = YES;
    [self.EFTableView registerClass:[EFOneLoginLogoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFOneLoginLogoTableViewCell class])];
    [self.EFTableView registerClass:[EFOneLoginPhoneTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFOneLoginPhoneTableViewCell class])];
    [self.EFTableView registerClass:[EFRegAndPswTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFRegAndPswTableViewCell class])];
    [self.EFTableView registerClass:[EFThreeLoginTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFThreeLoginTableViewCell class])];
    [EFOnePhoneLoginManager show];
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            EFOneLoginLogoTableViewCell *logo = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOneLoginLogoTableViewCell class])];
            return logo;
        }
            case 1:
        {
            EFOneLoginPhoneTableViewCell *phoneCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOneLoginPhoneTableViewCell class])];
            [phoneCell setModel:@""];
            @weakify(self);
            phoneCell.changeBlock = ^{
                @strongify(self);
                EFChangeLoginViewController *vc = [[EFChangeLoginViewController alloc] init];
                [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                    
                }];
            };
            return phoneCell;
        }
            case 2:
        {
            EFRegAndPswTableViewCell *regcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFRegAndPswTableViewCell class])];
            return regcell;
        }
        default:
        {
            EFThreeLoginTableViewCell *threecell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFThreeLoginTableViewCell class])];
            return threecell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return WidthOfScale(180);
            case 1:
            return WidthOfScale(266.5);
            case 2:
            return WidthOfScale(13);
        default:
            return WidthOfScale(208);
    }
}



@end
