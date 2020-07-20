//
//  TuanListDetailTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "TuanListDetailTableViewCell.h"
#import "TuanPeopleView.h"

@interface TuanListDetailTableViewCell ()

@property (nonatomic,strong)TuanPeopleView *pView;
@end


@implementation TuanListDetailTableViewCell

-(TuanPeopleView *)pView
{
    if (_pView == nil) {
        _pView = [[TuanPeopleView alloc] initWithFrame:CGRectMake(WidthOfScale(15), 0, kPHONE_WIDTH-WidthOfScale(30), WidthOfScale(40))];
    }
    return _pView;
}

- (void)setUI {
    [self.contentView addSubview:self.pView];
}

- (void)setModel:(id)model {
    [_pView setModel:model];
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
