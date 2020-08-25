//
//  EFAddAddressViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFAddAddressViewController.h"
#import <BRPickerView/BRPickerView.h>
#import "EFPhoneTableViewCell.h"
#import "EFMapViewController.h"
#import "EFAddressVM.h"

@interface EFAddAddressViewController ()

@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *detail;
@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)NSString *province;
@property (nonatomic,strong)NSString *area;
@property (nonatomic,strong)QMUIButton *nextBtn;

@end

@implementation EFAddAddressViewController

-(QMUIButton *)nextBtn
{
    if (_nextBtn == nil) {
        _nextBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_nextBtn setTitle:@"保存" forState:(UIControlStateNormal)];
        [_nextBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
        _nextBtn.titleLabel.font = MedFont15;
        @weakify(self);
        [[_nextBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self nextClick];
        }];
        _nextBtn.backgroundColor = colorF14745;
    }
    return _nextBtn;
}

- (void)nextClick {
    if (self.name == nil || [self.name isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入收货人"];
        return;
    }
    if (self.phone == nil || [self.phone isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    if (self.province == nil || [self.province isEqualToString:@""]) {
        [MBProgressHUD showError:@"请选择地区"];
        return;
    }
    if (self.detail == nil || [self.detail isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入详细地址"];
        return;
    }
    @weakify(self);
    [[EFAddressVM addAddress:self.detail city:self.city province:self.province recipientName:self.name recipientPhone:self.phone area:self.area] subscribeNext:^(NSNumber *x) {
        if ([x boolValue]) {
            @strongify(self);
            [[NSNotificationCenter defaultCenter] postNotificationName:kaddAddress object:nil];
            [self.navigationController qmui_popViewControllerAnimated:YES completion:^{
                
            }];
        }
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"添加收货地址";
    [self.EFTableView registerClass:[EFPhoneTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFPhoneTableViewCell class])];
    self.EFData = [@[@"收货人",@"手机号",@"地区",@"详细地址"] mutableCopy];
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(80))];
    [bg addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(30)));
        make.centerX.equalTo(bg);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(345), WidthOfScale(50)));
    }];
    [self.nextBtn layoutIfNeeded];
    [self.nextBtn ViewRadius:5];
    self.EFTableView.tableFooterView = bg;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.EFData.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFPhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFPhoneTableViewCell class])];
    [cell setModel:self.EFData[indexPath.row]];
    cell.phoneTextField.rightViewMode = UITextFieldViewModeAlways;
    cell.phoneTextField.maximumTextLength = NSUIntegerMax;
    switch (indexPath.row) {
        case 0:
        {
            cell.phoneTextField.placeholder = @"请输入收货人名字";
            cell.phoneTextField.rightView = nil;
            cell.phoneTextField.keyboardType = UIKeyboardTypeDefault;
            cell.phoneTextField.enabled = YES;
            cell.phoneTextField.text = self.name;
            @weakify(self);
            cell.TextValue = ^(NSString * _Nonnull text) {
                XYLog(@"%@",text);
                @strongify(self);
                self.name = text;
            };
            break;
        }
            case 1:
        {
            cell.phoneTextField.placeholder = @"请输入手机号";
            cell.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
            cell.phoneTextField.maximumTextLength = 11;
            cell.phoneTextField.rightView = nil;
            cell.phoneTextField.enabled = YES;
            cell.phoneTextField.text = self.phone;
            @weakify(self);
            cell.TextValue = ^(NSString * _Nonnull text) {
                XYLog(@"%@",text);
                @strongify(self);
                self.phone = text;
            };
            break;
        }
            case 2:
        {
            cell.phoneTextField.placeholder = @"请选择";
            cell.phoneTextField.rightView = [[UIImageView alloc] initWithImage:UIImageMake(@"more")];
            cell.phoneTextField.text = self.address;
            cell.phoneTextField.enabled = NO;
            break;
        }
        default:
        {
            cell.phoneTextField.placeholder = @"如街道，门牌号，小区等";
            cell.phoneTextField.rightView = [[UIImageView alloc] initWithImage:UIImageMake(@"dizhi")];
            cell.phoneTextField.enabled = YES;
            cell.phoneTextField.keyboardType = UIKeyboardTypeDefault;
            cell.phoneTextField.text = self.detail;
            @weakify(self);
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                @strongify(self);
                EFMapViewController *map = [[EFMapViewController alloc] init];
                [self.navigationController qmui_pushViewController:map animated:YES completion:^{
                    
                }];
                map.seletCity = ^(cityModel * _Nonnull model) {
                    cell.phoneTextField.text = [NSString stringWithFormat:@"%@%@",model.address,model.name];
                    self.detail = [NSString stringWithFormat:@"%@%@",model.address,model.name];
                };
            }];
            cell.phoneTextField.rightView.userInteractionEnabled = YES;
            [cell.phoneTextField.rightView addGestureRecognizer:tap];
            
            break;
        }
    }
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthOfScale(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 2:
        {
            /// 地址选择器
            EFAddressPickerView *addressPickerView = [[EFAddressPickerView alloc]init];
            addressPickerView.pickerMode = BRAddressPickerModeArea;
            addressPickerView.title = @"请选择地区";
            //addressPickerView.selectValues = @[@"浙江省", @"杭州市", @"西湖区"];
            addressPickerView.isAutoSelect = YES;
            @weakify(self);
            addressPickerView.resultBlock = ^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                NSLog(@"选择的值：%@", [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name]);
                @strongify(self);
                self.city = city.name;
                self.province = province.name;
                self.area = area.name;
                self.address = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
                [[RACScheduler mainThreadScheduler] schedule:^{
                    [self.EFTableView reloadData];
                }];
            };

            [addressPickerView show];
        }
            break;
        default:
            break;
    }
}
@end


@interface EFEditAddressViewController ()

@property (nonatomic,strong)EFAdsModel *adModel;
@end

@implementation EFEditAddressViewController

- (instancetype)initWithModel:(EFAdsModel *)model
{
    self = [super init];
    if (self) {
        self.phone = model.recipientPhone;
        self.name = model.recipientName;
        self.address = [NSString stringWithFormat:@"%@ %@ %@", model.province, model.city, model.area];
        self.province = model.province;
        self.city = model.city;
        self.area = model.area;
        self.detail = model.address;
        self.adModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"修改收货地址";
}


- (void)nextClick {
    if (self.name == nil || [self.name isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入收货人"];
        return;
    }
    if (self.phone == nil || [self.phone isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    if (self.province == nil || [self.province isEqualToString:@""]) {
        [MBProgressHUD showError:@"请选择地区"];
        return;
    }
    if (self.detail == nil || [self.detail isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入详细地址"];
        return;
    }
    @weakify(self);
    [[EFAddressVM updateAddress:self.detail city:self.city province:self.province recipientName:self.name recipientPhone:self.phone area:self.area addressNo:self.adModel.uuaNo] subscribeNext:^(NSNumber *x) {
        if ([x boolValue]) {
            @strongify(self);
            [[NSNotificationCenter defaultCenter] postNotificationName:kaddAddress object:nil];
            [self.navigationController qmui_popViewControllerAnimated:YES completion:^{
                
            }];
        }
    }];
}
@end
