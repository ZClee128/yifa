//
//  EFBridge.m
//  EasyFast
//
//  Created by easyfast on 2020/7/28.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBridge.h"
#import "TuanListViewController.h"
#import "EFConversationViewController.h"
#import "EFAddressViewController.h"
#import "EFOrderMoreDetailViewController.h"
#import "EFOrderSearchViewController.h"
#import "PayManager.h"
#import "EFOrderVM.h"
@interface EFBridge ()
@property (nonatomic,strong)WebViewJavascriptBridge *bridge;
@end

@implementation EFBridge

- (instancetype)initWithBridge:(WebViewJavascriptBridge *)bridge
{
    self = [super init];
    if (self) {
        self.bridge = bridge;
    }
    return self;
}

- (void)GetNavHeight {
    [self.bridge registerHandler:@"NavHeight" handler:^(id data, WVJBResponseCallback responseCallback) {
        XYLog(@"called with: %@", data);
        responseCallback(@{@"success":@(YES),@"data":@{@"height":@(STATUS_BAR_HEIGHT)}});
    }];
    
}

- (RACSignal *)getMeListHeight {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self.bridge registerHandler:@"clientHeight" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSDictionary *dict = [self identifyData:data];
            [subscriber sendNext:@([dict[@"height"] floatValue])];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

- (void)goback {
    [self.bridge registerHandler:@"goback" handler:^(id data, WVJBResponseCallback responseCallback) {
        [[UIViewController getCurrentVC].navigationController qmui_popViewControllerAnimated:YES completion:^{
            
        }];
    }];
}

- (void)share {
    [self.bridge registerHandler:@"share" handler:^(id data, WVJBResponseCallback responseCallback) {
        // shareLink  分享链接
        // shareTitle 分享标题
        // shareDescr 分享内容
        // shareImage 分享图片
        NSDictionary *dict = [self identifyData:data];
        [kShareManager showShareViewWithTitle:dict[@"shareTitle"] shareLink:dict[@"shareLink"] sharetext:dict[@"shareDescr"] shareImage:dict[@"shareImage"]];
    }];
}

- (void)goTo:(NSString *)page query:(id )query {
    NSMutableDictionary *dict = [query mutableCopy];
    if (kUserManager.userModel != nil) {
        [dict setValue:kUserManager.userModel.token forKey:@"token"];
    }
    [self.bridge callHandler:@"goTo" data:@{@"page":page,@"query":dict,} responseCallback:^(id responseData) {
        XYLog(@">>>>>>%@",responseData);
    }];
}

- (void)recomListClick {
    [self.bridge registerHandler:@"recomListClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *dict = [self identifyData:data];
        [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:dict];
    }];
}

- (void)goTuanList {
    @weakify(self);
    [self.bridge registerHandler:@"goTuanList" handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self);
        NSDictionary *dict = [self identifyData:data];
        TuanListViewController *vc = [[TuanListViewController alloc] initWithGGNo:dict[@"ggNo"]];
        [self push:vc];
    }];
}

- (void)IM {
    @weakify(self);
    [self.bridge registerHandler:@"IM" handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self);
        EFConversationViewController *vc = [[EFConversationViewController alloc] init];
        [self push:vc];
    }];
}


- (void)Pay {
    @weakify(self);
    [self.bridge registerHandler:@"Pay" handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self);
//        //item
        NSDictionary *dict = [self identifyData:data];
        kAppDelegate.isPay = YES;
        kAppDelegate.orderNum = dict[@"orderNum"];
        kAppDelegate.sssNo = dict[@"sssNo"];
        kAppDelegate.payMethod = [dict[@"payMethod"] intValue];
        [[PayManager defaultManager] showPay:[dict[@"payMethod"] intValue] == 1 ? wxPay : aliPay resp:dict[@"data"]];
    }];
}

- (void)TeamListPay {
     @weakify(self);
        [self.bridge registerHandler:@"TeamListPay" handler:^(id data, WVJBResponseCallback responseCallback) {
            @strongify(self);
    //        //item
            NSDictionary *dict = [self identifyData:data];
            kAppDelegate.isPay = YES;
            kAppDelegate.orderNum = dict[@"item"][@"orderNum"];
            kAppDelegate.sssNo = dict[@"item"][@"shopNo"];
            [[UIViewController getCurrentVC].view createAlertViewTitleArray:@[@"微信支付",@"支付宝支付"] arrayImage:@[@"wxpay",@"alipay"] textColor:tabbarBlackColor font:RegularFont14 spacing:5 topTitle:@"请选择支付方式" actionBlock:^(UIButton * _Nullable button, NSInteger didRow) {
                [[EFOrderVM payForOrder:kAppDelegate.orderNum payMethod:didRow == 0 ? 1 : 2] subscribeNext:^(id  _Nullable x) {
                    
                }];
            }];
        }];
}

