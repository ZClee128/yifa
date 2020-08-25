//
//  EFAddressPickerView.m
//  EasyFast
//
//  Created by easyfast on 2020/8/25.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFAddressPickerView.h"

@implementation EFAddressPickerView

- (instancetype)init {
    if (self = [super init]) {
        NSArray *dataSourceArr = [self readLocalFileWithName:@"省市区数据"];
        NSMutableArray *tempArr1 = [NSMutableArray array];
        for (NSDictionary *proviceDic in dataSourceArr) {
            BRProvinceModel *proviceModel = [[BRProvinceModel alloc]init];
            //                proviceModel.code = [proviceDic objectForKey:@"code"];
            proviceModel.name = [proviceDic objectForKey:@"name"];
            proviceModel.index = [dataSourceArr indexOfObject:proviceDic];
            NSArray *cityList = [proviceDic objectForKey:@"city"];
            NSMutableArray *tempArr2 = [NSMutableArray array];
            for (NSDictionary *cityDic in cityList) {
                BRCityModel *cityModel = [[BRCityModel alloc]init];
                //                    cityModel.code = [cityDic objectForKey:@"code"];
                cityModel.name = [cityDic objectForKey:@"name"];
                cityModel.index = [cityList indexOfObject:cityDic];
                NSArray *areaList = [cityDic objectForKey:@"area"];
                NSMutableArray *tempArr3 = [NSMutableArray array];
                for (NSString *areaDic in areaList) {
                    BRAreaModel *areaModel = [[BRAreaModel alloc]init];
                    //                        areaModel.code = [areaDic objectForKey:@"code"];
                    areaModel.name = areaDic;
                    areaModel.index = [areaList indexOfObject:areaDic];
                    [tempArr3 addObject:areaModel];
                }
                cityModel.arealist = [tempArr3 copy];
                [tempArr2 addObject:cityModel];
            }
            proviceModel.citylist = [tempArr2 copy];
            [tempArr1 addObject:proviceModel];
        }
        self.dataSourceArr = tempArr1;
    }
    return self;
}

- (id)readLocalFileWithName:(NSString *)name
{
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    return [NSJSONSerialization JSONObjectWithData:data
                                           options:kNilOptions
                                             error:nil];
}
@end
