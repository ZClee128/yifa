//
//  HotTabTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "HotTabTableViewCell.h"
#import "HotTabCollectionViewCell.h"
#import "EFActivityModel.h"
#import "CustomerScrollView.h"
@interface HotTabTableViewCell ()<CustomerScrollViewDelegate>

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

- (void)selectBtnIndex:(NSInteger)index {
    EFActivityModel *model = self.data[index];
    XYLog(@"%@",model);
    NSDictionary *dict = [model modelToJSONObject];
    if (model.url.length) {
        [kH5Manager gotoUrl:model.url hasNav:YES navTitle:model.title query:dict];
    }
}




@end
