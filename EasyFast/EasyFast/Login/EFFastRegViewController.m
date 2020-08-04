//
//  EFFastRegViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/7/27.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFastRegViewController.h"
#import "EFPhoneTableViewCell.h"
#import "EFCodeTableViewCell.h"
#import "LoginVM.h"
#import "EFEditPasswordViewController.h"

@interface EFFastRegViewController ()


@property (nonatomic,strong)QMUIButton *clickBrn;
@property (nonatomic,strong)YYLabel *contentLab;
@property (nonatomic,strong)UIView *footerView;

@end

@implementation EFFastRegViewController


-(QMUIButton *)nextBtn
{
    if (_nextBtn == nil) {
        _nextBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [_nextBtn setTitle:@"注册" forState:(UIControlStateNormal)];
        [_nextBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
        _nextBtn.titleLabel.font = MedFont15;
        @weakify(self);
        [[_nextBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [[LoginVM userregister:self.phoneText code:self.codeStr] subscribeNext:^(NSNumber *x) {
                if ([x boolValue]) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }];
        }];
    }
    return _nextBtn;
}


- (UIView *)footerView {
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT - WidthOfScale(163.5))];
        self.clickBrn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
        [self.clickBrn setImage:UIImageMake(@"gou_def") forState:(UIControlStateNormal)];
        [self.clickBrn setImage:UIImageMake(@"gou_select") forState:(UIControlStateSelected)];
        [[self.clickBrn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(QMUIButton *x) {
            x.selected = !x.selected;
        }];
        [_footerView addSubview:self.clickBrn];
        [self.clickBrn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(WidthOfScale(15.5)));
            make.left.equalTo(@(WidthOfScale(15)));
        }];
        self.clickBrn.qmui_outsideEdge = UIEdgeInsetsMake(-20, -20, -20, -20);
        
        self.contentLab = [[YYLabel alloc] init];
        self.contentLab.font = RegularFont13;
        self.contentLab.textColor = tabbarBlackColor;
        self.contentLab.numberOfLines = 0;
        self.contentLab.textAlignment = NSTextAlignmentLeft;
        NSString * str = @"根据易发平台服务条款，为保证您的退款快速到账，请查看《易发退款协议》";
        NSMutableAttributedString *muAtt = [[NSMutableAttributedString alloc] initWithString:str];
        
        [muAtt addAttribute:NSFontAttributeName value:RegularFont13 range:NSMakeRange(0, muAtt.length)];
        muAtt.lineSpacing = 5;
        NSRange range = [str rangeOfString:@"《易发退款协议》"];
        NSRange pointRange = NSMakeRange(range.location, range.length);
        [muAtt setTextHighlightRange:pointRange
                               color:RGB16(0x499AFF)
                     backgroundColor:self.contentLab.backgroundColor
                           tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            NSLog(@"%@",[NSString stringWithFormat:@"Tap: %@", [text.string substringWithRange:range]]);
        }];
        self.contentLab.attributedText = muAtt;
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - WidthOfScale(59), MAXFLOAT);
        
        //计算文本尺寸
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:maxSize text:muAtt];
        self.contentLab.textLayout = layout;
        [_footerView addSubview:self.contentLab];
        [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(WidthOfScale(16)));
            make.left.equalTo(@(WidthOfScale(38.5)));
            make.right.equalTo(@(-WidthOfScale(20.5)));
            make.height.equalTo(@(layout.textBoundingSize.height));
        }];
        
        [_footerView addSubview:self.nextBtn];
        [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLab.mas_bottom).equalTo(@(WidthOfScale(30)));
            make.centerX.equalTo(_footerView);
            make.size.mas_equalTo(CGSizeMake(WidthOfScale(345), WidthOfScale(50)));
        }];
        
        [self.nextBtn layoutIfNeeded];
        [self.nextBtn ViewRadius:5];
        
        
        
        @weakify(self);
        RAC(self.nextBtn,userInteractionEnabled) =  [RACSignal combineLatest:@[RACObserve(self,self.phoneText),RACObserve(self,self.codeStr),RACObserve(self, self.clickBrn.selected)] reduce:^id _Nonnull(NSString *phone,NSString *code, NSNumber *select){
            @strongify(self);
            BOOL enabled = phone.length == 11 && code.length == 6 && [select boolValue];
            if (!enabled) {
                btnGradation(self.nextBtn,[colorF14745 colorWithAlphaComponent:0.6]);
            }else {
                btnGradation(self.nextBtn,colorF14745);
            }
            return @(enabled);
        }];
        
    }
    return _footerView;
}


- (void)viewDidLoad {
    self.viewModel = [[LoginVM alloc] init];
    [super viewDidLoad];
    self.phoneText = @"";
    self.codeStr = @"";
    self.EFTableView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, kPHONE_HEIGHT - NAVIGATION_BAR_HEIGHT);
    self.gk_navTitle = @"快速注册";
    [self.EFTableView registerClass:[EFPhoneTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFPhoneTableViewCell class])];
    [self.EFTableView registerClass:[EFCodeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFCodeTableViewCell class])];
    
    self.EFTableView.tableFooterView = self.footerView;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            EFPhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFPhoneTableViewCell class])];
            [cell setModel:@"手机号"];
            @weakify(self);
            cell.TextValue = ^(NSString * _Nonnull text) {
                @strongify(self);
                self.phoneText = text;
            };
            return cell;
        }
        default:
        {
            EFCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFCodeTableViewCell class])];
            [cell setModel:@"验证码"];
            @weakify(self);
            cell.TextValue = ^(NSString * _Nonnull text) {
                @strongify(self);
                self.codeStr = text;
            };
            cell.CodeBlock = ^(QMUIButton * _Nonnull btn) {
                @strongify(self);
                [(LoginVM *)self.viewModel getCodeWithBtn:btn withType:2 phone:self.phoneText];
            };
            
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthOfScale(50);
}
@end



#pragma EFFindPasswrodViewController

@interface EFFindPasswrodViewController ()

@end

@implementation EFFindPasswrodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneText = @"";
    self.codeStr = @"";
    self.gk_navTitle = @"找回密码";
    
}

- (UIView *)footerView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, kPHONE_HEIGHT - WidthOfScale(80))];
    
    [footerView addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WidthOfScale(30)));
        make.centerX.equalTo(footerView);
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(345), WidthOfScale(50)));
    }];
    
    [self.nextBtn layoutIfNeeded];
    [self.nextBtn ViewRadius:5];
    
    
    [self.nextBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
    @weakify(self);
    RAC(self.nextBtn,userInteractionEnabled) =  [RACSignal combineLatest:@[RACObserve(self,self.phoneText),RACObserve(self,self.codeStr)] reduce:^id _Nonnull(NSString *phone,NSString *code){
        @strongify(self);
        BOOL enabled = phone.length == 11 && code.length == 6;
        if (!enabled) {
            btnGradation(self.nextBtn,[colorF14745 colorWithAlphaComponent:0.6]);
        }else {
            btnGradation(self.nextBtn,colorF14745);
        }
        return @(enabled);
    }];
    
    [[self.nextBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        EFSetNewPasswordViewController *vc = [[EFSetNewPasswordViewController alloc] init];
        [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
            
        }];
    }];
    return footerView;
}

@end
