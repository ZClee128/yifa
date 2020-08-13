//
//  TuanListDetailViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "TuanListDetailViewController.h"
#import "TuanListDetailSecsionView.h"
#import "TuanListDetailTableViewCell.h"
#import "TuanOtherGoodsTableViewCell.h"
#import "EFTeamVM.h"
#import "EFOrderVM.h"
#import "TuanGoodsView.h"
@interface TuanListDetailViewController ()

@property(nonatomic,strong)TuanListDetailSecsionView *secsionView;
@property (nonatomic,strong)QMUIButton *moreBtn;
@property (nonatomic,strong)UIView *otherView;
@property (nonatomic,strong)QMUIButton *buyBtn;
@property (nonatomic,strong)NSString *ggNO;
@property (nonatomic,strong)NSString *ootNo;
@property (nonatomic,strong)EFTeamGoodsModel *model;
@property (nonatomic,strong)EFTeamListModel *teamModel;
@property (nonatomic,strong)TuanGoodsView *goodsHeaderView;
@end

@implementation TuanListDetailViewController

-(QMUIButton *)buyBtn
{
    if (_buyBtn == nil) {
        _buyBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_buyBtn setTitle:@"立即拼单" forState:(UIControlStateNormal)];
        [_buyBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
        _buyBtn.titleLabel.font = MedFont15;
        _buyBtn.backgroundColor = colorF14745;
        [[_buyBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(YES),@"ggNo":self.ggNO}];
        }];
    }
    return _buyBtn;
}

-(UIView *)otherView
{
    if (_otherView == nil) {
        _otherView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kPHONE_WIDTH, WidthOfScale(48))];
        UIImage *left = [UIImage imageWithColor:colorEFEFEF size:CGSizeMake(30, 1) cornerRadius:0];
        UIImage *right = [UIImage imageWithColor:colorEFEFEF size:CGSizeMake(30, 1) cornerRadius:0];
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:left];
        [_otherView addSubview:leftImageView];
        [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(WidthOfScale(107)));
            make.top.equalTo(@(WidthOfScale(26)));
        }];
        
        UIImageView *rightImageView = [[UIImageView alloc] initWithImage:right];
        [_otherView addSubview:rightImageView];
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-WidthOfScale(107)));
            make.top.equalTo(@(WidthOfScale(26)));
        }];
        
        QMUILabel *titleLab = [[QMUILabel alloc] init];
        titleLab.font = RegularFont14;
        titleLab.textColor = tabbarBlackColor;
        titleLab.text = @"其他人还买了";
        [_otherView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_otherView);
            make.centerY.equalTo(_otherView);
            make.height.equalTo(@(WidthOfScale(13.5)));
        }];
    }
    return _otherView;
}

-(TuanListDetailSecsionView *)secsionView
{
    if (_secsionView == nil) {
        _secsionView = [[TuanListDetailSecsionView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(48))];
        [_secsionView setModel:@""];
    }
    return _secsionView;
}

-(QMUIButton *)moreBtn
{
    if (_moreBtn == nil) {
        _moreBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_moreBtn setTitle:@"收起" forState:(UIControlStateSelected)];
        [_moreBtn setTitle:@"展开全部" forState:(UIControlStateNormal)];
        [_moreBtn setTitleColor:colorAEAEAE forState:(UIControlStateNormal)];
        [_moreBtn setTitleColor:colorAEAEAE forState:(UIControlStateSelected)];
        _moreBtn.titleLabel.font = RegularFont14;
        [_moreBtn setImage:UIImageMake(@"less_down") forState:(UIControlStateNormal)];
        [_moreBtn setImage:UIImageMake(@"more_up") forState:(UIControlStateSelected)];
        _moreBtn.selected = YES;
        _moreBtn.frame = CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(32.5));
        _moreBtn.imagePosition = QMUIButtonImagePositionRight;
        _moreBtn.backgroundColor = UIColor.whiteColor;
        _moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(5.5), 0, 0);
        @weakify(self);
        [[_moreBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
            x.selected = !x.selected;
            @strongify(self);
            [self.EFTableView reloadData];
        }];
    }
    return _moreBtn;
}

