//
//  EFBootPageVM.h
//  EasyFast
//
//  Created by easyfast on 2020/8/26.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseRefreshVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFBootPageVM : EFBaseRefreshVM

@end

@interface EFBootpageModel : EFBaseModel

@property (nonatomic,copy)NSString *bgImage;
@property (nonatomic,copy)NSString *bfImage;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *subTitle;
@property (nonatomic,assign) CGFloat  bgtop;
@property (nonatomic,assign) CGFloat  bgleft;
@property (nonatomic,assign) CGFloat  bgright;

@end

NS_ASSUME_NONNULL_END
