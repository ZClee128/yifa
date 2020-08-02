//
//  EFFootprintViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/7/31.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFootprintViewController.h"
#import "LTSCalendarManager.h"
#import "TuanOtherGoodsTableViewCell.h"
#import "EFCalendarView.h"
#import "CalendarModel.h"

@interface EFFootprintViewController ()<LTSCalendarEventSource>{
    NSMutableDictionary *eventsByDate;
}

@property (nonatomic,strong)LTSCalendarManager *manager;
@property (nonatomic,strong)LTSCalendarContentView *calendarView;

@end

@implementation EFFootprintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"浏览足迹";
    self.gk_navLineHidden = NO;
    
    
    
    
    EFCalendarView *calendarView = [[EFCalendarView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, WidthOfScale(91)) withData:[self getDay]];
    [self.view addSubview:calendarView];
    calendarView.seletDay = ^(CalendarModel * _Nonnull model) {
        
    };
//    self.manager = [LTSCalendarManager new];
//    self.manager.eventSource = self;
//    self.manager.weekDayView = [[LTSCalendarWeekDayView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, 30)];
//    self.manager.weekDayView.backgroundColor = UIColor.whiteColor;
//    [self.view addSubview:self.manager.weekDayView];
//
////    [LTSCalendarAppearance share].weekDayHeight = WidthOfScale(69);
//    [LTSCalendarAppearance share].dayCircleColorToday = [colorF14745 colorWithAlphaComponent:0.6];
//    [LTSCalendarAppearance share].dayBorderColorToday = [colorF14745 colorWithAlphaComponent:0.6];
//    [LTSCalendarAppearance share].dayCircleColorSelected = colorF14745;
//    [LTSCalendarAppearance share].isShowLunarCalender = NO;
//    self.manager.calenderScrollView = [[LTSCalendarScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.manager.weekDayView.frame), kPHONE_WIDTH, CGRectGetHeight(self.view.frame)-CGRectGetMaxY(self.manager.weekDayView.frame))];
//    [self.view insertSubview:self.manager.calenderScrollView belowSubview:self.EFTableView];
////    [self.view addSubview:self.manager.calenderScrollView];
////    [self createRandomEvents];
//    self.automaticallyAdjustsScrollViewInsets = false;
//    [self.manager showSingleWeek];
    
    self.EFTableView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT + 91, kPHONE_WIDTH, kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT + 91);
    self.EFData = [@[@1,@2,@3,@5] mutableCopy];
    [self.EFTableView registerClass:[TuanOtherGoodsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TuanOtherGoodsTableViewCell class])];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.EFData.count % 2 == 0 ? self.EFData.count / 2 : (self.EFData.count) - (self.EFData.count / 2) ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TuanOtherGoodsTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TuanOtherGoodsTableViewCell class])];
    [goodsCell setModel:self.EFData];
    if (self.EFData.count % 2 == 0) {
        [goodsCell showRightView];
    }else {
        if (indexPath.row == (self.EFData.count) - (self.EFData.count / 2) - 1) {
            [goodsCell hiddenRightView];
        }else {
            [goodsCell showRightView];
        }
    }
    return goodsCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthOfScale(165+72+10);
}


- (NSMutableArray *)getDay {
    NSMutableArray *days = [[NSMutableArray alloc] init];
    NSDate *today = [NSDate new];
    NSInteger timeSp = [today timeIntervalSince1970];
    for (int i = 0 ; i < 32; i++) {
        NSInteger daySp = timeSp - (24 * 3600)*i;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:daySp];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [formatter stringFromDate: date];
        NSDate *dayDate = [formatter dateFromString:dateString];
        CalendarModel *model = [[CalendarModel alloc] init];
        model.day = [NSString stringWithFormat:@"%ld",[dayDate day]];
        switch ([dayDate weekday]) {
            case 1:
                model.week = @"日";
                break;
            case 2:
                model.week = @"一";
                break;
            case 3:
                model.week = @"二";
                break;
            case 4:
                model.week = @"三";
                break;
            case 5:
                model.week = @"四";
                break;
            case 6:
                model.week = @"五";
                break;
            default:
                model.week = @"六";
                break;
        }
        model.isToday = dayDate.isToday;
        model.isSelect = NO;
        model.hasFoot = YES;
        model.dayStr = dateString;
        [days addObject:model];
    }
    return [[[days reverseObjectEnumerator] allObjects] mutableCopy];
}

@end
