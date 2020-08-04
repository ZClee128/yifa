//
//  EFChangeLoginHeaderView.h
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EFChangeLoginHeaderView : UIView

- (void)setBtnLogin;
@property (nonatomic,copy)void(^selectBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
