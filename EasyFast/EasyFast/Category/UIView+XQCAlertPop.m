//
//  UIView+XQCAlertPop.m
//  XQC
//
//  Created by lee on 2019/5/7.
//  Copyright © 2019 xqc. All rights reserved.
//

#import "UIView+XQCAlertPop.h"
@implementation UIView (XQCAlertPop)

UIView *backgroundV;
UIView *bottomView;
float height;


/** 只弹出文字列表
 *  array ：弹出的选项标题
 *  textColor ：选项标题的字体颜色 可设置两种类型，数组颜色或者单个颜色（NSArray/UIColor）
 *  font ：选项标题的字体
 *  取消 按钮字体请到.m文件自行设置。默认黑色-16号
 **/
- (RACSignal *)createAlertViewTitleArray:(NSArray *)array textColor:(id)color font:(UIFont *)font {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self createAlertViewTitleArray:array arrayImage:nil textColor:color font:font spacing:0 topTitle:@"请选择时段" actionBlock:^(UIButton * _Nullable button, NSInteger didRow) {
            [subscriber sendNext:@(didRow)];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

/**
 *  array ：弹出的选项标题
 *  arrayImage ：数组图标，没有写nil
 *  textColor ：选项标题的字体颜色 可设置两种类型，数组颜色或者单个颜色（NSArray/UIColor）
 *  font ：选项标题的字体
 *  spacing ：文字与图片间距自行调试（无图片可填0）
 *  取消 按钮字体请到.m文件自行设置。默认黑色-16号
 **/
-(void)createAlertViewTitleArray:(NSArray* _Nullable )array arrayImage:(NSArray* _Nullable )arrayImage textColor:(id _Nullable )color font:(UIFont*_Nullable)font spacing:(CGFloat)spacing topTitle:(NSString *)title actionBlock:(XQCAlertPopBlock _Nullable )actionBlock{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    
    backgroundV = [[UIView alloc]initWithFrame:window.bounds];
    backgroundV.backgroundColor = UIColorFromRGBA(0x000000, 0);
    
    [window addSubview:backgroundV];
    
    //点击手势
    UITapGestureRecognizer *touchDown = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didMiss)];
    touchDown.numberOfTapsRequired = 1;
    [backgroundV addGestureRecognizer:touchDown];
    
    height = array.count*50+array.count*0.5+57.5+TAB_SAFE_HEIGHT;
    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kPHONE_HEIGHT, kPHONE_WIDTH, height+50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [window addSubview:bottomView];
    
    NSArray *arrayColor;
    UIColor *colors;
    @weakify(self);
    for (int i=0; i<array.count; i++) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, i*50+i*0.5+WidthOfScale(48.5), kPHONE_WIDTH, 50)];
        
        [btn setTitle:array[i] forState:UIControlStateNormal];
        
        
        if (arrayImage) {
            if (i>=arrayImage.count) {
                NSLog(@"数组越界-数组图片数量有误，请仔细检查");
                return;
            }
            [btn setImage:[UIImage imageNamed:arrayImage[i]] forState:UIControlStateNormal];
            btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            btn.imageEdgeInsets = UIEdgeInsetsMake(12, - 0.5 * spacing, 12, 0.5 * spacing);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0.5 * spacing, 0, - 0.5 * spacing);
        }
        
        
        btn.tag = 10000+i;
        btn.titleLabel.font = font;
        [bottomView addSubview:btn];
        [[btn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(UIButton *sender) {
            @strongify(self);
            actionBlock(sender,i);
            [self didMiss];
        }];
        
        
        //如果是数组颜色
        if ([color isKindOfClass:[NSArray class]]) {
            arrayColor = [NSArray arrayWithArray:color];
            if (i>=arrayColor.count) {
                NSLog(@"数组越界-数组图片颜色数量有误，请仔细检查");
                return;
            }
            colors = arrayColor[i];
        }else{
            colors = (UIColor*)color;
        }
        [btn setTitleColor:colors forState:UIControlStateNormal];
        
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, array.count*50.5-0.5, kPHONE_WIDTH, 8)];
    line.backgroundColor = UIColor.whiteColor;
    [bottomView addSubview:line];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(48.5))];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:tabbarBlackColor forState:UIControlStateNormal];
    btn.titleLabel.font = MedFont15;
    [bottomView addSubview:btn];
//    [btn addTarget:self action:@selector(didMiss) forControlEvents:UIControlEventTouchUpInside];
    
//    if (iPhoneX) {
//        UIView *lineB = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame), kPHONE_WIDTH, 0.5)];
//        lineB.backgroundColor = RGBA(235, 235, 235, 1);
//        [bottomView addSubview:lineB];
//    }
    
    //普通动画
    
    [UIView animateWithDuration:0.2 animations:^{
        bottomView.frame = CGRectMake(0, kPHONE_HEIGHT-height-8, kPHONE_WIDTH, height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            bottomView.frame = CGRectMake(0, kPHONE_HEIGHT-height, kPHONE_WIDTH, height);
        }];
        
    }];
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        backgroundV.backgroundColor = UIColorFromRGBA(0x000000, 0.3);
    } completion:^(BOOL finished) {
        
    }];
    
}


//页面消失
-(void)didMiss{
    
    
    [UIView animateWithDuration:0.3 animations:^{
        backgroundV.backgroundColor = UIColorFromRGBA(0x000000, 0);
        bottomView.frame = CGRectMake(0, kPHONE_HEIGHT, kPHONE_WIDTH, height+50);
    } completion:^(BOOL finished) {
        [backgroundV removeFromSuperview];
        [bottomView removeFromSuperview];
    }];
    
    
}
@end
