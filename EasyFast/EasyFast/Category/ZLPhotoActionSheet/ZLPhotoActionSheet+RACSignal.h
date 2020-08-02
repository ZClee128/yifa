//
//  ZLPhotoActionSheet+RACSignal.h
//  XQC
//
//  Created by anmin on 2019/4/18.
//  Copyright © 2019 xqc. All rights reserved.
//

#import <ZLPhotoBrowser/ZLPhotoBrowser.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLPhotoActionSheet (RACSignal)

+ (RACSignal<RACTuple *> *)zlPhotos:(UIViewController *)presentViewController;
+ (RACSignal<RACTuple *> *)zlPhoto:(UIViewController *)presentViewController;
+ (RACSignal<RACTuple *> *)zlCamera:(UIViewController *)presentViewController;
+ (RACSignal<RACTuple *> *)zlPhotoWithCamera:(UIViewController *)presentViewController;
+ (RACSignal<RACTuple *> *)zlPhotos:(UIViewController *)presentViewController maxCount:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
