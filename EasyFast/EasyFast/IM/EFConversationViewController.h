//
//  EFConversationViewController.h
//  EasyFast
//
//  Created by easyfast on 2020/7/29.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseViewController.h"
#import "TUIChatController.h"
#import "TUnReadView.h"

NS_ASSUME_NONNULL_BEGIN
@class TUIMessageCellData;
@interface EFConversationViewController : EFBaseViewController

@property (nonatomic, strong) TUIConversationCellData *conversationData;
@property (nonatomic, strong) TUnReadView *unRead;
- (void)sendMessage:(TUIMessageCellData*)msg;
@end

NS_ASSUME_NONNULL_END
