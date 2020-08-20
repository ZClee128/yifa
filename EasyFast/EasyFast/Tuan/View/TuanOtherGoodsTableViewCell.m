//
//  TuanOtherGoodsTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "TuanOtherGoodsTableViewCell.h"
#import "TuanOtherGoodsView.h"

@interface TuanOtherGoodsTableViewCell ()

@property (nonatomic,strong)TuanOtherGoodsView *leftView;
@property (nonatomic,strong)TuanOtherGoodsView *rightView;
@property (nonatomic,strong)EFGoodsList *leftModel;
@property (nonatomic,strong)EFGoodsList *rightModel;
@end


@implementation TuanOtherGoodsTableViewCell

-(TuanOtherGoodsView *)leftView
{
    if (_leftView == nil) {
        _leftView = [[TuanOtherGoodsView alloc] initWithFrame:CGRectMake(WidthOfScale(15), 0, WidthOfScale(167),  WidthOfScale(165+72))];
        _leftView.userInteractionEnabled = YES;
        @weakify(self);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            @strongify(self);
            if (self.leftBlock) {
                self.leftBlock();
            }
        }];
        [_leftView addGestureRecognizer:tap];
    }
    return _leftView;
}

-(TuanOtherGoodsView *)rightView
{
    if (_rightView == nil) {
        _rightView = [[TuanOtherGoodsView alloc] initWithFrame:CGRectMake(WidthOfScale(15+167+11.5), 0, WidthOfScale(167), WidthOfScale(165+72))];
        _rightView.userInteractionEnabled = YES;
        @weakify(self);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            @strongify(self);
            if (self.rightBlock) {
                self.rightBlock();
            }
        }];
        [_rightView addGestureRecognizer:tap];
    }
    return _rightView;
}

- (void)setUI {
    self.contentView.backgroundColor = colorfafafa;
    [self.contentView addSubview:self.leftView];
    
    [self.contentView addSubview:self.rightView];

}

- (void)setLeftModel:(EFGoodsList *)model {
    [self.leftView setModel:model];
}

- (void)setRightModel:(EFGoodsList *)model {
    [self.rightView setModel:model];
}

- (void)hiddenRightView {
    self.rightView.hidden = YES;
}

- (void)showRightView {
    self.rightView.hidden = NO;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
