//
//  EFBindPhoneViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBindPhoneViewController.h"
#import "EFQPTableViewCell.h"
#import <QPDialCodePickerView/QPDialCodePickerView.h>
#import "EFPhoneTableViewCell.h"
#import "EFCodeTableViewCell.h"
#import "LoginVM.h"
#import "EFSafeAccountViewController.h"

@interface EFBindPhoneViewController ()

@property (nonatomic,strong)QMUILabel *header;
@property (nonatomic,strong)NSString *qpString;
@property (nonatomic,strong)NSString *phoneText;

@end

@implementation EFBindPhoneViewController

-(QMUILabel *)header
{
    if (_header == nil) {
        _header = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(37))];
        _header.font = RegularFont13;
        _header.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
        _header.contentEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(15), 0, 0);
    }
    return _header;
}

-(QMUIButton *)nextBtn
{
    if (_nextBtn == nil) {
        _nextBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_nextBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
        [_nextBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
        _nextBtn.titleLabel.font = MedFont15;
        @weakify(self);
        [[_nextBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self seletNext];
        }];
    }
    return _nextBtn;
}

- (void)seletNext {
    EFCodeViewController *vc = [[EFCodeViewController alloc] initWithPhone:self.phoneText];
    [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"换绑手机";
    self.qpString = @"中国大陆+86";
    [self.EFTableView registerClass:[EFQPTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFQPTableViewCell class])];
    [self.EFTableView registerClass:[EFPhoneTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFPhoneTableViewCell class])];
    
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
    [self setHeaderTitle:@"请输入你需要绑定的手机号码"];
}

- (void)setHeaderTitle:(NSString *)title {
    self.header.text = title;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            EFQPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFQPTableViewCell class])];
            [cell setModel:@[@"国家和地区",self.qpString]];
            return cell;
        }
        default:
        {
            EFPhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFPhoneTableViewCell class])];
            [cell setModel:@"新手机号"];
            @weakify(self);
            cell.TextValue = ^(NSString * _Nonnull text) {
                @strongify(self);
                self.phoneText = text;
            };
            
            
            RAC(self.nextBtn,userInteractionEnabled) =  [RACSignal combineLatest:@[[cell phoneSignal]] reduce:^id _Nonnull(NSString *phone){
                @strongify(self);
                BOOL enabled = phone.length == 11;
                
                if (!enabled) {
                    btnGradation(self.nextBtn,[colorF14745 colorWithAlphaComponent:0.6]);
                }else {
                    btnGradation(self.nextBtn,colorF14745);
                }
                return @(enabled);
            }];
            
            
            return cell;
        }
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthOfScale(50);
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return WidthOfScale(37);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        @weakify(self);
//        QPDialCodePickerView *pickerView = [[QPDialCodePickerView alloc] initWithAreaFormat:QPDialCodeAreaNameFormatCurrentLocale complete:^(QPDialCodeObject *item) {
//            @strongify(self);
//            self.qpString = [NSString stringWithFormat:@"%@+%@", item.area_name,item.dial_code];
//            [[RACScheduler mainThreadScheduler] schedule:^{
//                [self.EFTableView reloadRow:0 inSection:0 withRowAnimation:(UITableViewRowAnimationNone)];
//            }];
//        }];
//        pickerView.doneButtonColor = colorF14745;
//        pickerView.doneButtonTitle = @"确定";
//        [pickerView show];
//    }
}

@end



#pragma EFBindPhoneViewController



@interface EFCodeViewController ()

@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)RACSignal *codeSignal;
@end


@implementation EFCodeViewController

- (instancetype)initWithPhone:(NSString *)phone
{
    self = [super init];
    if (self) {
        self.phone = phone;
    }
    return self;
}

- (void)viewDidLoad {
    self.viewModel = [[LoginVM alloc] init];
    [super viewDidLoad];
    [self setHeaderTitle:[NSString stringWithFormat:@"请输入%@收到的短信验证码",self.phone]];
    [self.EFTableView registerClass:[EFCodeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFCodeTableViewCell class])];
}

- (void)seletNext {
    @weakify(self);
    if ([self.phone isEqualToString:kUserManager.userModel.phone]) {
        // 解绑
        [[LoginVM verifyMessage:self.codeStr phone:self.phone type:5] subscribeNext:^(NSNumber *x) {
            if ([x boolValue]) {
                [EFOnePhoneLoginManager showBindPhone];
            }
        }];
    }else {
        if (kAppDelegate.isOneBindPhone) {
            [[LoginVM thirdLoginBindingMessage:self.codeStr phone:self.phone] subscribeNext:^(NSNumber *x) {
                if ([x boolValue]) {
                    [JVERIFICATIONService dismissLoginControllerAnimated:YES completion:^{
                        
                    }];
                }
            }];
        }else {
            [[LoginVM bindingPhone:self.phone type:1 loginToken:@"" code:self.codeStr verifyToken:@"" oldPhone:kUserManager.userModel.phone] subscribeNext:^(NSNumber *x) {
                if ([x boolValue]) {
                    if (kAppDelegate.isOkOnePhone) {
                        [JVERIFICATIONService dismissLoginControllerAnimated:YES completion:^{
                            @strongify(self);
                            [self.navigationController qmui_popViewControllerAnimated:YES completion:^{
                                
                            }];
                        }];
                    }else{
                        @strongify(self);
                        for (UIViewController *vc in self.navigationController.viewControllers) {
                            if ([vc isKindOfClass:[EFSafeAccountViewController class]]) {
                                [self.navigationController qmui_popToViewController:vc animated:YES completion:^{
                                    
                                }];
                            }
                        }
                    }
                }
            }];
        }
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFCodeTableViewCell class])];
    [cell setModel:@"验证码"];
    @weakify(self);
    cell.TextValue = ^(NSString * _Nonnull text) {
        @strongify(self);
        self.codeStr = text;
    };
    cell.CodeBlock = ^(QMUIButton * _Nonnull btn) {
        @strongify(self);
        [(LoginVM *)self.viewModel getCodeWithBtn:btn withType:([self.phone isEqualToString:kUserManager.userModel.phone] && !kAppDelegate.isOneBindPhone) ? 5 : (kAppDelegate.isOneBindPhone ? 7 : 6)  phone:self.phone];
    };
    
        
    RAC(self.nextBtn,userInteractionEnabled) =  [RACSignal combineLatest:@[[cell codeSignal]] reduce:^id _Nonnull(NSString *phone){
        @strongify(self);
        BOOL enabled = phone.length == 6;
        
        if (!enabled) {
            btnGradation(self.nextBtn,[colorF14745 colorWithAlphaComponent:0.6]);
        }else {
            btnGradation(self.nextBtn,colorF14745);
        }
        return @(enabled);
    }];
    
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthOfScale(50);
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return WidthOfScale(37);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
