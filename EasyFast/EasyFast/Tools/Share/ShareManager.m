//
//  ShareManager.m
//  EasyFast
//
//  Created by easyfast on 2020/8/2.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "ShareManager.h"

@interface ShareManager()

@property (nonatomic,strong)NSString *shareTitle;
@property (nonatomic,strong)NSString *shareLink;
@property (nonatomic,strong)NSString *shareText;
@property (nonatomic,strong)NSString *shareImage;
@end


@implementation ShareManager


+ (instancetype)defaultManager {
    static ShareManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [ShareManager new];
    });
    return _sharedManager;
}

- (void)showShareViewWithTitle:(NSString *)title shareLink:(NSString *)shareLink sharetext:(NSString *)shareText shareImage:(NSString *)shareImage {
    self.shareLink = shareLink;
    self.shareTitle = title;
    self.shareText = shareText;
    self.shareImage = shareImage;
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
     [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
//         [self shareTextToPlatformType:platformType];
         if (platformType == UMSocialPlatformType_Sina) {
             [self shareImageAndTextToPlatformType:platformType];
         } else if (platformType == UMSocialPlatformType_WechatSession) {
             [self wxShareLink:WXSceneSession];
         } else if (platformType == UMSocialPlatformType_WechatTimeLine ){
             [self wxShareLink:WXSceneTimeline];
         }else {
            [self shareWebPageToPlatformType:platformType];
         }
    }];
}

- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

    //设置文本
    messageObject.text = [NSString stringWithFormat:@"%@ %@",self.shareText,self.shareLink];

    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"logo"];
    [shareObject setShareImage:self.shareImage];

    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[UIViewController getCurrentVC] completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.shareTitle descr:self.shareText thumImage:[UIImage imageNamed:@"logo"]];
    //设置网页地址
    shareObject.webpageUrl =self.shareLink;

    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[UIViewController getCurrentVC] completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (void)wxShareLink:(int)scene {
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = self.shareLink;
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.shareTitle;
    message.description = self.shareText;
    [message setThumbImage:[UIImage imageNamed:@"logo"]];
    message.mediaObject = webpageObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene; //WXSceneSession;
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
}
@end
