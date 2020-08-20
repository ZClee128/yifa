//
//  EFWxLoginManager.m
//  EasyFast
//
//  Created by easyfast on 2020/8/14.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFWxLoginManager.h"
#import "EFWXModel.h"
#import "LoginVM.h"
#define WX_OPEN_ID @"WX_OPEN_ID"
#define WX_ACCESS_TOKEN @"WX_ACCESS_TOKEN"
#define WX_REFRESH_TOKEN @"WX_REFRESH_TOKEN"

@interface EFWxLoginManager ()

@property (nonatomic,assign)NSInteger type;

@end


@implementation EFWxLoginManager

+ (instancetype)defaultManager {
    static EFWxLoginManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [EFWxLoginManager new];
    });
    return _sharedManager;
}


- (void)wxLogin:(NSNotification*)noti withType:(NSInteger)type{
    self.type = type;
    //获取到code
    SendAuthResp *resp = noti.object;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=%@",kwxappId,kwxappSecret,resp.code,@"authorization_code"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSMutableSet *mgrSet = [NSMutableSet set];
    mgrSet.set = manager.responseSerializer.acceptableContentTypes;
    [mgrSet addObject:@"text/html"];
    //因为微信返回的参数是text/plain 必须加上 会进入fail方法
    [mgrSet addObject:@"text/plain"];
    [mgrSet addObject:@"application/json"];
    manager.responseSerializer.acceptableContentTypes = mgrSet;
    
    [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success");
        NSDictionary *resp = (NSDictionary*)responseObject;
        NSString *openid = resp[@"openid"];
//        NSString *unionid = resp[@"unionid"];
        NSString *accessToken = resp[@"access_token"];
        NSString *refreshToken = resp[@"refresh_token"];
        if(accessToken && ![accessToken isEqualToString:@""] && openid && ![openid isEqualToString:@""]){
            [[NSUserDefaults standardUserDefaults] setObject:openid forKey:WX_OPEN_ID];
            [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:WX_ACCESS_TOKEN];
            [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:WX_REFRESH_TOKEN];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [self getUserInfo];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)getUserInfo{
    //获取个人信息
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",[[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN],[[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID]];
    
    NSMutableSet *mgrSet = [NSMutableSet set];
    mgrSet.set = manager.responseSerializer.acceptableContentTypes;
    [mgrSet addObject:@"text/html"];
    //因为微信返回的参数是text/plain 必须加上 会进入fail方法
    [mgrSet addObject:@"text/plain"];
    [mgrSet addObject:@"application/json"];
    manager.responseSerializer.acceptableContentTypes = mgrSet;
    
    [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success");
        
        XYLog(@"%@",responseObject);
        NSDictionary *resp = (NSDictionary*)responseObject;
        if (resp[@"errcode"] == nil) {
            EFWXModel *model = [EFWXModel modelWithJSON:resp];
            if (self.type == 1) {
                [[LoginVM thirdLoginType:1 city:model.city ? model.city : @"" province:model.province ? model.province : @"" headImgUrl:model.headimgurl nickname:model.nickname openid:model.openid sex:model.sex uid:model.unionid ? model.unionid : @"" unionid:model.unionid ? model.unionid : @""] subscribeNext:^(id  _Nullable x) {
                    
                }];
            }else {
                [[LoginVM bindingWechatType:1 city:model.city ? model.city : @"" province:model.province ? model.province : @"" headImgUrl:model.headimgurl nickname:model.nickname openid:model.openid sex:model.sex uid:model.openid unionid:model.unionid ? model.unionid : @""] subscribeNext:^(id  _Nullable x) {
                    
                }];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)sendAuthRequest
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo";
    req.state = @"YF_wechat_Login";
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req completion:^(BOOL success) {

    }];
    
}
@end
