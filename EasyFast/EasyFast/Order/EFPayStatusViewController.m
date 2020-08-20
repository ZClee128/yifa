//
//  EFPayStatusViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/8/3.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFPayStatusViewController.h"
#import "TuanOtherGoodsTableViewCell.h"
#import "EFOrderVM.h"
@interface EFPayStatusViewController ()

@property (nonatomic,strong)UIView *otherView;
@property (nonatomic,strong)NSString *sssNo;
@end

@implementation EFPayStatusViewController


-(UIView *)otherView
{
    if (_otherView == nil) {
        _otherView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kPHONE_WIDTH, WidthOfScale(58))];
        UIImage *left = [UIImage imageWithColor:colorEFEFEF size:CGSizeMake(30, 1) cornerRadius:0];
        UIImage *right = [UIImage imageWithColor:colorEFEFEF size:CGSizeMake(30, 1) cornerRadius:0];
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:left];
        [_otherView addSubview:leftImageView];
        [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(WidthOfScale(107)));
            make.top.equalTo(@(WidthOfScale(35.5)));
        }];
        
        UIImageView *rightImageView = [[UIImageView alloc] initWithImage:right];
        [_otherView addSubview:rightImageView];
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-WidthOfScale(107)));
            make.top.equalTo(@(WidthOfScale(35.5)));
        }];
        
        QMUILabel *titleLab = [[QMUILabel alloc] init];
        titleLab.font = RegularFont14;
        titleLab.textColor = tabbarBlackColor;
        titleLab.text = @"你可能还需要";
        [_otherView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_otherView);
            make.top.equalTo(@(WidthOfScale(30)));
            make.height.equalTo(@(WidthOfScale(13)));
        }];
    }
    return _otherView;
}

- (instancetype)initWithsssNo:(NSString *)sssNo
{
    self = [super init];
    if (self) {
        self.sssNo = sssNo;
    }
    return self;
}

- (void)viewDidLoad {
    self.viewModel = [[EFOrderVM alloc] init];
    [super viewDidLoad];
//    self.gk_backImage = [UIImageMake(@"btn_back_black") qmui_imageWithTintColor:UIColor.whiteColor];
    self.gk_navigationBar.hidden = YES;
    self.gk_navTitle = @"";
    self.gk_navBackgroundColor = UIColor.clearColor;
    self.EFTableView.frame = CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT - TAB_SAFE_HEIGHT);
    self.EFTableView.tableHeaderView = [self headerView];
    [self.EFTableView registerClass:[TuanOtherGoodsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TuanOtherGoodsTableViewCell class])];
     @weakify(self);
    [[((EFOrderVM *)self.viewModel) newGoodsRefreshForDown:self.sssNo] subscribeNext:^(RACTuple *x) {
         @strongify(self);
         self.EFData = [x.first mutableCopy];
         [self.EFTableView reloadData];
     }];
    [self addRefshUp];
}

- (void)loadMoreData {
    @weakify(self);
    [[((EFOrderVM *)self.viewModel) newGoodsRefreshForUp:self.sssNo] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        self.EFData = [x.first mutableCopy];
        [self.EFTableView reloadData];
    }];
}

- (UIView *)headerView {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0,0,kPHONE_WIDTH,WidthOfScale(169));
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = view.frame;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:189/255.0 blue:32/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:56/255.0 blue:56/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    [view.layer addSublayer:gl];
    
    QMUIButton *pay = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [view addSubview:pay];
    [pay setTitle:@"支付成功" forState:(UIControlStateNormal)];
    [pay setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    pay.titleLabel.font = MedFont20;
    [pay setImage:UIImageMake(@"success") forState:(UIControlStateNormal)];
    pay.imagePosition = QMUIButtonImagePositionLeft;
    pay.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WidthOfScale(11));
    [pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(58)));
        make.centerX.equalTo(view);
    }];
    
    QMUIButton *goHome = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [view addSubview:goHome];
    [goHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-WidthOfScale(30)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(89), WidthOfScale(35)));
        make.left.equalTo(@(WidthOfScale(86)));
    }];
    [goHome setTitle:@"返回首页" forState:(UIControlStateNormal)];
    [goHome setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    goHome.titleLabel.font = MedFont13;
    [goHome layoutIfNeeded];
    [goHome AddImageRadiusBorderWithColor:UIColor.whiteColor lineWidth:1 radius:WidthOfScale(35)/2];
    @weakify(self);
    [[goHome rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController qmui_popToRootViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    QMUIButton *lookOrder = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [view addSubview:lookOrder];
    [lookOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-WidthOfScale(30)));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(89), WidthOfScale(35)));
        make.right.equalTo(@(-WidthOfScale(86)));
    }];
    [lookOrder setTitle:@"查看订单" forState:(UIControlStateNormal)];
    [lookOrder setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    lookOrder.titleLabel.font = MedFont13;
    [lookOrder layoutIfNeeded];
    [lookOrder AddImageRadiusBorderWithColor:UIColor.whiteColor lineWidth:1 radius:WidthOfScale(35)/2];
    return view;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.EFData.count % 2 == 0 ? self.EFData.count / 2 : (self.EFData.count) - (self.EFData.count / 2) ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    @weakify(self);
    goodsCell.leftBlock = ^() {
        @strongify(self);
        EFGoodsList *model = self.EFData[indexPath.row*2];
        [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(NO),@"ggNo":model.ggNo}];
    };
    
    goodsCell.rightBlock = ^() {
        @strongify(self);
        EFGoodsList *model = self.EFData[indexPath.row*2+1];
        [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(NO),@"ggNo":model.ggNo}];
    };
    return goodsCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthOfScale(165+72+10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return WidthOfScale(58);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.otherView;
}


@end
