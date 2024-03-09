//
//  EFMsgBody.h
//  EasyFast
//
//  Created by easyfast on 2020/9/3.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFMsgContent : EFBaseModel

@property (nonatomic,strong)NSString *Text;

@end


@interface EFMsgBody : EFBaseModel

@property (nonatomic,strong)NSString *MsgType;
@property (nonatomic,strong)EFMsgContent *MsgContent;

@end

NS_ASSUME_NONNULL_END
