//
//  EFToPayDetailViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/8/3.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFToPayDetailViewController.h"
#import "EFPayTypeTableViewCell.h"
#import "EFOrderVM.h"
#import "EFPayModel.h"
#import "EFPayStatusViewController.h"

@interface EFToPayDetailViewController ()

@property (nonatomic,assign)BOOL isMorePay;
@property (nonatomic,strong)QMUIButton *morePayBtn;
@property (nonatomic,strong)QMUILabel *timeLab;
@property (nonatomic,strong)NSMutableArray *PayArr;

@end

@implementation EFToPayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.EFTableView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT + WidthOfScale(30), kPHONE_WIDTH, kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT - WidthOfScale(60) - TAB_SAFE_HEIGHT - WidthOfScale(30));
    [self.EFTableView registerClass:[EFPayTypeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFPayTypeTableViewCell class])];
    self.PayArr = [[NSArray modelArrayWithClass:[EFPayModel class] json:@[@{@"icon":@"wxpay",@"title":@"微信支付",@"isChoose":@(YES),@"payType":@1},@{@"icon":@"alipay",@"title":@"支付宝",@"isChoose":@(NO),@"payType":@2}]] mutableCopy];
    self.EFTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, 50)];
    [self setBottom];
    [self.view addSubview:self.timeLab];
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kPaySuccessNoti object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        EFPayStatusModel *model = x.object;
        @strongify(self);
        if (model.payState == 2) {
            EFPayStatusViewController *vc = [[EFPayStatusViewController alloc] initWithsssNo:kAppDelegate.sssNo ? kAppDelegate.sssNo : @""];
            [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                
            }];
        }else {
        }
    }];
    
}

- (void)day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
//    XYLog(@"%ld,%ld,%ld,%ld",day,hour,minute,second);
    if (hour == 0 && minute == 0) {
        self.timeLab.text = @"订单已取消";
    }else {
        self.timeLab.text = [NSString stringWithFormat:@"请在%ld时%ld分内支付，逾期订单将自动取消",hour,minute];
    }
}

- (QMUILabel *)timeLab {
    if (_timeLab == nil) {
        _timeLab = [[QMUILabel alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, WidthOfScale(30))];
        _timeLab.font = RegularFont13;
        _timeLab.textColor = colorFE851E;
        _timeLab.backgroundColor = [colorFE851E colorWithAlphaComponent:0.2];
        _timeLab.text = @"订单已取消";
        _timeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLab;
}


- (QMUIButton *)morePayBtn {
    if (_morePayBtn == nil) {
        _morePayBtn = [[QMUIButton alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(40))];
        [_morePayBtn setTitle:@"更多支付方式" forState:(UIControlStateNormal)];
        [_morePayBtn setTitle:@"更多支付方式" forState:(UIControlStateSelected)];
        [_morePayBtn setImage:UIImageMake(@"less_down") forState:(UIControlStateNormal)];
        [_morePayBtn setImage:UIImageMake(@"more_up") forState:(UIControlStateSelected)];
        _morePayBtn.imagePosition = QMUIButtonImagePositionRight;
        _morePayBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(5.5), 0, 0);
        _morePayBtn.titleLabel.font = RegularFont14;
        [_morePayBtn setTitleColor:[tabbarBlackColor colorWithAlphaComponent:0.7] forState:(UIControlStateNormal)];
        [_morePayBtn setTitleColor:[tabbarBlackColor colorWithAlphaComponent:0.7] forState:(UIControlStateSelected)];
        _morePayBtn.backgroundColor = UIColor.whiteColor;
        @weakify(self);
        [[_morePayBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton  *x) {
            x.selected = !x.selected;
            @strongify(self);
            self.isMorePay = x.selected;
            [self.EFTableView reloadData];
        }];
    }
    return _morePayBtn;
}