- (instancetype)initWithGGNo:(NSString *)ggNO ootNo:(NSString *)ootNo model:(EFTeamGoodsModel *)model
{
    self = [super init];
    if (self) {
        self.ggNO = ggNO;
        self.ootNo = ootNo;
        self.model = model;
    }
    return self;
}

-(TuanGoodsView *)goodsHeaderView
{
    if (_goodsHeaderView == nil) {
        _goodsHeaderView = [[TuanGoodsView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(180))];
    }
    return _goodsHeaderView;
}

- (void)viewDidLoad {
    self.viewModel = [[EFOrderVM alloc] init];
    [super viewDidLoad];
    self.gk_navTitle = @"拼团详情";
    self.EFTableView.y = NAVIGATION_BAR_HEIGHT;
    self.EFTableView.height = kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT - WidthOfScale(60) - TAB_SAFE_HEIGHT;
    [self.EFTableView registerClass:[TuanListDetailTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TuanListDetailTableViewCell class])];
    [self.EFTableView registerClass:[TuanOtherGoodsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TuanOtherGoodsTableViewCell class])];
    [self.view addSubview:self.buyBtn];
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-TAB_SAFE_HEIGHT));
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(WidthOfScale(60)));
        make.width.equalTo(@(kPHONE_WIDTH));
    }];
    [self.goodsHeaderView setModel:self.model];
    self.EFTableView.tableHeaderView = self.goodsHeaderView;
    [self addRefshDown];
    [self loadNewData];
}

- (void)loadNewData {
    @weakify(self);
    [[EFTeamVM teamInfo:self.ootNo] subscribeNext:^(EFTeamListModel *x) {
        @strongify(self);
        [self.EFTableView.mj_header endRefreshing];
        self.teamModel = x;
        [self.EFTableView reloadData];
    }];
    [[((EFOrderVM *)self.viewModel) newGoodsRefreshForDown:self.model.sssNo] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        [self.EFTableView.mj_header endRefreshing];
        self.EFData = [x.first mutableCopy];
        [self.EFTableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return self.moreBtn.selected ? self.teamModel.teamOrderDtoList.count : (self.teamModel.teamOrderDtoList.count <= 3 ? self.teamModel.teamOrderDtoList.count : 3);
        }
        default:
        {
            return self.EFData.count % 2 == 0 ? self.EFData.count / 2 : (self.EFData.count) - (self.EFData.count / 2) ;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            TuanListDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TuanListDetailTableViewCell class])];
            [cell setModel:self.teamModel.teamOrderDtoList[indexPath.row]];
            return cell;
        }
        default:
        {
            TuanOtherGoodsTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TuanOtherGoodsTableViewCell class])];
            if (self.EFData.count % 2 == 0) {
                [goodsCell setLeftModel:self.EFData[indexPath.row*2]];
                [goodsCell setRightModel:self.EFData[indexPath.row*2+1]];
                [goodsCell showRightView];
            }else {
                if (indexPath.row == (self.EFData.count) - (self.EFData.count / 2) - 1) {
                    [goodsCell setLeftModel:self.EFData[indexPath.row*2]];
                    [goodsCell hiddenRightView];
                }else {
                    [goodsCell setLeftModel:self.EFData[indexPath.row*2]];
                    [goodsCell setRightModel:self.EFData[indexPath.row*2+1]];
                    [goodsCell showRightView];
                }
            }
            return goodsCell;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            return WidthOfScale(40);
        }
        default:
            return  WidthOfScale(165+72+10);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
    case 0:
        return WidthOfScale(50);
    default:
        return WidthOfScale(48);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.secsionView;
        default:
            return self.otherView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return self.moreBtn;
        }
        default:
            return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return WidthOfScale(32.5);
        default:
            return 0.001;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
