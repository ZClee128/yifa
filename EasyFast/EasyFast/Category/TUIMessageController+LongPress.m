//
//  TUIMessageController+LongPress.m
//  EasyFast
//
//  Created by easyfast on 2020/9/3.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "TUIMessageController+LongPress.h"
#import "TUITextMessageCellData.h"
static TUIMessageCellData *cellData;

@implementation TUIMessageController (LongPress)

+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"onLongPressMessage:")), class_getInstanceMethod(self.class, NSSelectorFromString(@"onMyLongPressMessage:")));
        method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"loadMessage")), class_getInstanceMethod(self.class, NSSelectorFromString(@"myLoadMessage")));
    });
}

- (void)onMyLongPressMessage:(TUIMessageCell *)cell {
    cellData = cell.messageData;
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:[[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(onCopyMsg:)]];
    BOOL isFirstResponder = NO;
    if(self.delegate && [self.delegate respondsToSelector:@selector(messageController:willShowMenuInCell:)]){
        isFirstResponder = [self.delegate messageController:self willShowMenuInCell:cell];
    }
    if(isFirstResponder){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidHide:) name:UIMenuControllerDidHideMenuNotification object:nil];
    }
    else{
        [self becomeFirstResponder];
    }
    UIMenuController *controller = [UIMenuController sharedMenuController];
    controller.menuItems = items;
    [controller setTargetRect:cell.container.bounds inView:cell.container];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [controller setMenuVisible:YES animated:YES];
    });
}

- (void)onCopyMsg:(id)sender
{
    if ([cellData isKindOfClass:[TUITextMessageCellData class]]) {
        TUITextMessageCellData *txtMsg = (TUITextMessageCellData *)cellData;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = txtMsg.content;
    }
}

- (void)myLoadMessage {
    if([self valueForKey:@"isLoadingMsg"] || [self valueForKey:@"noMoreMsg"]){
        return;
    }
    [self setValue:@(YES) forKey:@"isLoadingMsg"];
    int msgCount = 20;
    
}

@end
