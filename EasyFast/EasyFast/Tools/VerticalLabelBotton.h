//
//  VerticalLabelBotton.h
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerticalLabelBotton : UIView
@property (nonatomic,strong)QMUILabel *topLab;
@property (nonatomic,strong)QMUILabel *bottomLab;
- (void)setTopTilte:(NSString *)top bottomTitle:(NSString *)bottom;
@end

NS_ASSUME_NONNULL_END
