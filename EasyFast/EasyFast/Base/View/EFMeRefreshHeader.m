//
//  EFMeRefreshHeader.m
//  EasyFast
//
//  Created by easyfast on 2020/7/28.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFMeRefreshHeader.h"

@implementation EFMeRefreshHeader

- (void)prepare
{
    [super prepare];
    //GIF数据
    UIImage *one = UIImageMake(@"white_refresh");
    self.gifView.image = one;
    
}

- (void)placeSubviews {
    [super placeSubviews];
    self.stateLabel.textColor = UIColor.whiteColor;
    self.mj_h = NAVIGATION_BAR_HEIGHT;
}
@end
