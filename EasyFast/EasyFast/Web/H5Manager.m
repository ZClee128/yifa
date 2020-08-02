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

#define fileName        @"EasyFast"
#define pathes   NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)
#define path       [pathes objectAtIndex:0]//大文件放在沙盒下的Library/Caches
#define finishPath [NSString stringWithFormat:@"%@/zipDownload/%@",path,fileName]//保存解压后文件的文件夹的路径
#define zipPath    [NSString stringWithFormat:@"%@/%@.zip",path,fileName]

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

- (void)deletFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:finishPath error:nil];
}

- (void)downloadZipWithUrl:(NSString *)zipurl
{
    NSURL    *url        = [NSURL URLWithString:zipurl];
    if (![self isExist])
    {//本地不存在文件 下载
        dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
        dispatch_async(queue, ^{
            NSError *error = nil;
            NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&error];
            if(!error)
            {
                [data writeToFile:zipPath options:0 error:nil];
                //解压zip文件
                if([SSZipArchive unzipFileAtPath:zipPath toDestination:finishPath])
                {
                    //解压完成 删除压缩包
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    [fileManager removeItemAtPath:zipPath error:nil];
                }
            }
        });
    }
}

- (NSString *)openIndex {
    NSString *zipName    = [[fileName lastPathComponent] stringByDeletingPathExtension];//获取下载链接里的文件名 即123sst文件夹
    NSString * webPath = [NSString stringWithFormat:@"%@/%@/index.html",finishPath,zipName];
    return webPath;
}

- (void)gotoUrl:(NSString *)url hasNav:(BOOL)show navTitle:(NSString *)title query:(id)query{
    EFBaseWebViewController *web = [[EFBaseWebViewController alloc] initWithUrl:url navTitle:title hasNav:show query:query];
    web.hidesBottomBarWhenPushed = YES;
    [[UIViewController getCurrentVC].navigationController qmui_pushViewController:web animated:YES completion:^{
        
    }];
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

@end
