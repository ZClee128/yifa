//
//  EFMeDataViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFMeDataViewController.h"
#import "EFSetUpTableViewCell.h"

@interface EFMeDataViewController ()
@property (nonatomic,strong)UIView *otherView;
@end

@implementation EFMeDataViewController

-(UIView *)otherView
{
    if (_otherView == nil) {
        _otherView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kPHONE_WIDTH, WidthOfScale(74))];
        UIImage *left = [UIImage imageWithColor:colorEFEFEF size:CGSizeMake(30, 1) cornerRadius:0];
        UIImage *right = [UIImage imageWithColor:colorEFEFEF size:CGSizeMake(30, 1) cornerRadius:0];
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:left];
        [_otherView addSubview:leftImageView];
        [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(WidthOfScale(107)));
            make.centerY.equalTo(_otherView);
        }];
        
        UIImageView *rightImageView = [[UIImageView alloc] initWithImage:right];
        [_otherView addSubview:rightImageView];
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-WidthOfScale(107)));
            make.centerY.equalTo(_otherView);
        }];
        
        QMUILabel *titleLab = [[QMUILabel alloc] init];
        titleLab.font = RegularFont14;
        titleLab.textColor = colorAEAEAE;
        titleLab.text = @"没有更多啦";
        [_otherView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_otherView);
            make.centerY.equalTo(_otherView);
            make.height.equalTo(@(WidthOfScale(13.5)));
        }];
    }
    return _otherView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"个人资料";
    [self.EFTableView registerClass:[EFSetUpTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EFSetUpTableViewCell class])];
    self.EFData = [@[@{@"title":@"头像",@"subTitle":@"",@"header":@""},
                     @{@"title":@"昵称",@"subTitle":@"昵称最多四个字",@"header":@""},
                     @{@"title":@"性别",@"subTitle":@"男",@"header":@""},
                     @{@"title":@"地区",@"subTitle":@"广东  深圳",@"header":@""},
                     @{@"title":@"绑定手机",@"subTitle":@"13999999999",@"header":@""},
                     @{@"title":@"绑定微信号",@"subTitle":@"easyfast-shenzhen",@"header":@""},
                     @{@"title":@"实名认证",@"subTitle":@"未认证",@"header":@""},
                     ] mutableCopy];
    self.EFTableView.tableFooterView = self.otherView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.EFData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFSetUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EFSetUpTableViewCell class])];
    NSDictionary *dict = self.EFData[indexPath.row];
    [cell setModel:dict];
    indexPath.row == 0 ? [cell showHeader] : [cell hiddenHeader];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthOfScale(60);
}



@end
