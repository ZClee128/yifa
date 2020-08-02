//
//  ZLPhotoActionSheet+RACSignal.m
//  XQC
//
//  Created by anmin on 2019/4/18.
//  Copyright © 2019 xqc. All rights reserved.
//

#import "ZLPhotoActionSheet+RACSignal.h"

static ZLPhotoActionSheet *zlPhoto = nil;

@implementation ZLPhotoActionSheet (RACSignal)

+ (ZLPhotoActionSheet *)zlPhotoActionSheet
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zlPhoto = [[ZLPhotoActionSheet alloc] init];
        zlPhoto.configuration.allowSelectVideo = NO;
        zlPhoto.configuration.allowSelectGif = NO;
    });
    return zlPhoto;
}

+ (RACSignal<RACTuple *> *)zlPhotos:(UIViewController *)presentViewController
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [[ZLPhotoActionSheet zlPhotoActionSheet] showPhotoLibraryWithSender:presentViewController];
        [ZLPhotoActionSheet zlPhotoActionSheet].selectImageBlock = ^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            [subscriber sendNext:RACTuplePack(images, assets, @(isOriginal))];
            [subscriber sendCompleted];
        };
        [ZLPhotoActionSheet zlPhotoActionSheet].cancleBlock = ^{
            [subscriber sendCompleted];
        };
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release cool signal methods “+ zlPhotos:” in %@ class", self.class);
        }];
    }];
}

+ (RACSignal<RACTuple *> *)zlPhoto:(UIViewController *)presentViewController
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [ZLPhotoActionSheet zlPhotoActionSheet].configuration.maxSelectCount = 1;
        [ZLPhotoActionSheet zlPhotoActionSheet].configuration.allowTakePhotoInLibrary = NO;
        [[[self.class zlPhotos:presentViewController] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple * _Nullable x) {
            UIImage *image = [(NSArray<UIImage *> *)x.first firstObject];
            [subscriber sendNext:RACTuplePack(image, [(NSArray<PHAsset *> *)x.second firstObject], x.third)];
        } completed:^{
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
        NSLog(@"release cool signal methods “+ zlPhoto:” in %@ class", self.class);
        }];
    }];
}

+ (RACSignal<RACTuple *> *)zlCamera:(UIViewController *)presentViewController
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [ZLPhotoActionSheet zlPhotoActionSheet].configuration.maxSelectCount = 1;
        [ZLPhotoActionSheet zlPhotoActionSheet].configuration.allowTakePhotoInLibrary = YES;

        [[[self.class zlPhotos:presentViewController] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple * _Nullable x) {
            UIImage *image = [(NSArray<UIImage *> *)x.first firstObject];
            [subscriber sendNext:RACTuplePack(image, [(NSArray<PHAsset *> *)x.second firstObject], x.third)];
        } completed:^{
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release cool signal methods “+ zlPhoto:” in %@ class", self.class);
        }];
    }];
}

+ (RACSignal<RACTuple *> *)zlPhotoWithCamera:(UIViewController *)presentViewController {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [ZLPhotoActionSheet zlPhotoActionSheet].configuration.maxSelectCount = 1;
        [ZLPhotoActionSheet zlPhotoActionSheet].configuration.maxPreviewCount = 0;
        [ZLPhotoActionSheet zlPhotoActionSheet].configuration.useSystemCamera = YES;
        [ZLPhotoActionSheet zlPhotoActionSheet].configuration.saveNewImageAfterEdit = NO;
        [ZLPhotoActionSheet zlPhotoActionSheet].configuration.editAfterSelectThumbnailImage = YES;
        [ZLPhotoActionSheet zlPhotoActionSheet].configuration.navBarColor = colorF14745;
        [ZLPhotoActionSheet zlPhotoActionSheet].configuration.clipRatios = @[GetClipRatio(1, 1),];
        [[ZLPhotoActionSheet zlPhotoActionSheet] showPreviewAnimated:YES sender:presentViewController];
        [ZLPhotoActionSheet zlPhotoActionSheet].selectImageBlock = ^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            [subscriber sendNext:RACTuplePack([images firstObject], assets, @(isOriginal))];
            [subscriber sendCompleted];
        };
        [ZLPhotoActionSheet zlPhotoActionSheet].cancleBlock = ^{
            [subscriber sendCompleted];
        };
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release cool signal methods “+ zlPhotos:” in %@ class", self.class);
        }];
    }];
}

+ (RACSignal<RACTuple *> *)zlPhotos:(UIViewController *)presentViewController maxCount:(NSInteger)count
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [ZLPhotoActionSheet zlPhotoActionSheet].configuration.maxSelectCount = count;
        [[ZLPhotoActionSheet zlPhotoActionSheet] showPhotoLibraryWithSender:presentViewController];
        [ZLPhotoActionSheet zlPhotoActionSheet].selectImageBlock = ^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            [subscriber sendNext:RACTuplePack(images, assets, @(isOriginal))];
            [subscriber sendCompleted];
        };
        [ZLPhotoActionSheet zlPhotoActionSheet].cancleBlock = ^{
            [subscriber sendCompleted];
        };
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release cool signal methods “+ zlPhotos:” in %@ class", self.class);
        }];
    }];
}

@end
