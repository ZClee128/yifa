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
#import "MeVM.h"
#import "EFFootprintCollectionViewCell.h"

@interface EFFootprintViewController ()<LTSCalendarEventSource>{
    NSMutableDictionary *eventsByDate;
}

@property (nonatomic,strong)LTSCalendarManager *manager;
@property (nonatomic,strong)LTSCalendarContentView *calendarView;

@end

@implementation EFFootprintViewController

- (void)viewDidLoad {
    self.viewModel = [[MeVM alloc] init];
    self.lineSpacing = WidthOfScale(10);
    self.interitemSpacing = WidthOfScale(10);
    self.itemSize = CGSizeMake(WidthOfScale(167), WidthOfScale(165+72));
    self.registerClasses = @[@{@"EFFootprintCollectionViewCell":@"EFFootprintCollectionViewCell"}];
    self.collectionEdgeInsets = UIEdgeInsetsMake(WidthOfScale(15), WidthOfScale(15), WidthOfScale(15), WidthOfScale(15));
    [super viewDidLoad];
    self.gk_navTitle = @"浏览足迹";
    self.gk_navLineHidden = NO;
    NSDate *today = [NSDate new];
    NSInteger timeSp = [today timeIntervalSince1970];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate: date];
    ((MeVM *)self.viewModel).dateStr = dateString;
    
    @weakify(self);
    [[self getDay] subscribeNext:^(NSArray *x) {
        EFCalendarView *calendarView = [[EFCalendarView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, WidthOfScale(91)) withData:[x mutableCopy]];
        @strongify(self);
        [self.view addSubview:calendarView];
        calendarView.seletDay = ^(CalendarModel * _Nonnull model) {
            ((MeVM *)self.viewModel).dateStr = model.dayStr;
            [self loadList];
        };
    }];
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
    self.collectionView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT + WidthOfScale(91), kPHONE_WIDTH, kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT - WidthOfScale(91) - TAB_SAFE_HEIGHT);
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self addRefshUp];
    [self addRefshDown];
    [self loadList];
}

- (void)loadList {
    @weakify(self);
    [[self.viewModel refreshForDown] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        [self.collectionView.mj_header endRefreshing];
        self.EFData = x.first;
        [self.collectionView reloadData];
    }];
}

- (void)loadNewData {
    [self loadList];
}

- (void)loadMoreData {
    @weakify(self);
    [[self.viewModel refreshForUp] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        [self.collectionView.mj_footer endRefreshing];
        NSMutableArray *tmpArr = [x.second mutableCopy];
        for (int i = 0 ; i < [tmpArr count]; i++) {
            EFFootPrint *model1 = tmpArr[i];
            for (int j = 0; j< self.EFData.count; j++) {
                EFFootPrint *model2 = self.EFData[j];
                if ([model1.dateTime isEqualToString:model2.dateTime]) {
                    [model2.goodsList addObjectsFromArray:model1.goodsList];
                    self.EFData[j] = model2;
                    [tmpArr removeObject:model1];
                }
            }
        }
        [self.EFData addObjectsFromArray:tmpArr];
        [self.collectionView reloadData];
    }];
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.EFData.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    EFFootPrint *model = self.EFData[section];
    return model.goodsList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EFFootprintCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EFFootprintCollectionViewCell class]) forIndexPath:indexPath];
    EFFootPrint *model = self.EFData[indexPath.section];
    [cell setLeftModel:model.goodsList[indexPath.item]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"forIndexPath:indexPath];
    EFFootPrint *model = self.EFData[indexPath.section];
    for(UIView *v in header.subviews) {
        [v removeFromSuperview];
    }
    QMUILabel *titleLab = [[QMUILabel alloc] initWithFrame:CGRectMake(0, WidthOfScale(27.5 - 12.5), kPHONE_WIDTH, WidthOfScale(12.5))];
    titleLab.contentEdgeInsets = UIEdgeInsetsMake(WidthOfScale(15), WidthOfScale(15), WidthOfScale(15), 0);
    titleLab.font = RegularFont14;
    titleLab.textColor = tabbarBlackColor;
    NSDateFormatter *dstFmt = [[NSDateFormatter alloc]init];
    dstFmt.dateFormat = @"yyyy-MM-dd";
    NSDate * srcDate = [dstFmt dateFromString:model.dateTime];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"MM月dd日";
    titleLab.text = [fmt stringFromDate:srcDate];
    [header addSubview:titleLab];
    
    return header;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kPHONE_WIDTH, WidthOfScale(27.5));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EFFootPrint *model = self.EFData[indexPath.section];
    EFGoodsList *gModel = model.goodsList[indexPath.item];
    [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(NO),@"ggNo":gModel.ggNo}];
}


- (RACSignal *)getDay {
   return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSMutableArray *days = [[NSMutableArray alloc] init];
        [[MeVM goodsMonthFootprint] subscribeNext:^(NSArray *x) {
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
                model.day = [NSString stringWithFormat:@"%ld",(long)[dayDate day]];
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
                model.hasFoot = [x containsObject: dateString];
                model.dayStr = dateString;
                [days addObject:model];
            }
            [subscriber sendNext:[[[days reverseObjectEnumerator] allObjects] mutableCopy]];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

@end
