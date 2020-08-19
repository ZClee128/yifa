//
//  CustomerScrollView.m
//  colloctionViewTest
//
//  Created by jerry on 16/12/15.
//  Copyright © 2016年 jerry. All rights reserved.
//

#import "CustomerScrollView.h"
#import "EFActivityModel.h"
#define NumberOfSinglePage 8 // 一个页面可容纳的最多按钮数
#define ViewGap WidthOfScale(34)
#define ViewMargin 0
#define BtnWH WidthOfScale(69.5)

@interface CustomerScrollView ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView * contentScrollView;
@property (nonatomic,strong) UIPageControl * pageControl;
/** 指示器背景 */
@property (strong, nonatomic) UIView *indicatorBackView;
/** 指示器 */
@property (strong, nonatomic) UIView *indicatorView;
@end

@implementation CustomerScrollView

#pragma mark - getter

- (UIView *)indicatorBackView {
    if (!_indicatorBackView) {
        _indicatorBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthOfScale(50) , WidthOfScale(4))];
        _indicatorBackView.backgroundColor = colorEFEFEF;
        _indicatorBackView.layer.cornerRadius = WidthOfScale(4) / 2;
        _indicatorBackView.layer.masksToBounds = YES;
    }
    return _indicatorBackView;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.indicatorBackView.width/2, WidthOfScale(4))];
        _indicatorView.backgroundColor = colorF14745;
        _indicatorView.layer.cornerRadius = WidthOfScale(4) / 2;
        _indicatorView.layer.masksToBounds = YES;
    }
    return _indicatorView;
}


- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)data
{
    if (self = [super initWithFrame:frame]) {
        // 属性初始值
        self.viewSize = CGSizeMake([QMUIHelper is40InchScreen] ? 80 : 55, BtnWH);
        self.numberOfSinglePage = NumberOfSinglePage;
        self.viewGap = ViewGap;
        self.viewMargin = ViewMargin;
        self.dataArr = data;
        // 初始化
        [self initDataAndSubviews];
    }
    return self;
}

-(void)initDataAndSubviews{
    
    
    NSInteger pageCount = self.dataArr.count / self.numberOfSinglePage;
    if (self.dataArr.count % self.numberOfSinglePage > 0) {
        pageCount += 1;
    }
    
    NSLog(@"pageCount:%ld",pageCount);
    
    self.indicatorView.width = self.indicatorBackView.width / pageCount;
    UIScrollView * contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _contentScrollView = contentScrollView;
    _contentScrollView.delegate = self;
    contentScrollView.backgroundColor = colorfafafa;
    contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * pageCount, self.frame.size.height);
    contentScrollView.pagingEnabled = NO;
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.showsHorizontalScrollIndicator = NO;

    for (int i = 0; i < pageCount; i++) {
        [self addBtnsWithPageNum:i];
    }
    
    [self addSubview:contentScrollView];
    
    if (pageCount > 1) {
        self.indicatorBackView.center = CGPointMake(self.center.x, self.height-WidthOfScale(20));
        [self addSubview:self.indicatorBackView];
        [self.indicatorBackView addSubview:self.indicatorView];
    }
}

// 循环添加按钮
-(void)addBtnsWithPageNum:(NSInteger)number{
    
    // 添加按钮
    NSInteger maxCol = 4;
    //NSInteger maxRow = 2;
    CGFloat gap = WidthOfScale(self.viewGap); //按钮之间的间隙
    
    CGFloat btnW = WidthOfScale(self.viewSize.width);
    CGFloat btnH = self.viewSize.height;
    CGFloat margin = WidthOfScale(26.5); // 内边距
    NSInteger count = self.dataArr.count - (number * self.numberOfSinglePage);
    NSInteger indexCount;
    if (count > 0 && count <= self.numberOfSinglePage) {
        
        indexCount = count;
    }else if(count > self.numberOfSinglePage){
        
        indexCount = self.numberOfSinglePage;
    }else{
        
        return;
    }
    
    NSLog(@"btnCount:%ld",indexCount);

    for (int i = 0; i<indexCount; i++) {
        QMUIButton  * btn = [[QMUIButton alloc] init];
        
        int col = i % maxCol;
        int row = i / maxCol;
        NSInteger index = i + number * self.numberOfSinglePage;
//        NSDictionary * btnDic = self.dataArr[index];
        EFActivityModel *model = self.dataArr[index];
        //设置图片内容（使图片和文字水平居中显示）
        btn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        //btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:model.iconTitle forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.icon]]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
        [btn setTitleColor:tabbarBlackColor forState:UIControlStateNormal];
        btn.titleLabel.font = RegularFont14;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 设置图片frame
        btn.x = col * (btnW + ([QMUIHelper is40InchScreen] ? WidthOfScale(0) : WidthOfScale(34))) + WidthOfScale(27) + number * self.width;
        btn.y = row * (btnH + WidthOfScale(15)) + WidthOfScale(19.5);
        
        btn.width = btnW;
        btn.height = btnH;
        btn.tag = index;
        btn.imagePosition = QMUIButtonImagePositionTop;
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, [QMUIHelper is40InchScreen] ? 4 : WidthOfScale(11.5), 0);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_contentScrollView addSubview:btn];
    }

}

// 按钮点击事件

-(void)btnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(selectBtnIndex:)]) {
        [self.delegate selectBtnIndex:btn.tag];
    }
    XYLog(@"click:%ld",btn.tag);
}

#pragma mark - scroll delegate 

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

//    NSInteger correntCount = (scrollView.contentOffset.x + self.width/2)/self.width;
//    self.pageControl.currentPage = correntCount;
    CGRect frame = self.indicatorView.frame;
    frame.origin.x = scrollView.contentOffset.x * self.indicatorView.width / (scrollView.contentSize.width - self.frame.size.width);
    NSLog(@"%f",frame.origin.x);
    self.indicatorView.frame = frame;
}

@end
