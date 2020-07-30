//
//  EFChangeLoginViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFChangeLoginViewController.h"
#import "EFChangeLoginHeaderView.h"
#import "EFPhoneLoginTableViewCell.h"
#import "EFCodeLoginTableViewCell.h"
#import "LoginVM.h"
#import "EFOneBtnLoginTableViewCell.h"
#import "EFRegAndPswTableViewCell.h"
#import "EFThreeLoginTableViewCell.h"
#import "EFAccountPswTableViewCell.h"


@interface EFChangeLoginViewController ()

@property (nonatomic,assign)BOOL isAccount;

@end

@implementation EFChangeLoginViewController

- (void)viewDidLoad {
    self.viewModel = [[LoginVM alloc] init];
    [super viewDidLoad];
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT);
    self.EFTableView.backgroundColor = UIColor.whiteColor;
    self.gk_navigationBar.hidden = YES;
    
    EFChangeLoginHeaderView *header = [[EFChangeLoginHeaderView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(180))];
    @weakify(self);
    header.selectBlock = ^(NSInteger index) {
        @strongify(self);
        if (index == 0) {
            self.isAccount = NO;
        }else {
            self.isAccount = YES;
        }
        [self.EFTableView reloadData];
    };
    self.EFTableView.tableHeaderView = header;
    
    [self.EFTableView registerClass:[EFPhoneLoginTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFPhoneLoginTableViewCell class])];
    [self.EFTableView registerClass:[EFCodeLoginTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFCodeLoginTableViewCell class])];
    [self.EFTableView registerClass:[EFOneBtnLoginTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFOneBtnLoginTableViewCell class])];
    [self.EFTableView registerClass:[EFRegAndPswTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFRegAndPswTableViewCell class])];
    [self.EFTableView registerClass:[EFThreeLoginTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFThreeLoginTableViewCell class])];
    [self.EFTableView registerClass:[EFAccountPswTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFAccountPswTableViewCell class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            EFPhoneLoginTableViewCell *phoneCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFPhoneLoginTableViewCell class])];
            self.isAccount ? [phoneCell setModel:@"账号"] : [phoneCell setModel:@"手机号"];
            self.isAccount ? [phoneCell setPlaceholder:@"请输入易发账号"] : [phoneCell setPlaceholder:@"请输入手机号"];
            return phoneCell;
        }
        case 1:
        {
            if (self.isAccount) {
                EFAccountPswTableViewCell *accountCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFAccountPswTableViewCell class])];
                [accountCell setModel:@"密码"];
                [accountCell setPlaceholder:@"请输入密码"];
                return accountCell;
            }else {
                EFCodeLoginTableViewCell *codeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFCodeLoginTableViewCell class])];
                [codeCell setModel:@"验证码"];
                @weakify(self);
                codeCell.CodeBlock = ^(QMUIButton * _Nonnull btn) {
                    @strongify(self);
                    [(LoginVM *)self.viewModel getCodeWithBtn:btn];
                };
                return codeCell;
            }
        }
        case 2:
        {
            EFOneBtnLoginTableViewCell *btnCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOneBtnLoginTableViewCell class])];
            btnCell.loginBlock = ^{
                
            };
            return btnCell;
        }
        case 3:
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
            return WidthOfScale(64);
        case 1:
            return WidthOfScale(64);
        case 2:
            return WidthOfScale(131.5);
        case 3:
            return WidthOfScale(13);
        default:
            return WidthOfScale(208);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
@end