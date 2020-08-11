//
//  HotTabCollectionViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/14.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "HotTabCollectionViewCell.h"
#import "EFClassifyModel.h"


@interface HotTabCollectionViewCell ()

@property (nonatomic,strong)QMUIButton *tabBtn;

@end

@implementation HotTabCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.tabBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    self.tabBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:self.tabBtn];
    [self.tabBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    self.tabBtn.imagePosition = QMUIButtonImagePositionTop;
    self.tabBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, WidthOfScale(11.5), 0);
    self.tabBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tabBtn.titleLabel.font = RegularFont14;
    self.tabBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.tabBtn.titleLabel sizeToFit];
    [self.tabBtn sizeToFit];
    [self.tabBtn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
}

- (void)setModel:(EFClassifyModel *)model {
    [self.tabBtn setTitle:model.title forState:(UIControlStateNormal)];
    if ([model.title isEqualToString:@"查看更多"]) {
        [self.tabBtn setImage:UIImageMake(model.icon) forState:(UIControlStateNormal)];
    }else {
        [self.tabBtn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.icon]]] forState:(UIControlStateNormal)];
    }
}
@end
