//
//  EFHotViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/14.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFHotViewController.h"
#import "HotTabTableViewCell.h"
#import "EFNoticeTableViewCell.h"
#import "EFHeaderView.h"
#import "EFFastTableViewCell.h"
#import "EFGoodsTableViewCell.h"

@interface EFHotViewController ()

@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong)EFHeaderView *fastHeader;
@property (nonatomic,strong)EFHeaderView *wholesaleHeader;
@end

@implementation EFHotViewController

-(EFHeaderView *)wholesaleHeader
{
    if (_wholesaleHeader == nil) {
        _wholesaleHeader = [[EFHeaderView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, 53) WithLeftTitle:@"企业批发" WithRightTitle:@""];
        UILabel *left = [_wholesaleHeader getLeftLab];
        [left mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(23));
            make.height.equalTo(@(17));
            make.left.equalTo(@(15));
        }];
    }
    return _wholesaleHeader;
}

-(EFHeaderView *)fastHeader
{
    if (_fastHeader == nil) {
        _fastHeader = [[EFHeaderView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, 53) WithLeftTitle:@"急速拼团" WithRightTitle:@"查看全部"];
    }
    return _fastHeader;
}

-(SDCycleScrollView *)cycleScrollView
{
    if (_cycleScrollView == nil) {
        _cycleScrollView = [[SDCycleScrollView alloc] init];
        _cycleScrollView.imageURLStringsGroup = @[@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2534506313,1688529724&fm=26&gp=0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594728792946&di=fabd7794eceddbb636e467cf18d0cff5&imgtype=0&src=http%3A%2F%2Fa0.att.hudong.com%2F56%2F12%2F01300000164151121576126282411.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594728792946&di=1ef1413038217b1bd81cda61678112d8&imgtype=0&src=http%3A%2F%2Fa1.att.hudong.com%2F05%2F00%2F01300000194285122188000535877.jpg"];
        _cycleScrollView.currentPageDotImage = [UIImage imageWithColor:UIColor.whiteColor size:CGSizeMake(20, 4) cornerRadius:2];
        _cycleScrollView.pageDotImage = [UIImage imageWithColor:UIColorFromRGBA(0xf5f5f5, 0.5) size:CGSizeMake(20, 4) cornerRadius:2];
    }
    return _cycleScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navigationBar.hidden = YES;
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT-NAVIGATION_BAR_HEIGHT-30-TAB_BAR_HEIGHT);
    self.EFTableView.tableHeaderView = [self headerView];
    [self.EFTableView registerClass:[HotTabTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HotTabTableViewCell class])];
    [self.EFTableView registerClass:[EFNoticeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFNoticeTableViewCell class])];
    [self.EFTableView registerClass:[EFFastTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFFastTableViewCell class])];
    [self.EFTableView registerClass:[EFGoodsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFGoodsTableViewCell class])];
    [self addRefshDown];
}

- (UIView *)headerView {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(130))];
    bg.backgroundColor = colorfafafa;
    [bg addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(15)));
        make.width.equalTo(@(WidthOfScale(345)));
        make.height.equalTo(@(WidthOfScale(120)));
        make.top.equalTo(@(WidthOfScale(10)));
    }];
    [self.cycleScrollView layoutIfNeeded];
    [self.cycleScrollView ViewRadius:5];
    return bg;
}

// 返回列表视图
// 如果列表是VC，就返回VC.view
// 如果列表是View，就返回View自己
- (UIView *)listView {
    return self.view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 3:
            return 10;
        default:
            return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            HotTabTableViewCell *hotCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HotTabTableViewCell class])];
            [hotCell setCollectData:[@[@1,@2,@3,@4,@1,@2,@3,@4] mutableCopy]];
            return hotCell;
        }
        case 1:
        {
            EFNoticeTableViewCell *noticeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFNoticeTableViewCell class])];
            return noticeCell;
        }
            case 2:
        {
            EFFastTableViewCell *fastCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFFastTableViewCell class])];
            [fastCell setCollectData:[@[@1,@2,@3,@4] mutableCopy]];
            return fastCell;
        }
        default:
        {
            EFGoodsTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFGoodsTableViewCell class])];
            [goodsCell setModel:@""];
            return goodsCell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            
            return WidthOfScale(208);//WidthOfScale(107.5);
            case 1:
        {
            return WidthOfScale(30);
        }
            case 2:
        {
            return 140+14.5+16+8+15+20;
        }
        default:
            return WidthOfScale(140)+15;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 2:
        {
            return self.fastHeader;
        }
        case 3:
        {
            return self.wholesaleHeader;
        }
        default:
            return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 2:
            return WidthOfScale(52);
        case 3:
        {
            return WidthOfScale(52);
        }
        default:
            return 0.001;
    }
}

@end
