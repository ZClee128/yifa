//
//  EFMessageModel.h
//  EasyFast
//
//  Created by easyfast on 2020/9/4.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"
#import "EFMsgBody.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFMessageModel : EFBaseModel

/// 回调命令
@property (nonatomic,strong)NSString *callbackCommand;
/// 客户端 IP，格式如：127.0.0.1
@property (nonatomic,strong)NSString *clientIP;
/// 固定值为 JSON
@property (nonatomic,strong)NSString *contentType;
/// 回调收到消息的时间
@property (nonatomic,strong)NSString *createTime;
/// 收到消息的时间戳毫秒值-用于获取历史聊天记录排序
@property (nonatomic,strong)NSString *createTimeMills;
/// 该条消息下发失败的错误信息，若消息发送成功，则为"send msg succeed"
@property (nonatomic,strong)NSString *errorInfo;
/// 消息发送者 UserID
@property (nonatomic,strong)NSString *fromAccount;
/// 接收者是否已读，0：未读，1：已读
@property (nonatomic,assign)BOOL isRead;
/// 消息体--用来渲染消息内容
@property (nonatomic,strong)NSArray<EFMsgBody *> *msgBody;
/// 该条消息的唯一标识，可根据该标识进行 REST API 撤回单聊消息
@property (nonatomic,strong)NSString *msgKey;
/// 消息随机数，用于标记该条消息（32位无符号整数）
@property (nonatomic,strong)NSString *msgRandom;
/// 消息序列号，用于标记该条消息（32位无符号整数）
@property (nonatomic,strong)NSString *msgSeq;
/// 消息的发送时间戳，单位为秒
@property (nonatomic,strong)NSString *msgTime;
/// 客户端平台，可能的取值有：RESTAPI（使用 REST API 发送请求）、Web（使用 Web SDK 发送请求）、
@property (nonatomic,strong)NSString *optPlatform;
/// 接收者删除--该字段暂时未使用
@property (nonatomic,strong)NSString *receiverDelete;
/// 原始回调信息
@property (nonatomic,strong)NSString *requestParam;
/// 该条消息的下发结果，0表示下发成功，非0表示下发失败，具体可参见 错误码
@property (nonatomic,strong)NSString *sendMsgResult;
/// 发送者删除--该字段暂时未使用
@property (nonatomic,strong)NSString *senderDelete;
/// 商家的编码，以客服的归属商家为准
@property (nonatomic,strong)NSString *ssNo;
/// 店铺编码，以客服的归属店铺为准
@property (nonatomic,strong)NSString *sssNo;
/// 消息接收者 UserID
@property (nonatomic,strong)NSString *toAccount;
@end

NS_ASSUME_NONNULL_END
