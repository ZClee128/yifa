//
//  EFAddressViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFAddressViewController.h"
#import "EFAddressTableViewCell.h"
#import "EFAddAddressViewController.h"

@interface EFAddressViewController ()

@property (nonatomic,strong)QMUIButton *addBtn;
@property (nonatomic,assign) CGFloat  cellHeight;
@end

@implementation EFAddressViewController

-(QMUIButton *)addBtn
{
    if (_addBtn == nil) {
        _addBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_addBtn setTitle:@"添加收货地址" forState:(UIControlStateNormal)];
        [_addBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
        _addBtn.titleLabel.font = MedFont16;
        _addBtn.backgroundColor = colorF14745;
        @weakify(self);
        [[_addBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            EFAddAddressViewController *vc = [[EFAddAddressViewController alloc] init];
            [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                
            }];
        }];
    }
    return _addBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"收货地址";
    self.EFTableView.height = kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT - WidthOfScale(60) - TAB_SAFE_HEIGHT;
    [self.EFTableView registerClass:[EFAddressTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFAddressTableViewCell class])];
    [self.view addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(WidthOfScale(60)+TAB_SAFE_HEIGHT));
        make.width.equalTo(@(kPHONE_WIDTH));
    }];
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFAddressTableViewCell class]) forIndexPath:indexPath];
    [cell setModel:@""];
    self.cellHeight = [cell getCellHeight];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

@end
