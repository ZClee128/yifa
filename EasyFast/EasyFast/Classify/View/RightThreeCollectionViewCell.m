//
//  RightThreeCollectionViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/22.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "RightThreeCollectionViewCell.h"
#import "ThreeCollectionViewCellItem.h"
#import "EFClassifyModel.h"

@interface RightThreeCollectionViewCell ()
<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) CGFloat sectionInsetTop;
@property (nonatomic, assign) CGFloat sectionInsetLeft;
@property (nonatomic, assign) CGFloat sectionInsetBottom;
@property (nonatomic, assign) CGFloat sectionInsetRight;

/** 上下行间距 */
@property (nonatomic, assign) CGFloat minimumLineSpacing;

/** 左右列间距 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

/**总共有多少个cell */
@property (nonatomic, strong) NSMutableArray *dataArray;

/**一个cell 的高度 */
@property (nonatomic, assign) CGFloat itemHeight;

/**一行有多少列 */
@property (nonatomic, assign) NSInteger columns;

/**一共有都是行 */
@property (nonatomic, assign) NSInteger rowCount;


@end


@implementation RightThreeCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        self.sectionInsetTop = 0;
        self.sectionInsetLeft = WidthOfScale(25.5);
        self.sectionInsetBottom = 0;
        self.sectionInsetRight = WidthOfScale(25.5);
        self.minimumLineSpacing = WidthOfScale(15);
        self.minimumInteritemSpacing = WidthOfScale(20.5);
        self.columns = 3;
        self.itemHeight = WidthOfScale(83);
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumInteritemSpacing = self.minimumInteritemSpacing;
        flowLayout.minimumLineSpacing = self.minimumLineSpacing;
        flowLayout.sectionInset = UIEdgeInsetsMake(self.sectionInsetTop, self.sectionInsetLeft, self.sectionInsetBottom, self.sectionInsetRight);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width , self.frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.scrollEnabled = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        _collectionView.backgroundColor = [UIColor whiteColor];
//        _collectionView.layer.backgroundColor = [UIColor whiteColor].CGColor;
//        _collectionView.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.08].CGColor;
//        _collectionView.layer.shadowOffset = CGSizeMake(0, 0);
//        _collectionView.layer.shadowOpacity = 1;
//        _collectionView.layer.shadowRadius = 5;
//        _collectionView.layer.masksToBounds = NO;

        CGFloat itemSizeWidth = (_collectionView.width - self.sectionInsetLeft - self.sectionInsetRight - ((self.columns - 1) * self.minimumInteritemSpacing)) / self.columns;
        flowLayout.itemSize = CGSizeFloor(CGSizeMake(itemSizeWidth, self.itemHeight));

        
        [_collectionView registerClass:[ThreeCollectionViewCellItem class] forCellWithReuseIdentifier:NSStringFromClass([ThreeCollectionViewCellItem class])];
    }
    return _collectionView;
}

-(CGFloat) getCollectionHeight:(NSMutableArray *)dataArray
{
    self.dataArray = dataArray;
    NSInteger a = self.dataArray.count % self.columns;
    if (a == 0)
    {
        self.rowCount = self.dataArray.count / self.columns;
    }
    else
    {
        self.rowCount = (self.dataArray.count / self.columns) + 1;
    }
    CGFloat collectionHeight = (self.rowCount * self.itemHeight) + ((self.rowCount - 1) * self.minimumLineSpacing) + self.sectionInsetTop + self.sectionInsetBottom;
    self.collectionView.height = collectionHeight;
    return collectionHeight;
}

-(void) reloadData
{
    [self.collectionView reloadData];
}

#pragma mark
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ThreeCollectionViewCellItem * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ThreeCollectionViewCellItem class]) forIndexPath:indexPath];
    EFClassifyModel *model = [self.dataArray objectAtIndex:indexPath.row];

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EFClassifyModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if (model)
    {
        if (self.returnSelectItemBlock)
        {
            self.returnSelectItemBlock(model.idField);
        }
    }
}

#pragma mark
-(void) selectBlock:(ReturnSelectItemBlock)block
{
    self.returnSelectItemBlock = block;
}
@end
