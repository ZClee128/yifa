//
//  EFPayModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/17.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EFPayModel : NSObject

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *icon;
@property (nonatomic,assign)BOOL isChoose;
/// 1 wx 2 ali
@property (nonatomic,assign)NSInteger payType;
@end

NS_ASSUME_NONNULL_END
