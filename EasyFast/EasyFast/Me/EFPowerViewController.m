//
//  EFPowerViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFPowerViewController.h"
#import "PowerTableViewCell.h"
#import "SysManager.h"

@interface EFPowerViewController ()
@property (nonatomic,strong)QMUILabel *header;
@property (nonatomic,strong)SysManager *sManager;
@end

@implementation EFPowerViewController

-(QMUILabel *)header
{
    if (_header == nil) {
        _header = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, WidthOfScale(58))];
        _header.font = RegularFont13;
        _header.textColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
        _header.contentEdgeInsets = UIEdgeInsetsMake(0, WidthOfScale(15), 0, WidthOfScale(15));
        _header.numberOfLines = 0;
        _header.text = @"为了向你提供更好优质的服务，易发在特定场景可能需要向您申请以下手机系统权限";
    }
    return _header;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"隐私";
    self.sManager = [SysManager defaultManager];
    [self.EFTableView registerClass:[PowerTableViewCell class] forCellReuseIdentifier:NSStringFromClass([PowerTableViewCell class])];
    self.EFData = [@[@[@"允许易发访问位置信息权限",@"为您提供附近商品，店铺和优惠资讯",[self.sManager locationEnable] < 2 ? @"去授权" : @"已授权"],
                     @[@"允许易发访问相机权限",@"进行扫码，拍摄，直接拍摄上传图片，短视频等",[self.sManager cameraEnable] ? @"已授权" : @"去授权"],
                     @[@"允许易发访问相册权限",@"实现您图片和视频的取用与上传",[self.sManager photoEnable] ? @"已授权" : @"去授权"]] mutableCopy];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.EFData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PowerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PowerTableViewCell class])];
    [cell setModel:self.EFData[indexPath.row]];
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WidthOfScale(88);
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return WidthOfScale(58);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            switch ([self.sManager locationEnable]) {
                case 0:
                {
                    [self.sManager Alert:@"去授权定位服务"];
                }
                    break;
                    case 1:
                {
                    [[[CLLocationManager alloc] init] requestWhenInUseAuthorization];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            if (![self.sManager cameraEnable]) {
                [self.sManager Alert:@"去授权相机服务"];
            }
        }
            break;
        default:
        {
            if (![self.sManager photoEnable]) {
                [self.sManager Alert:@"去授权相册服务"];
            }
            break;
        }
            break;
    }
}

@end
