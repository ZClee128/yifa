//
//  EFConversationViewController.m
//  EasyFast
//
//  Created by easyfast on 2020/7/29.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFConversationViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "TUIVideoMessageCell.h"
#import "TUIFileMessageCell.h"
#import "TUITextMessageCell.h"
#import "TUISystemMessageCell.h"
#import "TUIVoiceMessageCell.h"
#import "TUIImageMessageCell.h"
#import "TUIFaceMessageCell.h"
#import "TUIVideoMessageCell.h"
#import "TUIFileMessageCell.h"
#import "TIMFriendshipManager.h"
#import "TUIKit.h"
#import "MMLayout/UIView+MMLayout.h"
#import "THelper.h"


// MLeaksFinder 会对这个类误报，这里需要关闭一下
@implementation UIImagePickerController (Leak)

- (BOOL)willDealloc {
    return NO;
}

@end

@interface EFConversationViewController ()<TUIChatControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate>
@property (nonatomic, strong) TUIChatController *chat;
@end

@implementation EFConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"我的客服";
    TUIKitConfig *config = [TUIKitConfig defaultConfig];
    config.avatarType = TAvatarTypeRounded;
    _chat = [[TUIChatController alloc] initWithConversation:self.conversationData];
    _chat.delegate = self;
    [self addChildViewController:_chat];
    [self.view addSubview:_chat.view];
    
    NSArray *images = @[@{@"image":UIImageMake(@"camera"),@"title":@"拍照"},@{@"image":UIImageMake(@"photo"),@"title":@"相册"}];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < images.count; i++) {
        TUIInputMoreCellData *data = [[TUIInputMoreCellData alloc] init];
        data.image = images[i][@"image"];
        data.title = images[i][@"title"];
        [array addObject:data];
    }
    _chat.moreMenus = array; // 重新设置属性，立即生效

    [TUITextMessageCellData setOutgoingTextFont:RegularFont15];
    [TUITextMessageCellData setOutgoingTextColor:[UIColor whiteColor]];
    [TUITextMessageCellData setIncommingTextFont:RegularFont15];
    [TUITextMessageCellData setIncommingTextColor:[UIColor blackColor]];
    
    [TUIBubbleMessageCellData setOutgoingBubble:UIImageMake(@"orange")];
    [TUIBubbleMessageCellData setOutgoingHighlightedBubble:UIImageMake(@"white")];
    [TUIMessageCellLayout outgoingTextMessageLayout].bubbleInsets = UIEdgeInsetsMake(15, 10, 15, 10);
    
    _chat.messageController.view.backgroundColor = colorfafafa;
    
    _chat.inputController.inputBar.micButton.alpha = 0;
    _chat.inputController.view.backgroundColor = UIColor.whiteColor;
    _chat.inputController.inputBar.inputTextView.x = WidthOfScale(15);
    _chat.inputController.inputBar.inputTextView.width = WidthOfScale(280);
    _chat.inputController.inputBar.backgroundColor = UIColor.whiteColor;
    _chat.inputController.inputBar.inputTextView.backgroundColor = RGB16(0xf7f7f7);
    _chat.inputController.inputBar.lineView.hidden = YES;
    
    [_chat.inputController.inputBar.faceButton setImage:UIImageMake(@"face") forState:(UIControlStateNormal)];
    [_chat.inputController.inputBar.moreButton setImage:UIImageMake(@"add") forState:(UIControlStateNormal)];
    _chat.inputController.moreView.moreCollectionView.backgroundColor = UIColor.whiteColor;
    _chat.inputController.moreView.backgroundColor = UIColor.whiteColor;
    _chat.inputController.menuView.menuCollectionView.backgroundColor = UIColor.whiteColor;
    _chat.inputController.menuView.backgroundColor = UIColor.whiteColor;
    RAC(self, title) = [RACObserve(_conversationData, title) distinctUntilChanged];
    [self checkTitle];
}

