//
//  EFOrderMoreDetailViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/7/24.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOrderMoreDetailViewController.h"
#import "EFOrderVM.h"
#import "EFLogisticsViewController.h"

@interface EFOrderMoreDetailViewController ()


@property (nonatomic,strong)UIView *otherView;
@property (nonatomic,assign)OrderType type;

@end

@implementation EFOrderMoreDetailViewController

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

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, 20)];
        _lineView.backgroundColor = UIColor.whiteColor;
        UIView *v = [[UIView alloc] init];
        [_lineView addSubview:v];
        v.backgroundColor = RGB16(0xf2f2f2);
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(WidthOfScale(15)));
            make.right.equalTo(@(-WidthOfScale(15)));
            make.bottom.equalTo(@(-0));
            make.height.equalTo(@(1));
        }];
    }
    return _lineView;
}

- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, 10)];
        _headerView.backgroundColor = UIColor.whiteColor;
        
    }
    return _headerView;
}

- (NSMutableArray *)goodsArr {
    if (_goodsArr == nil) {
        _goodsArr = [[NSMutableArray alloc] init];
    }
    return _goodsArr;
}

- (instancetype)initWithType:(OrderType)type {
    if (self = [super init]) {
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    self.viewModel = [[EFOrderVM alloc] init];
    self.viewModel.branches = @(10);
    [super viewDidLoad];
    self.ismore = YES;
    self.gk_navTitle = @"订单详情";
    [self.EFTableView registerClass:[EFWuliuTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFWuliuTableViewCell class])];
    [self.EFTableView registerClass:[EFOrderAddressTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFOrderAddressTableViewCell class])];
    [self.EFTableView registerClass:[EFOrderShopTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFOrderShopTableViewCell class])];
    [self.EFTableView registerClass:[EFOrderDetailGoodsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFOrderDetailGoodsTableViewCell class])];
    [self.EFTableView registerClass:[EFOrderPriceDetailTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFOrderPriceDetailTableViewCell class])];
    [self.EFTableView registerClass:[EFRealPriceTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFRealPriceTableViewCell class])];
    [self.EFTableView registerClass:[EFTimeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFTimeTableViewCell class])];
    [self.EFTableView registerClass:[TuanOtherGoodsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TuanOtherGoodsTableViewCell class])];
    self.timer = [[CountDown alloc] init];
    @weakify(self);
    [[((EFOrderVM *)self.viewModel) newGoodsRefreshForDown:self.model.shopNo] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        self.EFData = [x.first mutableCopy];
        [self.EFTableView reloadData];
    }];
    
    [[EFOrderVM myOrderDetailExpressNum:self.model.expressNum orderNum:self.model.orderNum] subscribeNext:^(EFOrderModel *x) {
        @strongify(self);
        self.priceArr = [@[@[@"商品价格",[NSString stringWithFormat:@"¥ %.1f",x.goodsAmount]],@[@"运费",[NSString stringWithFormat:@"¥ %.f",x.postageAmount]],@[@"商品总价",[NSString stringWithFormat:@"¥ %.1f",x.goodsTotalAmount]],@[@"实付款",[NSString stringWithFormat:@"¥ %.1f",x.totalAmount]]] mutableCopy];
        self.orderArr = [@[@[@"订单编号：",x.orderNum ? x.orderNum : @""],@[@"交易方式：",x.payMethod ? (x.payMethod == 1 ? @"微信支付" : @"支付宝支付") : @""],@[@"创建时间：",x.createTime ? x.createTime : @""],@[@"付款时间：",x.payTime ? x.payTime : @""],@[@"发货时间：",x.deliverTime ? x.deliverTime : @""]] mutableCopy];
        self.goodsArr = [x.goodsList mutableCopy];
        self.model = x;
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        NSTimeZone *zone = [NSTimeZone systemTimeZone];
//        [formatter setTimeZone:zone];
//        NSDate *date = [formatter dateFromString:x.createTime];
//        NSInteger interval = [zone secondsFromGMTForDate: date];
//        NSDate *localeDate = [date dateByAddingTimeInterval: interval];
        [self.timer countDownWithStratDate:x.currentTime finishDate:x.endTime completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
            [self day:day hour:hour minute:minute second:second];
        }];
        [self.EFTableView reloadData];
    }];
    
}

- (void )pleaseInsertStarTimeo:(NSDate *)time1 andInsertEndTime:(NSDate *)time2{
    // 2.创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 3.利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:type fromDate:time1 toDate:time2 options:0];
    // 4.输出结果
    XYLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer destoryTimer];
}


