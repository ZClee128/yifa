//
//  EFClassDetailViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFClassDetailViewController.h"
#import "EFHomeVM.h"

@interface EFClassDetailViewController ()

@property (nonatomic,strong)EFClassifyModel *model;
@end

@implementation EFClassDetailViewController

- (instancetype)initWithModel:(EFClassifyModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    self.viewModel = [[EFHomeVM alloc] init];
    ((EFHomeVM *)self.viewModel).orderBy = @(0);
    [super viewDidLoad];
    self.gk_navTitle = self.model.title;
}

- (void)loadList {
    [[(EFHomeVM *)self.viewModel refreshOtherForDown:self.model.ggcsCode] subscribeNext:^(RACTuple *x) {
        self.data = [x.first mutableCopy];
        [self.collect reloadData];
    }];
}

- (void)setSearch {
    
}

- (UIView *)headerView {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, 45)];
    bg.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bg];
    QMUIButton *leftBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [leftBtn setTitle:@"全部" forState:(UIControlStateNormal)];
    leftBtn.titleLabel.font = RegularFont15;
    [leftBtn setTitleColor:colorF14745 forState:(UIControlStateNormal)];
    leftBtn.selected = YES;
    
    
    QMUIButton *leftMiddleBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [leftMiddleBtn setTitle:@"销量" forState:(UIControlStateNormal)];
    leftMiddleBtn.titleLabel.font = RegularFont15;
    [leftMiddleBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
    
    
    QMUIButton *MiddleBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    MiddleBtn.titleLabel.font = RegularFont15;
    [MiddleBtn setTitle:@"价格" forState:(UIControlStateNormal)];
    [MiddleBtn setImage:knormal forState:(UIControlStateNormal)];
    [MiddleBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
    MiddleBtn.imagePosition = QMUIButtonImagePositionRight;
    
    
    QMUIButton *rightMiddleBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [rightMiddleBtn setTitle:@"新品" forState:(UIControlStateNormal)];
    rightMiddleBtn.titleLabel.font = RegularFont15;
    [rightMiddleBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
    
    
    QMUIButton *rightBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [rightBtn setImage:UIImageMake(@"two") forState:(UIControlStateNormal)];
    [rightBtn setImage:UIImageMake(@"one") forState:(UIControlStateSelected)];
    @weakify(self);
    [[rightBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
        x.selected = !x.selected;
        @strongify(self);
        self.isOne = x.selected;
        if (self.isOne) {
            self.collect.contentInset = UIEdgeInsetsMake(15,0,0,0);
            self.flow.minimumLineSpacing = WidthOfScale(0);
            self.flow.minimumInteritemSpacing = WidthOfScale(0);
            self.flow.itemSize = CGSizeMake(kPHONE_WIDTH, WidthOfScale(155));
        }else {
            self.collect.contentInset = UIEdgeInsetsMake(WidthOfScale(15), WidthOfScale(15), WidthOfScale(15), WidthOfScale(15));
            self.flow.minimumLineSpacing = WidthOfScale(11);
            self.flow.minimumInteritemSpacing = WidthOfScale(10);
            self.flow.itemSize = CGSizeMake(WidthOfScale(167), WidthOfScale(280));
                                            
        }
        [[RACScheduler mainThreadScheduler] schedule:^{
           [self.collect reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }];
    }];
    
    [bg addSubview:leftBtn];
    [bg addSubview:MiddleBtn];
    [bg addSubview:rightBtn];
    [bg addSubview:leftMiddleBtn];
    [bg addSubview:rightMiddleBtn];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.centerY.equalTo(bg);
        make.width.equalTo(@(kPHONE_WIDTH /5));
        make.height.equalTo(bg);
    }];
    
    [leftMiddleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftBtn.mas_right).equalTo(@(0));
        make.centerY.equalTo(bg);
        make.width.equalTo(@(kPHONE_WIDTH /5));
        make.height.equalTo(bg);
    }];
    
    [MiddleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg);
        make.centerY.equalTo(bg);
        make.width.equalTo(@(kPHONE_WIDTH /5));
        make.height.equalTo(bg);
    }];
    
    [rightMiddleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(MiddleBtn.mas_right).equalTo(@(0));
        make.centerY.equalTo(bg);
        make.width.equalTo(@(kPHONE_WIDTH /5));
        make.height.equalTo(bg);
    }];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.centerY.equalTo(bg);
        make.width.equalTo(@(kPHONE_WIDTH /5));
        make.height.equalTo(bg);
    }];
    

    [[leftBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
        @strongify(self);
        [x setTitleColor:colorF14745 forState:(UIControlStateNormal)];
        [leftMiddleBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        [MiddleBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        [MiddleBtn setImage:knormal forState:(UIControlStateNormal)];
        MiddleBtn.selected = NO;
        [rightMiddleBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        ((EFHomeVM *)self.viewModel).orderBy = @0;
        [self loadList];
    }];
    
    [[leftMiddleBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
        @strongify(self);
        [x setTitleColor:colorF14745 forState:(UIControlStateNormal)];
        [leftBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        [MiddleBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        [MiddleBtn setImage:knormal forState:(UIControlStateNormal)];
        MiddleBtn.selected = NO;
        [rightMiddleBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        ((EFHomeVM *)self.viewModel).orderBy = @1;
        [self loadList];
    }];
    
    [[MiddleBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
        @strongify(self);
        x.selected = !x.selected;
        if (x.selected) {
            [x setImage:kup forState:(UIControlStateNormal)];
            [x setTitleColor:colorF14745 forState:(UIControlStateNormal)];
            ((EFHomeVM *)self.viewModel).orderBy = @3;
        }else {
            [x setImage:kdown forState:(UIControlStateNormal)];
            [x setTitleColor:colorF14745 forState:(UIControlStateNormal)];
            ((EFHomeVM *)self.viewModel).orderBy = @2;
        }
        [leftBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        [leftMiddleBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        [rightMiddleBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        [self loadList];
    }];
    
    [[rightMiddleBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
        @strongify(self);
        [x setTitleColor:colorF14745 forState:(UIControlStateNormal)];
        [leftBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        [MiddleBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        [MiddleBtn setImage:knormal forState:(UIControlStateNormal)];
        MiddleBtn.selected = NO;
        [leftMiddleBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
        ((EFHomeVM *)self.viewModel).orderBy = @4;
        [self loadList];
    }];
    return bg;
}

@end
