//
//  XQCAlertTool.m
//  XQC
//
//  Created by lee on 2019/4/17.
//  Copyright © 2019 xqc. All rights reserved.
//

#import "XQCAlertTool.h"

@implementation XQCAlertTool

+ (RACSignal *)showAlertTitle:(NSString *)title message:(NSString *)message{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [[self showAlertTitle:title message:message cancle:@"取消" sure:@"确定"] subscribeNext:^(id  _Nullable x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        } error:^(NSError * _Nullable error) {
            [subscriber sendError:error];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

+ (RACSignal *)showAlertNoCancelWithTitle:(NSString *)title message:(NSString *)message
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [[self showAlertNoCancelTitle:title message:message sure:@"知道了"] subscribeNext:^(id  _Nullable x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        } error:^(NSError * _Nullable error) {
            [subscriber sendError:error];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

+ (RACSignal *)showAlertTitle:(NSString *)title message:(NSString *)message cancle:(NSString *)cancleTitle sure:(NSString *)sureTitle{
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        UIApplication *application = [UIApplication sharedApplication];
        AppDelegate *delegate = (AppDelegate *)application.delegate;
        UIWindow *window = delegate.window;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:cancleTitle
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 [subscriber sendError:nil];
                                                             }];
        
        UIAlertAction *actionDone = [UIAlertAction actionWithTitle:sureTitle
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               [subscriber sendNext:action];
                                                               [subscriber sendCompleted];
                                                           }];
        [alert addAction:actionCancel];
        [alert addAction:actionDone];
        
        [window.rootViewController presentViewController:alert animated:YES completion:nil];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}


+ (RACSignal *)showAlertWithController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message cancle:(NSString *)cancleTitle sure:(NSString *)sureTitle{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:cancleTitle
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 [subscriber sendError:nil];
                                                             }];
        
        UIAlertAction *actionDone = [UIAlertAction actionWithTitle:sureTitle
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               [subscriber sendNext:action];
                                                               [subscriber sendCompleted];
                                                           }];
        [alert addAction:actionCancel];
        [alert addAction:actionDone];
        
        [viewController presentViewController:alert animated:YES completion:nil];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

+ (RACSignal *)showAlertNoCancelTitle:(NSString *)title message:(NSString *)message sure:(NSString *)sureTitle{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        UIApplication *application = [UIApplication sharedApplication];
        AppDelegate *delegate = (AppDelegate *)application.delegate;
        UIWindow *window = delegate.window;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
       
        
        UIAlertAction *actionDone = [UIAlertAction actionWithTitle:sureTitle
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               [subscriber sendNext:action];
                                                               [subscriber sendCompleted];
                                                           }];
        [alert addAction:actionDone];
        
        [window.rootViewController presentViewController:alert animated:YES completion:nil];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}
@end
