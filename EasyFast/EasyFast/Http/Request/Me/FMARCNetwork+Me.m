//
//  FMARCNetwork+Me.m
//  EasyFast
//
//  Created by easyfast on 2020/8/5.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "FMARCNetwork+Me.h"

@implementation FMARCNetwork (Me)

- (RACSignal *)updateUserInfo:(NSString *)city headImgUrl:(NSString *)headImgUrl nickname:(NSString *)nickname province:(NSString *)province sex:(NSInteger)sex type:(NSInteger)type{
    return [self fg_postRequest:kupdateUserInfo paramters:@{@"city":city,@"headImgUrl":headImgUrl,@"nickname":nickname,@"province":province,@"sex":@(sex),@"type":@(type)}];
}

- (RACSignal *)updatePassWord:(NSString *)oldPassword password:(NSString *)password confirmPassword:(NSString *)confirmPassword {
    return [self fg_postRequest:kupdatePassWord paramters:@{@"oldPassword":oldPassword.md5,@"password":password.md5,@"confirmPassword":confirmPassword.md5}];
}

- (RACSignal *)goodsMonthFootprint {
    return [self fg_getRequest:kgoodsMonthFootprint paramters:@{}];
}

- (RACSignal *)goodsFootprintList:(NSString *)queryTime pageNum:(NSNumber *)pageNum {
    return [self fg_getRequest:kgoodsFootprintList paramters:@{@"queryTime":queryTime,@"pageNum":pageNum}];
}

- (RACSignal *)uploadImage:(NSInteger)type image:(NSArray *)image {
    NSMutableArray *datas = [[NSMutableArray alloc] init];
    for (UIImage *img in image) {
        NSData *data = UIImageJPEGRepresentation(img, 1.0f);
        [datas addObject:data];
    }
    return [self uploadNetworkPath:kuploadImage params:@{@"type":@(type)} fileDatas:datas name:@"file" mimeType:@""];
}

- (RACSignal *)findAddressListPageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize{
    return [self fg_getRequest:kfindAddressList paramters:@{@"pageNum":pageNum,@"pageSize":pageSize}];
}

- (RACSignal *)addAddress:(NSString *)address city:(NSString *)city province:(NSString *)province recipientName:(NSString *)recipientName recipientPhone:(NSString *)recipientPhone area:(NSString *)area {
    return [self fg_postRequest:kaddAddress paramters:@{@"address":address,@"city":city,@"province":province,@"recipientName":recipientName,@"recipientPhone":recipientPhone,@"area":area}];
}

- (RACSignal *)delAddress:(NSString *)addressNo {
    return [self fg_postRequest:kdelAddress paramters:@{@"addressNo":addressNo}];
}

- (RACSignal *)setDefaultAddress:(NSString *)addressNo {
    return [self fg_postRequest:ksetDefaultAddress paramters:@{@"addressNo":addressNo}];
}

- (RACSignal *)updateAddress:(NSString *)address city:(NSString *)city province:(NSString *)province recipientName:(NSString *)recipientName recipientPhone:(NSString *)recipientPhone area:(NSString *)area addressNo:(NSString *)addressNo {
    return [self fg_postRequest:kupdateAddress paramters:@{@"address":address,@"city":city,@"province":province,@"recipientName":recipientName,@"recipientPhone":recipientPhone,@"area":area,@"addressNo":addressNo}];
}

- (RACSignal *)queryUserInfoCount {
    return [self fg_getRequest:kqueryUserInfoCount paramters:@{}];
}

- (RACSignal *)queryUserOrderCount {
    return [self fg_getRequest:kqueryUserOrderCount paramters:@{}];
}

- (RACSignal *)queryUserTeamCount {
    return [self fg_getRequest:kqueryUserTeamCount paramters:@{}];
}

- (RACSignal *)myMessageListPageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize shopName:(NSString *)shopName{
    return [self fg_getRequest:kmyMessageList paramters:@{@"pageNum":pageNum,@"pageSize":pageSize,@"shopName":shopName}];
}

- (RACSignal *)helpCenterListPageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize title:(NSString *)title {
    return [self fg_getRequest:khelpCenterList paramters:@{@"pageNum":pageNum,@"pageSize":pageSize,@"title":title}];
}

- (RACSignal *)recordGoodsLogType:(NSInteger )type category:(NSString *)category goodsNo:(NSString *)goodsNo searchText:(NSString *)searchText {
    return [self fg_postRequest:krecordGoodsLog paramters:@{@"type":@(type),@"category":category,@"goodsNo":goodsNo,@"searchText":searchText}];
}
@end
