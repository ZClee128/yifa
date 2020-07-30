//
//  EFMapViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/7/30.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFMapViewController.h"

/**
 *  百度api
 */
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface EFMapViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    BMKPinAnnotationView *newAnnotation;
    
    BMKGeoCodeSearch *_geoCodeSearch;
    
    BMKReverseGeoCodeOption *_reverseGeoCodeOption;

    BMKLocationService *_locService;
    

    
}

@property (strong, nonatomic)  BMKMapView *mapView;
@property (strong, nonatomic)  UIButton *mapPin;

@property (strong, nonatomic) UITableView *cityTableview;


@property(nonatomic,strong)NSMutableArray *cityDataArr;

@end

@implementation EFMapViewController

-(NSMutableArray *)cityDataArr
{
    if (_cityDataArr==nil)
    {
        _cityDataArr=[NSMutableArray arrayWithCapacity:0];
    }
    
    return _cityDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"定位地址";
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kPHONE_WIDTH, WidthOfScale(200))];
    [self.view addSubview:self.mapView];
    
    self.cityTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+WidthOfScale(200), kPHONE_WIDTH, kPHONE_HEIGHT - WidthOfScale(200)-NAVIGATION_BAR_HEIGHT)];
    [self.view addSubview:self.cityTableview];
    self.cityTableview.delegate = self;
    self.cityTableview.dataSource = self;
    
    self.mapPin = [[UIButton alloc] init];
    [self.mapView addSubview:self.mapPin];
    [self.mapPin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.mapView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.mapPin setImage:UIImageMake(@"serach_Map") forState:(UIControlStateNormal)];
    [self initLocationService];
}

#pragma mark  tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cityDataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    cityModel *model=self.cityDataArr[indexPath.row];
    
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.address;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.seletCity) {
        self.seletCity(self.cityDataArr[indexPath.row]);
        [self.navigationController qmui_popViewControllerAnimated:YES completion:^{
            
        }];
    }
}

#pragma mark 设置cell分割线做对齐
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews {
    
    if ([self.cityTableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.cityTableview setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.cityTableview respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.cityTableview setLayoutMargins:UIEdgeInsetsZero];
    }
    
}


//#pragma mark 初始化地图，定位
-(void)initLocationService
{

    [_mapView setMapType:BMKMapTypeStandard];// 地图类型 ->卫星／标准、

    _mapView.zoomLevel=17;
    _mapView.delegate=self;
    _mapView.showsUserLocation = YES;

    [_mapView bringSubviewToFront:_mapPin];


    if (_locService==nil) {

        _locService = [[BMKLocationService alloc]init];

        [_locService setDesiredAccuracy:kCLLocationAccuracyBest];
    }

    _locService.delegate = self;
    [_locService startUserLocationService];


    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层

}

#pragma mark BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    _mapView.showsUserLocation = YES;//显示定位图层
    //设置地图中心为用户经纬度
    [_mapView updateLocationData:userLocation];


    //    _mapView.centerCoordinate = userLocation.location.coordinate;
    BMKCoordinateRegion region ;//表示范围的结构体
    region.center = _mapView.centerCoordinate;//中心点
    region.span.latitudeDelta = 0.004;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
    region.span.longitudeDelta = 0.004;//纬度范围
    [_mapView setRegion:region animated:YES];

}

#pragma mark BMKMapViewDelegate
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //屏幕坐标转地图经纬度
    CLLocationCoordinate2D MapCoordinate=[_mapView convertPoint:_mapPin.center toCoordinateFromView:_mapView];

    if (_geoCodeSearch==nil) {
        //初始化地理编码类
        _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
        _geoCodeSearch.delegate = self;

    }
    if (_reverseGeoCodeOption==nil) {

        //初始化反地理编码类
        _reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
    }

    //需要逆地理编码的坐标位置
    _reverseGeoCodeOption.reverseGeoPoint =MapCoordinate;
    [_geoCodeSearch reverseGeoCode:_reverseGeoCodeOption];

}

#pragma mark BMKGeoCodeSearchDelegate
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //获取周边用户信息
    if (error==BMK_SEARCH_NO_ERROR) {

        [self.cityDataArr removeAllObjects];
        for(BMKPoiInfo *poiInfo in result.poiList)
        {
            cityModel *model=[[cityModel alloc]init];
            model.name=poiInfo.name;
            model.address=poiInfo.address;

            [self.cityDataArr addObject:model];
            [self.cityTableview reloadData];
        }
    }else{

        NSLog(@"BMKSearchErrorCode: %u",error);
    }

}

@end
