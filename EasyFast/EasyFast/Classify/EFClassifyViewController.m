//
//  ClassifyViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/9.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFClassifyViewController.h"
#import "EFClassifyModel.h"
#import "LeftTableViewCell.h"
#import "RightThreeCollectionViewCell.h"
#import "EFClassDetailViewController.h"
#import "EFClassifyVM.h"

@interface EFClassifyViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *leftDataArray;
@property (nonatomic, strong) NSMutableArray *rightDataArray;
@property (nonatomic, strong) EFClassifyModel *currentSelectModel;

@property (nonatomic, strong) RightThreeCollectionViewCell *tempCell;
@end

@implementation EFClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"分类";
    [self initView];
    @weakify(self);
    [[EFClassifyVM category] subscribeNext:^(NSArray *x) {
        @strongify(self);
        self.leftDataArray = [x mutableCopy];
        [self.tableView reloadData];
        if (self.leftDataArray.count > 0) {
            EFClassifyModel *model = [self.leftDataArray objectAtIndex:0];
            self.currentSelectModel = model;
            [self.collectionView scrollToTop];
            [self.collectionView reloadData];
        }
        [[RACScheduler mainThreadScheduler] schedule:^{
           [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:(UITableViewScrollPositionNone)];
        }];
    }];
}

- (void)initView {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
}

-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, WidthOfScale(100), kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LeftTableViewCell class])];
    }
    return _tableView;
}

#pragma mark
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LeftTableViewCell class])];
    [cell setModel:self.leftDataArray[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WidthOfScale(50);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    EFClassifyModel *model = [self.leftDataArray objectAtIndex:indexPath.row];
    self.currentSelectModel = model;
    [self.collectionView scrollToTop];
    [self.collectionView reloadData];
}

#pragma mark
-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.tableView.right, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH - self.tableView.width, self.tableView.height) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceVertical=YES;
        
        [_collectionView registerClass:[RightThreeCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([RightThreeCollectionViewCell class])];
        [_collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FootView"];
    }
    return _collectionView;
}


#pragma mark
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RightThreeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RightThreeCollectionViewCell class]) forIndexPath:indexPath];
    EFClassifyModel *model = [self.rightDataArray objectAtIndex:indexPath.section];
    [cell getCollectionHeight:(NSMutableArray *)model.children];
    [cell reloadData];
    
    @weakify(self);
    [cell selectBlock:^(EFClassifyModel *selectItemId) {
        XYLog(@">>>>%@",selectItemId.title);
        @strongify(self);
        EFClassDetailViewController *vc = [[EFClassDetailViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
            
        }];
    }];
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    self.rightDataArray = [self.currentSelectModel.children mutableCopy];
    return self.rightDataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        UILabel *label = [headerView viewWithTag:666];
        if (!label)
        {
            UILabel *tLabel = [[UILabel alloc] init];
            tLabel.frame = CGRectMake(WidthOfScale(25.5), WidthOfScale(20), headerView.width - WidthOfScale(25.5), WidthOfScale(15));
            tLabel.font = MedFont16;
            tLabel.textColor = tabbarBlackColor;
            tLabel.tag = 666;
            [headerView addSubview:tLabel];
            label = tLabel;
        }
        
        EFClassifyModel *rightModel = [self.rightDataArray objectAtIndex:indexPath.section];
        label.text = rightModel.title;
        
        reusableView = headerView;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        // 底部视图
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FootView" forIndexPath:indexPath];
        
        reusableView = footView;
    }
    
    return reusableView;
}


- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    CGSize size = CGSizeMake(self.collectionView.width, WidthOfScale(50));
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == self.rightDataArray.count)
    {
        CGSize size = CGSizeMake(CGRectGetWidth(self.collectionView.frame), 40.f);
        return size;
    }
    else
    {
        return CGSizeZero;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EFClassifyModel *model = [self.rightDataArray objectAtIndex:indexPath.section];
    CGSize size = CGSizeMake(self.collectionView.width, [self getCellHeight:(NSMutableArray *)model.children]);
    return size;
}

#pragma mark 预算高度
-(CGFloat) getCellHeight:(NSMutableArray *)dataArray
{
    //获取cell 的高度
    return [self.tempCell getCollectionHeight:dataArray];
}

-(RightThreeCollectionViewCell *)tempCell
{
    if (!_tempCell)
    {
        _tempCell = [[RightThreeCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, self.collectionView.width, 1000)];
    }
    return _tempCell;
}

@end
