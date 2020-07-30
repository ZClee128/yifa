//
//  ThreeCollectionViewCellItem.m
//  EasyFast
//
//  Created by zclee on 2020/7/22.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "ThreeCollectionViewCellItem.h"

@interface ThreeCollectionViewCellItem ()

@property (nonatomic, strong) UIImageView *logoImgView;
@property (nonatomic, strong) QMUILabel *nameLabel;

@end

@implementation ThreeCollectionViewCellItem


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGFloat imageWidth = frame.size.width;
//        if (frame.size.width < imageWidth)
//        {
//            imageWidth = frame.size.width;
//        }
        self.logoImgView = [[UIImageView alloc] init];
        self.logoImgView.size = CGSizeMake(imageWidth, imageWidth);
        self.logoImgView.top = 0;
        self.logoImgView.left = (frame.size.width - imageWidth) / 2.f;
        self.logoImgView.contentMode = UIViewContentModeScaleAspectFill;
        self.logoImgView.clipsToBounds = YES;
        self.logoImgView.backgroundColor = colorEFEFEF;
        self.logoImgView.image = UIImageMake(@"gg");
        [self.contentView addSubview:self.logoImgView];
        
        self.nameLabel = [[QMUILabel alloc] init];
        self.nameLabel.frame = CGRectMake(0, self.logoImgView.bottom + WidthOfScale(9.5), frame.size.width, WidthOfScale(12.5));
        self.nameLabel.textAlignment= NSTextAlignmentCenter;
        self.nameLabel.font = RegularFont13;
        self.nameLabel.textColor = tabbarBlackColor;
        [self.contentView addSubview:self.nameLabel];
        
        self.nameLabel.text = @"口红";
    }
    return self;
}

- (void)setModel:(id)model {
    
}
@end