- (void)checkTitle {
    if (_conversationData.title.length == 0) {
        if (_conversationData.userID.length > 0) {
            _conversationData.title = _conversationData.userID;
             @weakify(self)
            [[V2TIMManager sharedInstance] getFriendsInfo:@[_conversationData.userID] succ:^(NSArray<V2TIMFriendInfoResult *> *resultList) {
                @strongify(self)
                V2TIMFriendInfoResult *result = resultList.firstObject;
                if (result.friendInfo && result.friendInfo.friendRemark.length > 0) {
                    self.conversationData.title = result.friendInfo.friendRemark;
                } else {
                    [[V2TIMManager sharedInstance] getUsersInfo:@[self.conversationData.userID] succ:^(NSArray<V2TIMUserFullInfo *> *infoList) {
                        V2TIMUserFullInfo *info = infoList.firstObject;
                        if (info && info.nickName.length > 0) {
                            self.conversationData.title = info.nickName;
                        }
                    } fail:nil];
                }
            } fail:nil];
        }
        if (_conversationData.groupID.length > 0) {
            _conversationData.title = _conversationData.groupID;
             @weakify(self)
            [[V2TIMManager sharedInstance] getGroupsInfo:@[_conversationData.groupID] succ:^(NSArray<V2TIMGroupInfoResult *> *groupResultList) {
                @strongify(self)
                V2TIMGroupInfoResult *result = groupResultList.firstObject;
                if (result.info && result.info.groupName.length > 0) {
                    self.conversationData.title = result.info.groupName;
                }
            } fail:nil];
        }
    }
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    if (parent == nil) {
        [_chat saveDraft];
    }
}

