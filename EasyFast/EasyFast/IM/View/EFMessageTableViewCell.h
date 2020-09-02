//
//  EFMessageTableViewCell.h
//  EasyFast
//
//  Created by easyfast on 2020/9/2.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "TUIMessageCell.h"
#import "EFMessageCellData.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFMessageTableViewCell : TUIMessageCell

@property EFMessageCellData *customData;
@property UILabel *myTextLabel;
- (void)fillWithData:(EFMessageCellData *)data;
@end

NS_ASSUME_NONNULL_END
