//
//  EFHeaderView.h
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EFHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame WithLeftTitle:(NSString *)left  WithRightTitle:(NSString *)right;
- (UILabel *)getLeftLab;
@end

NS_ASSUME_NONNULL_END
