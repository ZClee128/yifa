//
//  EFClassTabTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFClassTabTableViewCell.h"
#import "HotTabCollectionViewCell.h"

@interface EFClassTabTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collect;
@property (nonatomic,strong)NSMutableArray *data;
@end

@implementation EFClassTabTableViewCell

-(NSMutableArray *)data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc]init];
    }
    return _data;
}

-(UICollectionView *)collect
{
    if (_collect == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
        flow.minimumLineSpacing = WidthOfScale(15);
        flow.minimumInteritemSpacing = WidthOfScale(0);
        flow.itemSize = CGSizeFloor(CGSizeMake(WidthOfScale((375 - 70)/5), WidthOfScale(83.5)));
        _collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(212)) collectionViewLayout:flow];
        _collect.backgroundColor = [UIColor clearColor];
        _collect.delegate = self;
        _collect.dataSource = self;
        _collect.showsHorizontalScrollIndicator = NO;
        _collect.showsVerticalScrollIndicator = NO;
        _collect.contentInset = UIEdgeInsetsMake(WidthOfScale(15.5), WidthOfScale(15.5), WidthOfScale(15.5), WidthOfScale(15.5));
        [_collect registerClass:[HotTabCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HotTabCollectionViewCell class])];
    }
    return _collect;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setUI {
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.collect];
}

- (void)setCollectData:(NSMutableArray *)data {
    self.data = data;
    [self.collect reloadData];
}


#pragma mark - collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotTabCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HotTabCollectionViewCell class]) forIndexPath:indexPath];
    [cell setModel:self.data[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EFClassifyModel *model = self.data[indexPath.item];
    if (self.selectItem) {
        self.selectItem(model);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
