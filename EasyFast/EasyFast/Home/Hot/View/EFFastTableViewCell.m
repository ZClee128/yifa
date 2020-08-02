//
//  EFFastTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFastTableViewCell.h"
#import "EFFastCollectionViewCell.h"

@interface EFFastTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collect;
@property (nonatomic,strong)NSMutableArray *data;

@end


@implementation EFFastTableViewCell

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
        flow.minimumLineSpacing = WidthOfScale(15);
        CGFloat itemHeight = 140+14.5+16+8+15+20;
        flow.itemSize = CGSizeMake(140, itemHeight);
        _collect = [[UICollectionView alloc] initWithFrame:CGRectMake(WidthOfScale(15), 0, WidthOfScale(375 - 30), itemHeight) collectionViewLayout:flow];
        _collect.backgroundColor = [UIColor clearColor];
        _collect.delegate = self;
        _collect.dataSource = self;
        _collect.showsHorizontalScrollIndicator = NO;
        _collect.showsVerticalScrollIndicator = NO;
        [_collect registerClass:[EFFastCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([EFFastCollectionViewCell class])];
    }
    return _collect;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
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


#pragma mark - collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EFFastCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EFFastCollectionViewCell class]) forIndexPath:indexPath];
    [cell setModel:@""];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectIndex) {
        self.selectIndex(indexPath.item);
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