- (void)setBottom {
    UIView *bg = [[UIView alloc] init];
    [self.view addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-TAB_SAFE_HEIGHT));
        make.height.equalTo(@(WidthOfScale(60)));
        make.width.equalTo(@(kPHONE_WIDTH));
        make.left.equalTo(self.view);
    }];
    bg.backgroundColor = UIColor.whiteColor;
    
    QMUIButton *payBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [payBtn setTitle:@"立即付款" forState:(UIControlStateNormal)];
    payBtn.titleLabel.font = MedFont16;
    [payBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    payBtn.backgroundColor = colorF14745;
    [bg addSubview:payBtn];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bg);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(109.5), WidthOfScale(60)));
        make.bottom.equalTo(bg);
    }];
    @weakify(self);
    [[payBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        for (int i = 0; i < self.PayArr.count; i++) {
            EFPayModel *model = self.PayArr[i];
            if (model.isChoose) {
                kAppDelegate.isPay = YES;
                kAppDelegate.orderNum = self.model.orderNum;
                kAppDelegate.sssNo = self.model.shopNo;
                [[EFOrderVM payForOrder:self.model.orderNum payMethod:model.payType] subscribeNext:^(id  _Nullable x) {
                    
                }];
            }
        }
    }];
    
    QMUILabel *priceLab = [[QMUILabel alloc] init];
    priceLab.font = MedFont16;
    priceLab.textColor = colorF14745;
    priceLab.attributedText = [[NSString stringWithFormat:@"合计：￥%.1f",self.model.totalAmount] getAttributeWithChangeString:@"合计：" ChangeFont:priceLab.font textColor:tabbarBlackColor];
    [bg addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15.5));
        make.centerY.equalTo(bg);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1; //头部
        case 1:
            return self.model.goodsList.count + 1; //商品信息
        case 2:
            return self.priceArr.count; //价格
        default:
            return self.isMorePay ? self.PayArr.count : self.PayArr.count - 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            EFOrderAddressTableViewCell *adCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderAddressTableViewCell class])];
            [adCell setModel:self.model];
            self.addressHeight = [adCell getCellHeight];
            return adCell;
        }
            case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    EFOrderShopTableViewCell *shopCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderShopTableViewCell class])];
                    [shopCell setModel:self.model];
                    shopCell.shopClick = ^{
                        [kH5Manager gotoUrl:@"shop" hasNav:NO navTitle:@"" query:@{@"sssNo":self.model.shopNo}];
                    };
                    return shopCell;
                }
                default:
                {
                    EFOrderDetailGoodsTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFOrderDetailGoodsTableViewCell class])];
                    [goodsCell setModel:self.model.goodsList[indexPath.row - 1]];
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
            default:
        {
            EFPayTypeTableViewCell *timeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFPayTypeTableViewCell class])];
            [timeCell setModel:self.PayArr[indexPath.row]];
            return timeCell;
        }
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
            case 1:
        {
            if (indexPath.row != 0) {
                EFOrderGoodsModel *model = self.model.goodsList[indexPath.row - 1];
                [kH5Manager gotoUrl:@"detail" hasNav:NO navTitle:@"" query:@{@"show":@(NO),@"ggNo":model.goodsNo}];
            }
        }
            break;
        case 3:
        {
            for (int i = 0; i < self.PayArr.count; i++) {
                if (i == indexPath.row) {
                    ((EFPayModel *)self.PayArr[i]).isChoose = YES;
                }else {
                    ((EFPayModel *)self.PayArr[i]).isChoose = NO;
                }
            }
            [self.EFTableView reloadData];
        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            return self.addressHeight;
        }
            case 1:
        {
            switch (indexPath.row) {
                case 0:
                   return WidthOfScale(48);
                default:
                return WidthOfScale(145);
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
            default:
        {
            return WidthOfScale(40);
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.01 : 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return section == 2 ? self.headerView : nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return section == 1 ? self.lineView : (section == 3 ? self.morePayBtn : nil);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 1 ? 20 : (section == 3 ? WidthOfScale(40) : 0.001);
}

@end
