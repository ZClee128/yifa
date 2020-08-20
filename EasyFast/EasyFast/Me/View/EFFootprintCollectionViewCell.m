//
//  EFFootprintCollectionViewCell.m
//  EasyFast
//
//  Created by easyfast on 2020/8/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFootprintCollectionViewCell.h"
#import "TuanOtherGoodsView.h"

@interface EFFootprintCollectionViewCell ()

@property (nonatomic,strong)TuanOtherGoodsView *goodsView;

@end

@implementation EFFootprintCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.goodsView = [[TuanOtherGoodsView alloc] initWithFrame:CGRectMake(0, 0, WidthOfScale(167),  WidthOfScale(165+72))];
        [self.contentView addSubview:self.goodsView];
    }
    return self;
}

- (void)setLeftModel:(EFGoodsList *)model {
    [self.goodsView setModel:model];
}

@end
