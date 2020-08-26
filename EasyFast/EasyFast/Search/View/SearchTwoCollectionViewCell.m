//
//  SearchTwoCollectionViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "SearchTwoCollectionViewCell.h"
#import "SKTagView.h"
#import "EFGoodsList.h"

@interface SearchTwoCollectionViewCell ()

@property (nonatomic,strong)UIImageView *goods;
@property (nonatomic,strong)UILabel *goodsNameLab;
@property (nonatomic,strong)SKTagView *listView;
@property (nonatomic,strong)UILabel *numLab;
@property (nonatomic,strong)UILabel *sellLab;
@property (nonatomic,strong)UILabel *priceLab;
@property (nonatomic,assign)CGFloat tagHeight;

@end

@implementation SearchTwoCollectionViewCell

-(UIImageView *)goods
{
    if (_goods == nil) {
        _goods = [[UIImageView alloc] init];
        _goods.size = CGSizeMake(WidthOfScale(167), WidthOfScale(165));
        _goods.backgroundColor = colorEFEFEF;
//        _goods.image = UIImageMake(@"gg");
    }
    return _goods;
}

- (SKTagView *)listView {
    if (_listView == nil) {
        _listView = [[SKTagView alloc] init];
        _listView.padding = UIEdgeInsetsMake(0, 0, 0, 0);
        // 上下行之间的距离
        _listView.lineSpacing = WidthOfScale(7.5);
        // item之间的距离
        _listView.interitemSpacing = WidthOfScale(6.5);
        // 最大宽度
        _listView.preferredMaxLayoutWidth = WidthOfScale(167-20);
    }
    return _listView;
}

-(UILabel *)goodsNameLab
{
    if (_goodsNameLab == nil) {
        _goodsNameLab = [[UILabel alloc] init];
        _goodsNameLab.textAlignment = NSTextAlignmentLeft;
        _goodsNameLab.font = MedFont15;
        _goodsNameLab.textColor = tabbarBlackColor;
    }
    return _goodsNameLab;
}

-(UILabel *)numLab
{
    if (_numLab == nil) {
        _numLab = [[UILabel alloc] init];
        _numLab.font = RegularFont12;
        _numLab.textColor = tabbarBlackColor;
        _numLab.textAlignment = NSTextAlignmentLeft;
    }
    return _numLab;
}

-(UILabel *)sellLab
{
    if (_sellLab == nil) {
        _sellLab = [[UILabel alloc] init];
        _sellLab.font = RegularFont12;
        _sellLab.textColor = tabbarBlackColor;
        _sellLab.textAlignment = NSTextAlignmentLeft;
    }
    return _sellLab;
}

- (UILabel *)priceLab {
    if (_priceLab == nil) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.font = MedFont16;
        _priceLab.textColor = tabbarRedColor;
        _priceLab.textAlignment = NSTextAlignmentLeft;
    }
    return _priceLab;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView ViewRadius:5];
    [self.contentView addSubview:self.goods];
    [self.goods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.size.mas_equalTo(CGSizeMake(WidthOfScale(167), WidthOfScale(165)));
    }];
    
    [self.contentView addSubview:self.goodsNameLab];
    [self.goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(10)));
        make.right.equalTo(@(-WidthOfScale(10)));
        make.top.equalTo(self.goods.mas_bottom).equalTo(@(WidthOfScale(11.5)));
        make.height.equalTo(@(WidthOfScale(14.5)));
    }];
    
    [self.contentView addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(10)));
        make.width.equalTo(@(WidthOfScale(167-20)));
        make.top.equalTo(self.goodsNameLab.mas_bottom).equalTo(@(WidthOfScale(6.5)));
        make.height.equalTo(@(WidthOfScale(16)));
    }];
    [self.listView layoutIfNeeded];
    
    [self.contentView addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(10)));
        make.right.equalTo(@(-WidthOfScale(10)));
        make.top.equalTo(self.listView.mas_bottom).equalTo(@(WidthOfScale(9)));
        make.height.equalTo(@(WidthOfScale(11.5)));
    }];
    
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(@(WidthOfScale(10)));
       make.top.equalTo(self.numLab.mas_bottom).equalTo(@(WidthOfScale(14)));
       make.height.equalTo(@(WidthOfScale(12.5)));
    }];
    
    [self.contentView addSubview:self.sellLab];
    [self.sellLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLab.mas_right).equalTo(@(WidthOfScale(10.5)));
        make.top.equalTo(self.numLab.mas_bottom).equalTo(@(WidthOfScale(15)));
        make.height.equalTo(@(WidthOfScale(11.5)));
    }];
    [self.contentView layoutIfNeeded];
}

- (void)setModel:(id)model {
    if ([model isKindOfClass:[EFGoodsList class]]) {
        EFGoodsList *goodModel = model;
        self.goodsNameLab.text = goodModel.title;
        if (goodModel.tags.count != 0) {
            NSMutableArray *titles = [[NSMutableArray alloc] init];
            for (EFTagsModel *tag in goodModel.tags) {
                [titles addObject:tag.title];
            }
            [self.listView removeAllTags];
            [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                // 初始化标签
                SKTag *tag = [[SKTag alloc] initWithText:titles[idx]];
                // 标签相对于自己容器的上左下右的距离
                tag.padding = UIEdgeInsetsMake(2, 7, 2, 7);
                // 弧度
                tag.cornerRadius = 0.0f;
                // 字体
                tag.font = RegularFont12;
                // 边框宽度
                tag.borderWidth = 0;
                // 背景
                tag.bgColor = RGB16(0xFFEAE9);
                // 边框颜色
                //            tag.borderColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
                // 字体颜色
                tag.textColor = tabbarRedColor;
                // 是否可点击
                tag.enable = NO;
                // 加入到tagView
                [self.listView addTag:tag];
            }];
            // 获取刚才加入所有tag之后的内在高度
            self.tagHeight = self.listView.intrinsicContentSize.height;
            XYLog(@"高度%lf",self.tagHeight);
            [self.listView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(self.tagHeight));
            }];
            
            [self.listView layoutIfNeeded];
            [self.listView layoutSubviews];
            [self.contentView layoutIfNeeded];
        }
        self.numLab.text = [NSString stringWithFormat:@"最低采购量：%ld",(long)goodModel.miniOrderLimit];
        self.sellLab.text = [NSString stringWithFormat:@"成交量：%ld",(long)goodModel.sales];
        self.priceLab.text = [NSString stringWithFormat:@"¥%.2f",goodModel.price];
        [self.goods sd_setImageWithURL:[NSURL URLWithString:goodModel.url] placeholderImage:UIImageMake(@"")];
    }
}

- (CGFloat )cellHeight {
    return WidthOfScale(115)+self.tagHeight + WidthOfScale(165);
}
@end