- (void)day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return  2; //头部
        case 1:
            return self.goodsArr.count + 1; //商品信息
        case 2:
            return self.priceArr.count; //价格
        case 3:
            return self.orderArr.count;
        default:
            return self.EFData.count % 2 == 0 ? self.EFData.count / 2 : (self.EFData.count) - (self.EFData.count / 2) ;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    EFWuliuTableViewCell *wuCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFWuliuTableViewCell class])];
                    [wuCell setModel:self.model];
                    self.wuliHeight = [wuCell getCellHeight];
                    self.type == OrderTypeSend ? [wuCell setHidden:YES] : [wuCell setHidden:NO];
                    return wuCell;
                }
                default:
                {
                    EFOrderAddressTableViewCell *adCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderAddressTableViewCell class])];
                    [adCell setModel:self.model];
                    self.addressHeight = [adCell getCellHeight];
                    return adCell;
                }
            }
        }
            case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    EFOrderShopTableViewCell *shopCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderShopTableViewCell class])];
                    [shopCell setModel:self.model];
                    return shopCell;
                }
                default:
                {
                    EFOrderDetailGoodsTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderDetailGoodsTableViewCell class])];
                    [goodsCell setModel:self.goodsArr[indexPath.row - 1]];
                    return goodsCell;
                }
            }
        }
            case 2:
        {
            if (self.priceArr.count - 1 == indexPath.row) {
                EFRealPriceTableViewCell *realCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFRealPriceTableViewCell class])];
                [realCell setModel:self.priceArr[indexPath.row]];
                @weakify(self);
                realCell.moreClick = ^(QMUIButton * _Nonnull x) {
                    @strongify(self);
                    self.ismore = !x.selected;
                    [[RACScheduler mainThreadScheduler] schedule:^{
                       [self.EFTableView reloadData];
                    }];
                };
                return realCell;
            }else {
                EFOrderPriceDetailTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderPriceDetailTableViewCell class])];
                [detailCell setModel:self.priceArr[indexPath.row]];
                if (self.ismore) {
                    detailCell.hidden = NO;
                }else {
                    indexPath.row == 1 ? (detailCell.hidden = YES) : (detailCell.hidden = NO);
                }
                return detailCell;
            }
        }
            case 3:
        {
            EFTimeTableViewCell *timeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFTimeTableViewCell class])];
            [timeCell setModel:self.orderArr[indexPath.row]];
            indexPath.row == 0 ? ([timeCell showCopy]) : ([timeCell hiddenCopy]);
            return timeCell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            EFLogisticsViewController *vc = [[EFLogisticsViewController alloc] initWithExpressNum:self.model];
            [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                
            }];
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    return self.type == OrderTypeSend ? 0 : self.wuliHeight;
                default:
                    return self.addressHeight;
            }
        }
            case 1:
        {
            switch (indexPath.row) {
                case 0:
                   return WidthOfScale(48);
                default:
                return WidthOfScale(110);
            }
        }
        case 2: {
            if (self.priceArr.count - 1 == indexPath.row) {
                return WidthOfScale(39);
            }else {
                if (self.ismore) {
                   return WidthOfScale(21.5);
                }else {
                   return indexPath.row == 1 ? 0 : WidthOfScale(21.5);
                }
            }
        }
            case 3:
        {
            return WidthOfScale(22.5);
        }
        default:
            return WidthOfScale(165+72+10);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 3 ? 36 : (section == 4 ? WidthOfScale(58) : 10);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    QMUILabel *orderlab = [self.EFTableView viewWithTag:400];
    if (orderlab == nil) {
        orderlab = [[QMUILabel alloc] init];
        orderlab.font = RegularFont15;
        orderlab.textColor = tabbarBlackColor;
        orderlab.text = @"订单信息";
        orderlab.textAlignment = NSTextAlignmentLeft;
        orderlab.contentEdgeInsets = UIEdgeInsetsMake(WidthOfScale(15), WidthOfScale(15), WidthOfScale(8), 0);
        orderlab.backgroundColor = UIColor.whiteColor;
        orderlab.tag = 400;
    }
    return section == 2 ? self.headerView : (section == 3 ? orderlab : (section == 4 ? self.otherView : nil));
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return section == 1 ? self.lineView : nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 1 ? 0.001 : (section == 2 ? 10 : 0.001 );
}
@end
