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
#import "EFAddressVM.h"

@interface EFAddressViewController ()

@property (nonatomic,strong)QMUIButton *addBtn;
@property (nonatomic,assign) CGFloat  cellHeight;
@property (nonatomic,assign)AddressType addressType;
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

- (instancetype)initWithType:(AddressType )type
{
    self = [super init];
    if (self) {
        self.addressType = type;
    }
    return self;
}


- (void)viewDidLoad {
    self.viewModel = [[EFAddressVM alloc] init];
    [super viewDidLoad];
    self.gk_navTitle = @"收货地址";
    self.EFTableView.height = kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT - WidthOfScale(60) - TAB_SAFE_HEIGHT;
    [self.EFTableView registerClass:[EFAddressTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFAddressTableViewCell class])];
    [self.view addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-TAB_SAFE_HEIGHT));
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(WidthOfScale(60)));
        make.width.equalTo(@(kPHONE_WIDTH));
    }];
    [self addRefshUp];
    [self addRefshDown];
    [self loadList];
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kaddAddress object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self loadList];
    }];
}

- (void)loadList {
    @weakify(self);
    [[self.viewModel refreshForDown] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        [self.EFTableView.mj_header endRefreshing];
        self.EFData = x.first;
        [self.EFTableView reloadData];
    }];
}

- (void)loadNewData {
    [self loadList];
}

- (void)loadMoreData {
    @weakify(self);
    [[self.viewModel refreshForUp] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        [self.EFTableView.mj_footer endRefreshing];
        self.EFData = x.first;
        [self.EFTableView reloadData];
    }];
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return self.EFData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFAddressTableViewCell class]) forIndexPath:indexPath];
    EFAdsModel *model = self.EFData[indexPath.section];
    [cell setModel:model];
    self.cellHeight = [cell getCellHeight];
    @weakify(self);
    cell.deletBlcok = ^{
        [[EFAddressVM delAddress:model.uuaNo] subscribeNext:^(NSNumber *x) {
            @strongify(self);
            if ([x boolValue]) {
                [self loadList];
            }
        }];
    };
    
    cell.editBlock = ^{
        @strongify(self);
        EFEditAddressViewController *vc = [[EFEditAddressViewController alloc] initWithModel:model];
        [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
            
        }];
    };
    
    cell.defBlock = ^(QMUIButton * _Nonnull btn, QMUILabel * _Nonnull lab) {
        [[EFAddressVM setDefaultAddress:model.uuaNo] subscribeNext:^(NSNumber *x) {
            @strongify(self);
            if ([x boolValue]) {
                [self loadList];
            }
        }];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.addressType == AddressTypeWeb) {
        [self.navigationController qmui_popViewControllerAnimated:YES completion:^{
            
        }];
        if (self.chooseAddress) {
            self.chooseAddress(@"dddddd");
        }
    }
}
@end