- (void)ChooseAddress {
    @weakify(self);
    [self.bridge registerHandler:@"ChooseAddress" handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self);
        EFAddressViewController *vc = [[EFAddressViewController alloc] initWithType:(AddressTypeWeb)];
        vc.chooseAddress = ^(NSString * _Nonnull str) {
            responseCallback(@{@"uuaNo":str});
        };
        [self push:vc];
    }];
}

- (void)Camera{
    [self.bridge registerHandler:@"Camera" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *dict = [self identifyData:data];
        [[ZLPhotoActionSheet zlPhotos:[UIViewController getCurrentVC] maxCount:[dict[@"size"] isEqual:@"<null>"] ? 1 : [dict[@"size"] intValue]] subscribeNext:^(RACTuple * _Nullable x) {
            [MBProgressHUD showAlertProgress:@"正在上传"];
            [[[FMARCNetwork sharedInstance] uploadImage:[dict[@"type"] intValue] image:x.first] subscribeNext:^(FMHttpResonse *x) {
                [[RACScheduler mainThreadScheduler] schedule:^{
                    [MBProgressHUD removeProgressFromSuperView];
                }];
                responseCallback(x.reqResult);
            }];
        } error:^(NSError * _Nullable error) {
            responseCallback(@[]);
        }];
    }];
}

- (void)goOrderDetail {
    [self.bridge registerHandler:@"goOrderDetail" handler:^(id data, WVJBResponseCallback responseCallback) {
        EFOrderMoreDetailViewController *vc = [[EFOrderMoreDetailViewController alloc] init];
        [self push:vc];
    }];
}


- (void)goOrderList {
    [self.bridge registerHandler:@"goOrderList" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *dict = [self identifyData:data];
        EFOrderSearchViewController *vc = [[EFOrderSearchViewController alloc] initWithSearchTitle:dict[@"orderNum"]];
        [self push:vc];
    }];
}

- (void)evalWritingOver {
    [self.bridge registerHandler:@"evalWritingOver" handler:^(id data, WVJBResponseCallback responseCallback) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kevalWritingOver object:nil];
        [[UIViewController getCurrentVC].navigationController qmui_popViewControllerAnimated:YES completion:^{
            
        }];
    }];
}

- (void)returnApplyOver {
    [self.bridge registerHandler:@"returnApplyOver" handler:^(id data, WVJBResponseCallback responseCallback) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kreturnApplyOver object:nil];
        [[UIViewController getCurrentVC].navigationController qmui_popViewControllerAnimated:YES completion:^{
            
        }];
    }];
}

- (void)login {
    [self.bridge registerHandler:@"login" handler:^(id data, WVJBResponseCallback responseCallback) {
        [EFOnePhoneLoginManager show];
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kLoginNoti object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            if (kUserManager.userModel != nil) {
                responseCallback(@{@"token":kUserManager.userModel.token});
            }
        }];
    }];
}

- (void)tel {
    [self.bridge registerHandler:@"tel" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *dict = [self identifyData:data];
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",dict[@"tel"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];
}

- (void)push:(UIViewController *)vc {
    [[UIViewController getCurrentVC].navigationController qmui_pushViewController:vc animated:YES completion:^{
        
    }];
}

- (NSDictionary *)identifyData:(id)data{
    NSDictionary * dict = [[NSDictionary alloc] init];
    if ([data isKindOfClass:[NSString class]]) {
        NSString * str = (NSString *)data;
        NSData * jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError * error;
        dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    }else if ([data isKindOfClass:[NSDictionary class]]){
        dict = (NSDictionary*)data;
    }else{
//        [[SL_H5ParametersValidation alloc] alertViewtitle:@"请传入JSON对象，不支持字符串" Msg:data];
        XYLog(@"请传入JSON对象，不支持字符串>>>%@",data);
    }
    return dict;
}
@end
