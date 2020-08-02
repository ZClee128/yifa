//
//  EFCalendarView.m
//  EasyFast
//
//  Created by easyfast on 2020/8/2.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFCalendarView.h"
#import "EFCalendarCollectionViewCell.h"

@interface EFCalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *calendarCollection;
@property (nonatomic,strong)NSMutableArray *data;

@end


@implementation EFCalendarView

- (instancetype)initWithFrame:(CGRect)frame withData:(NSMutableArray *)data
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.data = data;
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];//横向滑动
        flow.minimumLineSpacing = 0;
        flow.itemSize = CGSizeMake(kPHONE_WIDTH/7, WidthOfScale(91));
        self.calendarCollection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
        self.calendarCollection.delegate = self;
        self.calendarCollection.dataSource = self;
        self.calendarCollection.showsVerticalScrollIndicator = NO;
        self.calendarCollection.showsHorizontalScrollIndicator = NO;
        [self.calendarCollection registerClass:[EFCalendarCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([EFCalendarCollectionViewCell class])];
        [self addSubview:self.calendarCollection];
        self.calendarCollection.backgroundColor = UIColor.whiteColor;
        [self.calendarCollection layoutIfNeeded];//这个必须先执行，否则没效果
        [self.calendarCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.data.count - 1  inSection:0] atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:NO];
    }
    return self;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EFCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EFCalendarCollectionViewCell class]) forIndexPath:indexPath];
    [cell setData:self.data[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (int i = 0; i < self.data.count; i++) {
        CalendarModel *model = self.data[i];
        if (i == indexPath.item) {
            model.isSelect = YES;
        }else {
            model.isSelect = NO;
        }
    }
    [self.calendarCollection reloadData];
    if (self.seletDay) {
        self.seletDay(self.data[indexPath.item]);
    }
}

@end
