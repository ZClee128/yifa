//
//  SysManager.m
//  EasyFast
//
//  Created by zclee on 2020/7/22.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "SysManager.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <CoreAudioTypes/AudioSessionTypes.h>
#import <Photos/Photos.h>

@implementation SysManager

+ (instancetype)defaultManager {
    static SysManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [SysManager new];
    });
    return _sharedManager;
}


// 0 手动授权 1 系统授权 2 成功
- (NSInteger)locationEnable {
    BOOL enable = [CLLocationManager locationServicesEnabled];
//    //是否具有定位权限
    int status = [CLLocationManager authorizationStatus];
//    if (status == 2) {
//    // 在这里做提示 去开启的操作
//        [self Alert:@"去授权定位权限"];
//    } else if(!enable || status<3){
//        //请求权限
//        [[[CLLocationManager alloc] init] requestWhenInUseAuthorization];
//    }
    if(enable && status == kCLAuthorizationStatusDenied) {
        return 0;
    }else if(!enable || status<3) {
        return 1;
    }else {
        return 2;
    }
}


- (BOOL)AVAudioEnable {
    AVAudioSessionRecordPermission permissionStatus = [[AVAudioSession sharedInstance] recordPermission];
    switch (permissionStatus) {
        case AVAudioSessionRecordPermissionUndetermined:{
            XYLog(@"第一次调用，是否允许麦克风弹框");
            return NO;
        }
        case AVAudioSessionRecordPermissionDenied:
            // 授权失败 在这里做提示，去设置操作
        {
            //                [self Alert:@"去授权麦克风"];
            return NO;
        }
        case AVAudioSessionRecordPermissionGranted:
            // 授权成功
            return YES;
        default:
            return  NO;
    }
    
    //    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
    //    if (granted) {
    //        // 第一次询问授权成功
    //    }
    //    else {
    //        // 第一次询问授权失败
    //    }
    //}];
}


- (BOOL)photoEnable {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if ((status == PHAuthorizationStatusRestricted) || (status == PHAuthorizationStatusDenied) || (status == PHAuthorizationStatusNotDetermined))
    {
        // 提示询问逻辑 在这里写
        //                [self Alert:@"去授权相册"];
        return NO;
    }else{
        return YES;
    }
}


- (BOOL)cameraEnable {
    //相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
        authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
    {
        // 无权限 引导去开启 操作 写这里
//        [self Alert:@"去授权相机"];
        return NO;
    }else {
        return YES;
    }
}

- (void)Alert:(NSString *)message {
    UIAlertController * alertVC  =  [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * goAction = [UIAlertAction actionWithTitle:@"去授权" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url];
        }
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:cancelAction];
    [alertVC addAction:goAction];
    [[UIViewController getCurrentVC] presentViewController:alertVC animated:true completion:nil];
}

@end
