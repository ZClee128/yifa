//
//  TimeLabel.m
//  EasyFast
//
//  Created by easyfast on 2020/8/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "TimeLabel.h"


@interface TimeLabel()

@property (nonatomic,strong)CountDown *timer;
@end

@implementation TimeLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.timer = [[CountDown alloc] init];
    }
    return self;
}

-(void)countDownWithStratDate:(NSDate *)startDate finishDate:(NSDate *)finishDate{
    [self.timer countDownWithStratDate:startDate finishDate:finishDate completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        if (day) {
            self.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld:%02ld",(long)day,(long)hour,(long)minute,(long)second];
        }else {
            self.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour,(long)minute,(long)second];
        }
        if (day == 0 && hour == 0 && minute == 0 && second == 0) {
            [self.timer destoryTimer];
        }
    }];
}
@end
