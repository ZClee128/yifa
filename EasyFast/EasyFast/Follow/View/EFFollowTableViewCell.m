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

@property (nonatomic,strong)UIImageView *headerImageView;
@property (nonatomic,strong)QMUILabel *shopNameLab;
@property (nonatomic,strong)QMUILabel *shopClassLab;
@property (nonatomic,strong)QMUILabel *followLab;
@property (nonatomic,strong)QMUILabel *adressLab;
@property (nonatomic,strong)QMUIButton *followBtn;

@end

@implementation EFFollowTableViewCell

-(UIImageView *)headerImageView
{
    if (_headerImageView == nil) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.backgroundColor = colorEFEFEF;
    }
    return _headerImageView;
}

-(QMUILabel *)shopNameLab
{
    if (_shopNameLab == nil) {
        _shopNameLab = [[QMUILabel alloc] init];
        _shopNameLab.font = MedFont16;
        _shopNameLab.textColor = tabbarBlackColor;
        _shopNameLab.textAlignment = NSTextAlignmentLeft;
    }
    return _shopNameLab;
}

-(QMUILabel *)shopClassLab
{
    if (_shopClassLab == nil) {
        _shopClassLab = [[QMUILabel alloc] init];
        _shopClassLab.font = RegularFont13;
        _shopClassLab.textColor = tabbarBlackColor;
        _shopClassLab.textAlignment = NSTextAlignmentLeft;
    }
    return _shopClassLab;
}

-(QMUILabel *)followLab
{
    if (_followLab == nil) {
        _followLab = [[QMUILabel alloc] init];
        _followLab.font = RegularFont12;
        _followLab.textColor = tabbarBlackColor;
        _followLab.textAlignment = NSTextAlignmentLeft;
    }
    return _followLab;
}

-(QMUILabel *)adressLab
{
    if (_adressLab == nil) {
        _adressLab = [[QMUILabel alloc] init];
        _adressLab.font = RegularFont12;
        _adressLab.textColor = tabbarBlackColor;
        _adressLab.textAlignment = NSTextAlignmentRight;
    }
    return _adressLab;
}

-(QMUIButton *)followBtn
{
    if (_followBtn == nil) {
        _followBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_followBtn setTitleColor:colorF14745 forState:(UIControlStateNormal)];
        [_followBtn setTitle:@"关注" forState:(UIControlStateNormal)];
        _followBtn.titleLabel.font = MedFont13;
    }
    return _followBtn;
}


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
        _collect = [[UICollectionView alloc] initWithFrame:CGRectMake(WidthOfScale(15), 10, WidthOfScale(375 - 15), WidthOfScale((375 - 45)/3)) collectionViewLayout:flow];
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
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.collect];
    [self.contentView addSubview:self.headerImageView];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15)));
        make.top.equalTo(@(WidthOfScale(20)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(60), WidthOfScale(60)));
    }];
    [self.headerImageView layoutIfNeeded];
    [self.headerImageView ViewRadius];
    
    
    [self.contentView addSubview:self.shopNameLab];
    [self.shopNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageView.mas_right).equalTo(@(WidthOfScale(15)));
        make.top.equalTo(self.headerImageView.mas_top).equalTo(@(WidthOfScale(3.5)));
        make.width.equalTo(@(WidthOfScale(180)));
        make.height.equalTo(@(WidthOfScale(15.5)));
    }];
    
    [self.contentView addSubview:self.shopClassLab];
    [self.shopClassLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageView.mas_right).equalTo(@(WidthOfScale(15)));
        make.top.equalTo(self.shopNameLab.mas_bottom).equalTo(@(WidthOfScale(6.5)));
        make.width.equalTo(@(WidthOfScale(180)));
        make.height.equalTo(@(WidthOfScale(13.5)));
    }];
    
    [self.contentView addSubview:self.followLab];
    [self.followLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopClassLab.mas_bottom).equalTo(@(WidthOfScale(10)));
        make.left.equalTo(self.headerImageView.mas_right).equalTo(@(WidthOfScale(15)));
        make.width.equalTo(@(WidthOfScale(180)));
        make.height.equalTo(@(WidthOfScale(11.5)));
    }];
    
    [self.contentView addSubview:self.followBtn];
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-WidthOfScale(15)));
        make.top.equalTo(@(WidthOfScale(24)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(90), WidthOfScale(27)));
    }];
    [self.followBtn layoutIfNeeded];
    [self.followBtn AddImageRadiusBorderWithColor:colorF14745 lineWidth:1 radius:4];
    
    
    [self.contentView addSubview:self.adressLab];
    [self.adressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headerImageView);
        make.right.equalTo(@(-WidthOfScale(15)));
        make.height.equalTo(@(WidthOfScale(11.5)));
    }];
    
    [self.collect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.followLab.mas_bottom).equalTo(@(WidthOfScale(20)));
        make.left.equalTo(@(WidthOfScale(15)));
        make.size.mas_equalTo(CGSizeMake( WidthOfScale(375 - 15), WidthOfScale((375 - 45)/3)));
    }];
}


- (void)setModel:(id)model {
    self.shopNameLab.text = @"刘德华的店";
    self.shopClassLab.text = @"男装，女装，内衣";
    self.followLab.text = @"关注数：8255  回头率：60% ";
    self.adressLab.text = @"广东 深圳";
    [self.collect reloadData];
}

#pragma mark - collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EFFollowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EFFollowCollectionViewCell class]) forIndexPath:indexPath];
    [cell setModel:@""];
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
