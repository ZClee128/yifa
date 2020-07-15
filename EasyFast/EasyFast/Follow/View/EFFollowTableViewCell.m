//
//  EFFollowTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFollowTableViewCell.h"
#import "EFFollowCollectionViewCell.h"


@interface EFFollowTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collect;
@property (nonatomic,strong)NSMutableArray *data;

@end

@implementation EFFollowTableViewCell


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
        flow.itemSize = CGSizeMake(WidthOfScale((375 - 45)/3), WidthOfScale((375 - 45)/3));
        _collect = [[UICollectionView alloc] initWithFrame:CGRectMake(WidthOfScale(15), 10, WidthOfScale(375 - 25), WidthOfScale((375 - 45)/3)) collectionViewLayout:flow];
        _collect.backgroundColor = [UIColor clearColor];
        _collect.delegate = self;
        _collect.dataSource = self;
        _collect.showsHorizontalScrollIndicator = NO;
        _collect.showsVerticalScrollIndicator = NO;
        [_collect registerClass:[EFFollowCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([EFFollowCollectionViewCell class])];
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