// 聊天窗口标题由上层维护，需要自行设置标题
- (void)onRefreshNotification:(NSNotification *)notifi
{
    NSArray<V2TIMConversation *> *convs = notifi.object;
    for (V2TIMConversation *conv in convs) {
        if ([conv.conversationID isEqualToString:self.conversationData.conversationID]) {
            self.conversationData.title = conv.showName;
            break;
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (void)setupNavigator
//{
//    //left
//    _unRead = [[TUnReadView alloc] init];
//
//    //_unRead.backgroundColor = [UIColor grayColor];//可通过此处将未读标记设置为灰色，类似微信，但目前仍使用红色未读视图
//    UIBarButtonItem *urBtn = [[UIBarButtonItem alloc] initWithCustomView:_unRead];
//    self.navigationItem.leftBarButtonItems = @[urBtn];
//    //既显示返回按钮，又显示未读视图
//    self.navigationItem.leftItemsSupplementBackButton = YES;
//
//    //right，根据当前聊天页类型设置右侧按钮格式
//    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [rightButton addTarget:self action:@selector(rightBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    if(_conversationData.userID.length > 0){
//        [rightButton setImage:[UIImage tk_imageNamed:@"person_nav"] forState:UIControlStateNormal];
//        //[rightButton setImage:[UIImage tk_imageNamed:@"person_nav_hover"] forState:UIControlStateHighlighted];
//    }
//    else if(_conversationData.groupID.length > 0){
//        [rightButton setImage:[UIImage tk_imageNamed:(@"group_nav")] forState:UIControlStateNormal];
//        //[rightButton setImage:[UIImage tk_imageNamed:(@"group_nav_hover")] forState:UIControlStateHighlighted];
//    }
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    self.navigationItem.rightBarButtonItems = @[rightItem];
//}

-(void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarButtonClick
{
    //当前为用户和用户之间通信时，右侧按钮响应为用户信息视图入口
    if (_conversationData.userID.length > 0) {
        @weakify(self)
        [[V2TIMManager sharedInstance] getFriendList:^(NSArray<V2TIMFriendInfo *> *infoList) {
            @strongify(self)
            for (V2TIMFriendInfo *firend in infoList) {
                if ([firend.userFullInfo.userID isEqualToString:self.conversationData.userID]) {
                    id<TUIFriendProfileControllerServiceProtocol> vc = [[TCServiceManager shareInstance] createService:@protocol(TUIFriendProfileControllerServiceProtocol)];
                    if ([vc isKindOfClass:[UIViewController class]]) {
                        vc.friendProfile = firend;
                        [self.navigationController pushViewController:(UIViewController *)vc animated:YES];
                        return;
                    }
                }
            }
            [[V2TIMManager sharedInstance] getUsersInfo:@[self.conversationData.userID] succ:^(NSArray<V2TIMUserFullInfo *> *infoList) {
//                TUserProfileController *myProfile = [[TUserProfileController alloc] init];
//                myProfile.userFullInfo = infoList.firstObject;
//                myProfile.actionType = PCA_ADD_FRIEND;
//                [self.navigationController pushViewController:myProfile animated:YES];
            } fail:^(int code, NSString *msg) {
                NSLog(@"拉取用户资料失败！");
            }];
        } fail:^(int code, NSString *msg) {
            NSLog(@"拉取好友列表失败！");
        }];

    //当前为群组通信时，右侧按钮响应为群组信息入口
    } else {
//        GroupInfoController *groupInfo = [[GroupInfoController alloc] init];
//        groupInfo.groupId = _conversationData.groupID;
//        [self.navigationController pushViewController:groupInfo animated:YES];
    }
}

- (void)chatController:(TUIChatController *)controller didSendMessage:(TUIMessageCellData *)msgCellData
{
    [self sendMessage:msgCellData];
}

- (void)chatController:(TUIChatController *)chatController onSelectMoreCell:(TUIInputMoreCell *)cell
{
    if ([cell.data.title isEqualToString:@"自定义"]) {
        NSString *text = @"欢迎加入腾讯·云通信大家庭！";
        NSString *link = @"https://cloud.tencent.com/document/product/269/3794";
//        MyCustomCellData *cellData = [[MyCustomCellData alloc] initWithDirection:MsgDirectionOutgoing];
//        cellData.text = text;
//        cellData.link = link;
//        cellData.innerMessage = [[V2TIMManager sharedInstance] createCustomMessage:[TCUtil dictionary2JsonData:@{@"version": @(Version),@"businessID": @"text_link",@"text":text,@"link":link}]];
//        [chatController sendMessage:cellData];
    }
}

- (TUIMessageCellData *)chatController:(TUIChatController *)controller onNewMessage:(V2TIMMessage *)msg
{
    if (msg.elemType == V2TIM_ELEM_TYPE_CUSTOM) {
//        NSDictionary *param = [TCUtil jsonData2Dictionary:msg.customElem.data];
//        if (param != nil) {
//            NSInteger version = [param[@"version"] integerValue];
//            NSString *businessID = param[@"businessID"];
//            if (version == Version && [businessID isEqualToString:@"text_link"]) {
//                MyCustomCellData *cellData = [[MyCustomCellData alloc] initWithDirection:msg.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming];
//                cellData.innerMessage = msg;
//                cellData.msgID = msg.msgID;
//                cellData.text = param[@"text"];
//                cellData.link = param[@"link"];
//                cellData.avatarUrl = [NSURL URLWithString:msg.faceURL];
//                return cellData;
//            }
//            // 兼容下老版本
//            if ([param.allKeys containsObject:@"link"] && [param.allKeys containsObject:@"text"]) {
//                MyCustomCellData *cellData = [[MyCustomCellData alloc] initWithDirection:msg.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming];
//                cellData.innerMessage = msg;
//                cellData.msgID = msg.msgID;
//                cellData.text = param[@"text"];
//                cellData.link = param[@"link"];
//                cellData.avatarUrl = [NSURL URLWithString:msg.faceURL];
//                return cellData;
//            }
//        }
    }
    return nil;
}

- (TUIMessageCell *)chatController:(TUIChatController *)controller onShowMessageData:(TUIMessageCellData *)data
{
//    if ([data isKindOfClass:[MyCustomCellData class]]) {
//        MyCustomCell *myCell = [[MyCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
//        [myCell fillWithData:(MyCustomCellData *)data];
//        return myCell;
//    }
    return nil;
}

- (void)chatController:(TUIChatController *)controller onSelectMessageContent:(TUIMessageCell *)cell
{
//    if ([cell isKindOfClass:[MyCustomCell class]]) {
//        MyCustomCellData *cellData = [(MyCustomCell *)cell customData];
//        if (cellData.link) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:cellData.link]];
//        }
//    }
}

- (void) onChangeUnReadCount:(NSNotification *)notifi{
    NSInteger count = [notifi.object integerValue];
    [_unRead setNum:MAX(0, count - self.conversationData.unreadCount)];
}


- (void)sendMessage:(TUIMessageCellData*)msg {
    [_chat sendMessage:msg];
}
@end
