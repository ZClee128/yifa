//
//  LogisticsHeaderTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/23.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "LogisticsHeaderTableViewCell.h"
#import "EFFollowCollectionViewCell.h"
#import "EFOrderModel.h"

@interface LogisticsHeaderTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collect;
@property (nonatomic,strong)QMUILabel *numLab;
@property (nonatomic,strong)QMUILabel *priceLab;
@property (nonatomic,strong)NSMutableArray *data;

@end

@implementation LogisticsHeaderTableViewCell

-(UICollectionView *)collect
{
    if (_collect == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];//横向滑动
        flow.minimumLineSpacing = WidthOfScale(13.5);
        //    flow.minimumInteritemSpacing = 0;
        flow.itemSize = CGSizeMake(WidthOfScale(80), WidthOfScale(80));
        _collect = [[UICollectionView alloc] initWithFrame:CGRectMake(WidthOfScale(15), WidthOfScale(20), WidthOfScale(375 - 139.5), WidthOfScale(80)) collectionViewLayout:flow];
        _collect.backgroundColor = [UIColor clearColor];
        _collect.delegate = self;
        _collect.dataSource = self;
        _collect.showsHorizontalScrollIndicator = NO;
        _collect.showsVerticalScrollIndicator = NO;
        [_collect registerClass:[EFFollowCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([EFFollowCollectionViewCell class])];
    }
    return _collect;
}

-(QMUILabel *)numLab
{
    if (_numLab == nil) {
        _numLab = [[QMUILabel alloc] init];
        _numLab.font = RegularFont12;
        _numLab.textColor = tabbarBlackColor;
        _numLab.textAlignment = NSTextAlignmentLeft;
    }
    return _numLab;
}

-(QMUILabel *)priceLab
{
    if (_priceLab == nil) {
        _priceLab = [[QMUILabel alloc] init];
        _priceLab.font = RegularFont12;
        _priceLab.textColor = tabbarBlackColor;
    }
    return _priceLab;
}

- (NSMutableArray *)data {
    if (_data == nil) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

- (void)setUI {
    [self.contentView addSubview:self.collect];
    
    UIView *line = [[UIView alloc] init];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(118.5)));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(1), WidthOfScale(40)));
    }];
    line.backgroundColor = RGB16(0xB5B5B5);
    
    QMUIButton *more = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [more setImage:UIImageMake(@"more") forState:(UIControlStateNormal)];
    [self.contentView addSubview:more];
    [more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15.5)));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(more.mas_left).equalTo(@(-WidthOfScale(5)));
        make.left.equalTo(line.mas_right).equalTo(@(WidthOfScale(9.5)));
        make.top.equalTo(@(WidthOfScale(44)));
    }];
    
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(more.mas_left).equalTo(@(-WidthOfScale(2)));
        make.left.equalTo(line.mas_right).equalTo(@(WidthOfScale(9.5)));
        make.top.equalTo(@(WidthOfScale(65)));
    }];
}

- (void)setModel:(EFOrderModel *)model {
    self.numLab.text = [NSString stringWithFormat:@"共%ld件",model.quantity];
    self.priceLab.text = [NSString stringWithFormat:@"合计 ¥%.2f",model.totalAmount];
    self.data = [model.goodsList mutableCopy];
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
    EFFollowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EFFollowCollectionViewCell class]) forIndexPath:indexPath];
    [cell setModel:self.data[indexPath.row]];
    return cell;
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
