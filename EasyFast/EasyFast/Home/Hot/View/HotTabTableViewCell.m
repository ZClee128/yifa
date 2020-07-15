//
//  HotTabTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "HotTabTableViewCell.h"
#import "HotTabCollectionViewCell.h"

@interface HotTabTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collect;
@property (nonatomic,strong)NSMutableArray *data;
@end

@implementation HotTabTableViewCell

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
        [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];//横向滑动
        flow.minimumLineSpacing = WidthOfScale(10);
        //    flow.minimumInteritemSpacing = 0;
        flow.itemSize = CGSizeCeil(CGSizeMake(WidthOfScale((375 - 10*3 - 27*2)/4), 70));
        _collect = [[UICollectionView alloc] initWithFrame:CGRectMake(WidthOfScale(27), 10, WidthOfScale(375 - 27*2), 70) collectionViewLayout:flow];
        _collect.backgroundColor = [UIColor clearColor];
        _collect.delegate = self;
        _collect.dataSource = self;
        _collect.showsHorizontalScrollIndicator = NO;
        _collect.showsVerticalScrollIndicator = NO;
        [_collect registerClass:[HotTabCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HotTabCollectionViewCell class])];
    }
    return _collect;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.contentView.backgroundColor = colorfafafa;
    [self.contentView addSubview:self.collect];
}

- (void)setCollectData:(NSMutableArray *)data {
    self.data = data;
    [self.collect reloadData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    [cell setModel:@""];
    return cell;
}



@end
