//
//  HotTabTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "HotTabTableViewCell.h"
#import "HotTabCollectionViewCell.h"
#import "SLScrollViewHorizontalItem.h"
#import "EFActivityModel.h"
#import "CustomerScrollView.h"
@interface HotTabTableViewCell ()<SLScrollViewHorizontalItemDelegate,CustomerScrollViewDelegate>

@property (strong, nonatomic) CustomerScrollView *scrollViewHorizontalItem;
@property (nonatomic,strong)NSMutableArray *data;
@end

@implementation HotTabTableViewCell

-(NSMutableArray *)data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc]init];
    }
    return _data;
}

//-(SLScrollViewHorizontalItem *)scrollViewHorizontalItem
//{
//    if (_scrollViewHorizontalItem == nil) {
//
//    }
//    return _scrollViewHorizontalItem;
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setUI {
    self.contentView.backgroundColor = colorfafafa;
    
}


- (void)setCollectData:(NSMutableArray *)data {
    self.data = data;
    [self.scrollViewHorizontalItem removeFromSuperview];
    self.scrollViewHorizontalItem = nil;
    if (self.scrollViewHorizontalItem == nil) {
//        self.scrollViewHorizontalItem = [[SLScrollViewHorizontalItem alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, self.data.count > 4 ? (self.scrollViewHorizontalItem.height = WidthOfScale(208)) : (self.scrollViewHorizontalItem.height = WidthOfScale(123.5))) delegate:self];
        self.scrollViewHorizontalItem = [[CustomerScrollView alloc] initWithFrame:CGRectMake(0, 0, kPHONE_WIDTH, self.data.count > 4 ? (self.scrollViewHorizontalItem.height = WidthOfScale(208)) : (self.scrollViewHorizontalItem.height = WidthOfScale(123.5))) withData:data];
        self.scrollViewHorizontalItem.delegate = self;
        [self.contentView addSubview:self.scrollViewHorizontalItem];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (NSInteger)numberOfItemsInView:(UIView *)view {
    return self.data.count;
}

- (NSInteger)lineNumberOfItemsInView:(UIView *)view {
    if (self.data.count <= 4) {
        return 1;
    }else {
        return 2;
    }
}

- (NSInteger)columnNumberOfItemsInView:(UIView *)view {
    return 4;
}

- (CGFloat)lineSpaceOfItemsInView:(UIView *)view {
    return WidthOfScale(10);
}

- (CGFloat)columnSpaceOfItemsInView:(UIView *)view {
    return WidthOfScale(7.5);
}


- (UIEdgeInsets)edgeInsetsOfItemsInView:(UIView *)view {
    return UIEdgeInsetsMake(WidthOfScale(20), WidthOfScale(27), WidthOfScale(34.5), WidthOfScale(27));
}

- (UIView *)itemForView:(UIView *)view index:(NSInteger)index {
    
    QMUIButton *btn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    btn.imagePosition = QMUIButtonImagePositionTop;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, WidthOfScale(11.5), 0);
//    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    btn.titleLabel.font = RegularFont14;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn.titleLabel sizeToFit];
    [btn sizeToFit];
    [btn setTitleColor:tabbarBlackColor forState:(UIControlStateNormal)];
    EFActivityModel *model = self.data[index];
    [btn setTitle:model.iconTitle forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:model.icon] forState:(UIControlStateNormal)];
    return btn;
    
}

- (void)selectBtnIndex:(NSInteger)index {
    EFActivityModel *model = self.data[index];
    XYLog(@"%@",model);
}

//- (void)item:(UIView *)item didSelectItemAtIndex:(NSInteger)index {
//    NSLog(@"%ld", index);
//}

//#pragma mark - collection
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.data.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    HotTabCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HotTabCollectionViewCell class]) forIndexPath:indexPath];
//    [cell setModel:@""];
//    return cell;
//}



@end
