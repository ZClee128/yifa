//
//  EFRefreshHeader.m
//  EasyFast
//
//  Created by easyfast on 2020/7/28.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFRefreshHeader.h"

@interface EFRefreshHeader ()


@end

@implementation EFRefreshHeader

- (void)prepare
{
    [super prepare];
    //GIF数据
    UIImage *one = UIImageMake(@"refresh");
//    UIImage *two = [one qmui_imageWithOrientation:(UIImageOrientationLeft)];
//    UIImage *three = [one qmui_imageWithOrientation:(UIImageOrientationUp)];
//    UIImage *four = [one qmui_imageWithOrientation:(UIImageOrientationRight)];
////    NSArray * idleImages = [self getRefreshingImageArrayWithStartIndex:1 endIndex:8];
//    NSArray * refreshingImages = @[three,four,one,two];
//    //普通状态
//    [self setImages:refreshingImages forState:MJRefreshStateIdle];
//    //即将刷新状态
//    [self setImages:refreshingImages forState:MJRefreshStatePulling];
//    //正在刷新状态
//    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    self.gifView.image = one;
    CABasicAnimation *layer = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    layer.toValue = @(2*M_PI);
    layer.duration = 1;
    layer.removedOnCompletion = false;
    layer.repeatCount = MAXFLOAT;
    [self.gifView.layer addAnimation:layer forKey:nil];
    [self setTitle:@"下拉刷新" forState:(MJRefreshStateIdle)];
    [self setTitle:@"松开刷新" forState:(MJRefreshStatePulling)];
    [self setTitle:@"正在刷新" forState:(MJRefreshStateRefreshing)];
}
/**
 *  摆放子控件
 */

- (void)placeSubviews
{
    [super placeSubviews];
    
    //隐藏状态显示文字
    self.stateLabel.font = RegularFont13;
    self.stateLabel.textColor = [RGB16(0xBDBDBD) colorWithAlphaComponent:0.7];
    //隐藏更新时间文字
    self.lastUpdatedTimeLabel.hidden = YES;
    [self.gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(130.5)));
        make.centerY.equalTo(self.stateLabel);
    }];
    
}


@end
