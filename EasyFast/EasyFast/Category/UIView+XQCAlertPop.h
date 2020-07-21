//
//  UIView+XQCAlertPop.h
//  XQC
//
//  Created by lee on 2019/5/7.
//  Copyright © 2019 xqc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^XQCAlertPopBlock)(UIButton * _Nullable button,NSInteger didRow);
@interface UIView (XQCAlertPop)

/** 只弹出文字列表
 *  array ：弹出的选项标题
 *  textColor ：选项标题的字体颜色 可设置两种类型，数组颜色或者单个颜色（NSArray/UIColor）
 *  font ：选项标题的字体
 *  取消 按钮字体请到.m文件自行设置。默认黑色-16号
 **/
-(RACSignal *)createAlertViewTitleArray:(NSArray* _Nullable )array textColor:(id _Nullable )color font:(UIFont*_Nullable)font;
@end

NS_ASSUME_NONNULL_END
