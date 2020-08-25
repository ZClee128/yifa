//
//  H5Manager.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "H5Manager.h"
#import <ZipArchive.h>
#import <CommonCrypto/CommonCrypto.h>
#import "EFBaseWebViewController.h"
#import "QDNetServerDownLoadTool.h"

#define fileName        @"EasyFast"
#define pathes   NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)
#define path       [pathes objectAtIndex:0]//大文件放在沙盒下的Library/Caches
#define finishPath [NSString stringWithFormat:@"%@/zipDownload/%@",path,fileName]//保存解压后文件的文件夹的路径
#define zipPath    [NSString stringWithFormat:@"%@/%@.zip",path,fileName]
#define tmpFilePath [NSTemporaryDirectory() stringByAppendingPathComponent:@"dist"]  //临时文件

@implementation H5Manager


+ (instancetype)defaultManager {
    static H5Manager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [H5Manager new];
    });
    return _sharedManager;
}


- (BOOL)isExist {
    
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:finishPath];
    return isExist;
}

- (BOOL)isTmpExist {
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:tmpFilePath];
    return isExist;
}

- (void)deletFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:finishPath error:nil];
}

- (void)downloadZipWithUrl:(NSString *)zipurl
{
   [[QDNetServerDownLoadTool sharedTool]AFDownLoadFileWithUrl:zipurl progress:^(CGFloat progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
       XYLog(@"进度》>>>>>>%f",progress);
    } fileLocalUrl:[NSURL fileURLWithPath:zipPath] success:^(NSURL *fileUrlPath, NSURLResponse *response) {
        XYLog(@"下载成功 下载的文档路径是 %@,%@ ",fileUrlPath,response);
        NSFileManager *fileManager = [NSFileManager defaultManager];
//        解压
        BOOL success = [SSZipArchive unzipFileAtPath:zipPath toDestination:finishPath];
        if (!success) {
            XYLog(@"pkgfile: unzip file error");
            [fileManager removeItemAtPath:zipPath error:nil];
            [fileManager removeItemAtPath:finishPath error:nil];
            return;
        }
        //清除临时文件和目录
        [fileManager removeItemAtPath:zipPath error:nil];
        [self migrateDistToTempory];
    } failure:^(NSError *error, NSInteger statusCode) {
        XYLog(@"下载失败,下载的data被downLoad工具处理了 ");
        
    }];
}


- (NSString *)openIndex {
    //    NSString *zipName    = [[fileName lastPathComponent] stringByDeletingPathExtension];//获取下载链接里的文件名 即123sst文件夹
    // 获取Caches目录路径
    //    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //    NSString * webPath = [NSString stringWithFormat:@"%@/zipDownload/%@/dist/index.html",cachesDir,fileName];
    //    NSString *webPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"dist"];
    //    XYLog(@"%@",webPath);
    return [NSString stringWithFormat:@"%@/index.html",tmpFilePath];
}

- (void)gotoUrl:(NSString *)url hasNav:(BOOL)show navTitle:(NSString *)title query:(id)query{
    EFBaseWebViewController *web = [[EFBaseWebViewController alloc] initWithUrl:url navTitle:title hasNav:show query:query];
    web.hidesBottomBarWhenPushed = YES;
    [[UIViewController getCurrentVC].navigationController qmui_pushViewController:web animated:YES completion:^{
        
    }];
}

- (void)gotoUrl:(NSString *)url hasNav:(BOOL)show navTitle:(NSString *)title query:(id)query completion:(void (^)(void))completion{
    EFBaseWebViewController *web = [[EFBaseWebViewController alloc] initWithUrl:url navTitle:title hasNav:show query:query];
    web.hidesBottomBarWhenPushed = YES;
    [[UIViewController getCurrentVC].navigationController qmui_pushViewController:web animated:[url isEqualToString:@"myGroup"] ? NO : YES completion:completion];
}

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr,(CC_LONG)strlen(cStr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

- (EFH5DownLoadModel *)getModel {
    if ([EFH5DownLoadModel bg_findAll:nil]) {
        EFH5DownLoadModel *model = [EFH5DownLoadModel bg_findAll:nil][0];
        return model;
    }
    return nil;
}

- (void)migrateDistToTempory {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *cacheFilePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"zipDownload/EasyFast/dist"];
    // 先删除tempory已有的dist资源
    [fm removeItemAtPath:tmpFilePath error:nil];
    NSError *saveError;
    // 从caches拷贝dist到tempory临时文件夹
    [[NSFileManager defaultManager] copyItemAtURL:[NSURL fileURLWithPath:cacheFilePath] toURL:[NSURL fileURLWithPath:tmpFilePath] error:&saveError];
    XYLog(@"%@",saveError);
}

@end
