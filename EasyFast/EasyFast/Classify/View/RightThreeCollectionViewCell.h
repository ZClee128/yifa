//
//  RightThreeCollectionViewCell.h
//  EasyFast
//
//  Created by zclee on 2020/7/22.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ReturnSelectItemBlock)(NSString *selectItemId);

@interface RightThreeCollectionViewCell : UICollectionViewCell


@property (nonatomic, copy) ReturnSelectItemBlock returnSelectItemBlock;

-(CGFloat) getCollectionHeight:(NSMutableArray *)dataArray;

-(void) reloadData;

-(void) selectBlock:(ReturnSelectItemBlock)block;

@end

NS_ASSUME_NONNULL_END
