//
//  EFMeDataViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFMeDataViewController.h"
#import "EFSetUpTableViewCell.h"
#import "EFOnePhoneViewController.h"
#import "BRAddressPickerView.h"
#import "MeVM.h"
#import "BRStringPickerView.h"
#import "EFWxLoginManager.h"
@interface EFMeDataViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UIView *otherView;
@property (nonatomic,strong)UIImage *headerImage;
@end

@implementation EFMeDataViewController

-(UIView *)otherView
{
    if (_otherView == nil) {
        _otherView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kPHONE_WIDTH, WidthOfScale(74))];
        UIImage *left = [UIImage imageWithColor:colorEFEFEF size:CGSizeMake(30, 1) cornerRadius:0];
        UIImage *right = [UIImage imageWithColor:colorEFEFEF size:CGSizeMake(30, 1) cornerRadius:0];
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:left];
        [_otherView addSubview:leftImageView];
        [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(WidthOfScale(107)));
            make.centerY.equalTo(_otherView);
        }];
        
        UIImageView *rightImageView = [[UIImageView alloc] initWithImage:right];
        [_otherView addSubview:rightImageView];
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-WidthOfScale(107)));
            make.centerY.equalTo(_otherView);
        }];
        
        QMUILabel *titleLab = [[QMUILabel alloc] init];
        titleLab.font = RegularFont14;
        titleLab.textColor = colorAEAEAE;
        titleLab.text = @"没有更多啦";
        [_otherView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_otherView);
            make.centerY.equalTo(_otherView);
            make.height.equalTo(@(WidthOfScale(13.5)));
        }];
    }
    return _otherView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"个人资料";
    [self.EFTableView registerClass:[EFSetUpTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFSetUpTableViewCell class])];
    
    self.EFData = [@[[@{@"title":@"头像",@"subTitle":@"",@"header":kUserManager.userModel.headImgUrl ? kUserManager.userModel.headImgUrl : @""} mutableCopy],
                     [@{@"title":@"昵称",@"subTitle":kUserManager.userModel.nickname,@"header":@""} mutableCopy],
                     [@{@"title":@"性别",@"subTitle":kUserManager.userModel.sex == 1 ? @"男" : (kUserManager.userModel.sex == 2 ? @"女" : @"不限"),@"header":@""} mutableCopy],
                     [@{@"title":@"地区",@"subTitle":kUserManager.userModel.city == nil ? @"请选择" :[NSString stringWithFormat:@"%@ %@",kUserManager.userModel.province,kUserManager.userModel.city],@"header":@""} mutableCopy],
                     @{@"title":@"绑定手机",@"subTitle":kUserManager.userModel.phone,@"header":@""},
                     [@{@"title":@"绑定微信号",@"subTitle":kUserManager.userModel.wxname == nil ? @"去绑定" : kUserManager.userModel.wxname,@"header":@""} mutableCopy],
                     //@{@"title":@"实名认证",@"subTitle":@"未认证",@"header":@""},
                     ] mutableCopy];
    self.EFTableView.tableFooterView = self.otherView;
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kwxLogin object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        [[EFWxLoginManager defaultManager] wxLogin:x withType:2];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kwxBing object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        self.EFData[5][@"subTitle"] = kUserManager.userModel.wxname;
        [self.EFTableView reloadData];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.EFData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFSetUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFSetUpTableViewCell class])];
    NSDictionary *dict = self.EFData[indexPath.row];
    [cell setModel:dict];
    indexPath.row == 0 ? [cell showHeader] : [cell hiddenHeader];
    indexPath.row == 4 ? [cell hiddenMore] : [cell showMore];
    if (indexPath.row == 0) {
        [cell setHeaderImage:dict[@"header"]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthOfScale(60);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            @weakify(self);
            [[ZLPhotoActionSheet zlPhotoWithCamera:self] subscribeNext:^(RACTuple * _Nullable x) {
                @strongify(self);
                if (x.first) {
                    [[MeVM uploadImage:1 image:x.first] subscribeNext:^(NSArray *x) {
                        if (x.count != 0) {
                            self.EFData[0][@"header"] = x[0][@"fileUrl"];
                            for (EFUserModel *model in [EFUserModel bg_findAll:nil]) {
                                if ([model.username isEqualToString:kUserManager.userModel.username]) {
                                    model.headImgUrl = x[0][@"fileUrl"];
                                    [model bg_saveOrUpdate];
                                }
                            }
                            [[NSNotificationCenter defaultCenter] postNotificationName:knickName object:nil];
                            [self.EFTableView reloadData];
                        }
                    }];
                }
            }];
        }
            break;
        case 1:
        {
            @weakify(self);
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入昵称" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField *userNameTextField = alertController.textFields.firstObject;
                [[MeVM updateUserInfo:@"" headImgUrl:@"" nickname:userNameTextField.text province:@"" sex:4 type:2] subscribeNext:^(NSNumber *x) {
                    if ([x boolValue]) {
                        @strongify(self)
                        for (EFUserModel *model in [EFUserModel bg_findAll:nil]) {
                            if ([model.username isEqualToString:kUserManager.userModel.username]) {
                                model.nickname = userNameTextField.text;
                                [model bg_saveOrUpdate];
                            }
                        }
                        [[NSNotificationCenter defaultCenter] postNotificationName:knickName object:nil];
                        self.EFData[1][@"subTitle"] = userNameTextField.text;
                        [self.EFTableView reloadData];
                    }
                }];
            }]];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField) {
                textField.placeholder=@"请输入昵称";
                textField.delegate = self;
            }];
            [self presentViewController:alertController animated:YES completion:nil];
            break;
        }
            case 2:
        {
            BRStringPickerView *sexPickerView = [[BRStringPickerView alloc] initWithPickerMode:(BRStringPickerComponentSingle)];
            sexPickerView.dataSourceArr = @[@"男",@"女",@"不限"];
            sexPickerView.resultModelBlock = ^(BRResultModel * _Nullable resultModel) {
                [[MeVM updateUserInfo:@"" headImgUrl:@"" nickname:@"" province:@"" sex:[resultModel.value isEqualToString:@"男"] ? 1 : ([resultModel.value isEqualToString:@"女"] ? 2 : 3) type:3] subscribeNext:^(NSNumber *x) {
                    if ([x boolValue]) {
                        self.EFData[2][@"subTitle"] = resultModel.value;
                        for (EFUserModel *model in [EFUserModel bg_findAll:nil]) {
                            if ([model.username isEqualToString:kUserManager.userModel.username]) {
                                model.sex = [resultModel.value isEqualToString:@"男"] ? 1 : ([resultModel.value isEqualToString:@"女"] ? 2 : 3);
                                [model bg_saveOrUpdate];
                            }
                        }
                        [[RACScheduler mainThreadScheduler] schedule:^{
                            [self.EFTableView reloadData];
                        }];
                    }
                }];
            };
            
            [sexPickerView show];
            break;
        }
            case 3:
        {
            /// 地址选择器
            @weakify(self);
            EFAddressPickerView *addressPickerView = [[EFAddressPickerView alloc]init];
            addressPickerView.pickerMode = BRAddressPickerModeCity;
            addressPickerView.title = @"请选择地区";
            addressPickerView.isAutoSelect = YES;
            addressPickerView.resultBlock = ^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                @strongify(self);
                [[MeVM updateUserInfo:city.name headImgUrl:@"" nickname:@"" province:province.name sex:4 type:4] subscribeNext:^(NSNumber *x) {
                    if ([x boolValue]) {
                        self.EFData[3][@"subTitle"] = [NSString stringWithFormat:@"%@ %@", province.name, city.name];
                        for (EFUserModel *model in [EFUserModel bg_findAll:nil]) {
                            if ([model.username isEqualToString:kUserManager.userModel.username]) {
                                model.city = city.name;
                                model.province = province.name;
                                [model bg_saveOrUpdate];
                            }
                        }
                        [[RACScheduler mainThreadScheduler] schedule:^{
                            [self.EFTableView reloadData];
                        }];
                    }
                }];
                [[RACScheduler mainThreadScheduler] schedule:^{
                    [self.EFTableView reloadData];
                }];
            };
            
            [addressPickerView show];
            break;
        }
            case 4:
        {
            if (!kUserManager.userModel.isPhone) {
                [EFOnePhoneLoginManager showBindPhone];
            }
            break;
        }
        case 5:{
            if (!kUserManager.userModel.isWeChat) {
                [[EFWxLoginManager defaultManager] sendAuthRequest];
            }
            break;
        }
        default:
            break;
    }
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSInteger strLength = textField.text.length - range.length + string.length;
    return (strLength <= 8);
}

@end
