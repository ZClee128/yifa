//
//  EFNoticeTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/15.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFNoticeTableViewCell.h"
#import "EFNoticTitleCell.h"

@interface EFNoticeTableViewCell()<GYRollingNoticeViewDelegate,GYRollingNoticeViewDataSource>

@property (nonatomic,strong)GYRollingNoticeView *rollView;

@end


@implementation EFNoticeTableViewCell

-(GYRollingNoticeView *)rollView
{
    if (_rollView == nil) {
        _rollView = [[GYRollingNoticeView alloc] init];
        _rollView.backgroundColor = RGB16(0xFFF5DD);
        _rollView.delegate = self;
        _rollView.dataSource = self;
        [_rollView registerClass:[EFNoticTitleCell class] forCellReuseIdentifier:NSStringFromClass([EFNoticTitleCell class])];
        [_rollView reloadDataAndStartRoll];
    }
    return _rollView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.contentView.backgroundColor = colorfafafa;
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = RGB16(0xFFF5DD);
    [self.contentView addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(10));
        make.left.equalTo(@(WidthOfScale(15)));
        make.width.equalTo(@(WidthOfScale(375 - 30)));
        make.height.equalTo(@(30));
    }];
    [bg layoutIfNeeded];
    [bg ViewRadius:4];
    
    
    QMUIButton *noticeBtn = [QMUIButton buttonWithType:(UIButtonTypeCustom)];
    [noticeBtn setImage:[UIImage imageNamed:@"notice"] forState:(UIControlStateNormal)];
    [noticeBtn setTitle:@"公告：" forState:(UIControlStateNormal)];
    noticeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10.5);
    noticeBtn.titleLabel.font = RegularFont13;
    [noticeBtn setTitleColor:RGB16(0x6C5E3D) forState:(UIControlStateNormal)];
    [bg addSubview:noticeBtn];
    [noticeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(WidthOfScale(10)));
        make.centerY.equalTo(bg.mas_centerY);
    }];
    [noticeBtn layoutIfNeeded];
    
    [bg addSubview:self.rollView];
    [self.rollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(noticeBtn.mas_right).equalTo(@(4));
        make.centerY.equalTo(noticeBtn.mas_centerY);
        make.width.equalTo(@(WidthOfScale(375 - 30)-noticeBtn.width));
        make.height.equalTo(@(30));
    }];
    [self.rollView layoutIfNeeded];
    
    [self.contentView layoutIfNeeded];
}

#pragma GYRollingNoticeViewDelegate,GYRollingNoticeViewDataSource
- (NSInteger)numberOfRowsForRollingNoticeView:(GYRollingNoticeView *)rollingView {
    return 3;
}

- (GYNoticeViewCell *)rollingNoticeView:(GYRollingNoticeView *)rollingView cellAtIndex:(NSUInteger)index {
    EFNoticTitleCell *cell = [rollingView dequeueReusableCellWithIdentifier:NSStringFromClass([EFNoticTitleCell class])];
    [cell setTitle:@"此地方为平台公告展示地"];
    return cell;
}

- (void)didClickRollingNoticeView:(GYRollingNoticeView *)rollingView forIndex:(NSUInteger)index {
    
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