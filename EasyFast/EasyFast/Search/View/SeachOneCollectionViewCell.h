//
//  SeachOneCollectionViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SeachOneCollectionViewCell : UICollectionViewCell

@property (nonatomic,copy)void(^seletBtnBlock)(QMUIButton *sender);
- (void)setBtnStyle;
- (void)setModel:(id)model;
- (CGFloat )cellHeight;
@end

NS_ASSUME_NONNULL_END
