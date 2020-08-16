//
//  UITextField+Extension.m
//  ZLK
//
//  Created by it on 16/10/8.
//  Copyright © 2016年 zlgw. All rights reserved.
//

#import "UITextField+MyExtension.h"
//#import <UIButton+EnlargeTouchArea.h>
@implementation UITextField (MyExtension)

-(void)setLeftViewAtImageName:(NSString *)imageName{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeCenter;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = imageView;
    
}

/**
 *  给UITextField设置右侧的图片
 *
 *  @param imageName 图片名称
 */
-(void)setRightViewWithimageName:(NSString *)imageName click:(void (^)(QMUIButton *))next{
    
    QMUIButton *rightView = [[QMUIButton alloc]init];
    rightView.size = CGSizeMake(WidthOfScale(35), WidthOfScale(35));
    [rightView setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    rightView.contentMode = UIViewContentModeCenter;
    rightView.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WidthOfScale(15.5));
    self.rightView = rightView;
    self.rightViewMode = UITextFieldViewModeAlways;
//    @weakify(self);
//    RAC(self.rightView,hidden) = [RACSignal combineLatest:@[[RACSignal merge:@[self.rac_textSignal, RACObserve(self, text)]]] reduce:^id _Nonnull(NSString *text){
//        @strongify(self);
//        return @(text.length == 0 || !self.isFirstResponder);
//    }];
//    RAC(self.rightView,userInteractionEnabled) = [RACSignal combineLatest:@[[RACSignal merge:@[self.rac_textSignal, RACObserve(self, text)]]] reduce:^id _Nonnull(NSString *text){
//        @strongify(self);
//        return @(!(text.length == 0 || !self.isFirstResponder));
//    }];
    [[rightView rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton  *x) {
        x.selected = !x.selected;
        next(x);
    }];
}

/**
 *  给UITextField设置右侧带删除按钮张的图片
 *
 *  @param imageName 图片名称名称
 */
//-(void)setRightViewCloseWithimageName:(NSString *)imageName click:(void (^)(UIButton *))next close:(void(^)(UIButton *))closeBtn clickCloseBtn:(void(^)(void))compelect{
//
//    UIView *right = [[UIView alloc] init];
//    right.size = CGSizeMake(kGetImage(klogin_close_icon).size.width + kGetImage(imageName).size.width + 10, kGetImage(klogin_close_icon).size.height);
//    UIButton *close = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [close setImage:[UIImage imageNamed:klogin_close_icon] forState:(UIControlStateNormal)];
//    [right addSubview:close];
//    [close mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(right.mas_centerY);
//        make.right.equalTo(right.mas_right).equalTo(@(-26));
//    }];
//    [close setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
//    closeBtn(close);
//    @weakify(self);
//    RAC(close,alpha) = [RACSignal combineLatest:@[[RACSignal merge:@[self.rac_textSignal, RACObserve(self, text)]]] reduce:^id _Nonnull(NSString *text){
//        @strongify(self);
//        return @((text.length == 0 || !self.isFirstResponder) ? 0 : 1);
//    }];
//    RAC(close,userInteractionEnabled) = [RACSignal combineLatest:@[[RACSignal merge:@[self.rac_textSignal, RACObserve(self, text)]]] reduce:^id _Nonnull(NSString *text){
//        @strongify(self);
//        return @(!(text.length == 0 || !self.isFirstResponder));
//    }];
//    UIButton *rightView = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [rightView setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
//    [right addSubview:rightView];
//    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(right.mas_centerY);
//        make.right.equalTo(right.mas_right).equalTo(@(-0));
//    }];
//    rightView.contentMode = UIViewContentModeCenter;
//    self.rightView = right;
//    self.rightViewMode = UITextFieldViewModeAlways;
//    [rightView setEnlargeEdgeWithTop:50 right:50 bottom:50 left:0];
//    [[rightView rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        next(rightView);
//        x.selected = !x.selected;
//    }];
//    [rightView setImage:[UIImage imageNamed:kimg_open_eye_gray] forState:(UIControlStateSelected)];
//    [[close rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        compelect();
//    }];
//}


- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect rightRect =CGRectZero;
    
    rightRect.origin.x = bounds.size.width - self.rightView.size.width;
    
    rightRect.size.height = self.rightView.size.height;
    
    rightRect.origin.y = (bounds.size.height - rightRect.size.height)/2;
    
    rightRect.size.width = self.rightView.size.width;
    
    return rightRect;
}


/*
 *  1.UITextPosition和UITextRange类是符合UITextInput文档，
 *  2.UITextPosition代表一个文本容器中的位置
 *  3.UITextRange对象封装了开始和结束UITextPosition的对象
 */

///变换输入框的 输入的字符串
- (void)changTextWithNSString:(NSString *)text {
    //UITextPosition对象
    //文本开始
    UITextPosition *begining = self.beginningOfDocument;
    //标记和选定文本
    UITextPosition *start = self.selectedTextRange.start;
    UITextPosition *end = self.selectedTextRange.end;
    //计算文本的范围和位置
    NSInteger startIndex = [self offsetFromPosition:begining toPosition:start];
    NSInteger endIndex = [self offsetFromPosition:begining toPosition:end];
    //获取输入的字符串
    NSString *originText = self.text;
    //截取字符串---从字符串的开头一直截取到指定的位置，但不包括该位置的字符
    NSString *firstPart = [originText substringToIndex:startIndex];
    //截取字符串---从指定位置开始（包括指定位置的字符），并包括之后的全部字符
    NSString *secondPart = [originText substringFromIndex:endIndex];
    // 设置变量
    NSInteger offset;
    if (![text isEqualToString:@""]) {
        offset = text.length;
    } else {
        if (startIndex == endIndex) {
            if (startIndex == 0) {
                return;
            }
            offset = -1;
            firstPart = [firstPart substringToIndex:(firstPart.length - 1)];
        } else {
            offset = 0;
        }
    }
    NSString *newText = [NSString stringWithFormat:@"%@%@%@", firstPart, secondPart, text];
    self.text = newText;
    UITextPosition *now = [self positionFromPosition:start offset:offset];
    UITextRange *range = [self textRangeFromPosition:now toPosition:now];
    self.selectedTextRange = range;
    
}
@end
