//
//  ZJNPremisesTableHeaderView.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/7.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "ZJNPremisesTableHeaderView.h"
@interface ZJNPremisesTableHeaderView()<UIScrollViewDelegate>
{
    UIPageControl *pageControll;
    UIScrollView  *mainScroll;
    NSArray       *urlArray;
    
}
@end
@implementation ZJNPremisesTableHeaderView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setThreeButton];
        [self setBottomLine];
        [self getADImageFromService];
    }
    return self;
}
//广告轮播图
-(void)getADImageFromService{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",RequestUrl,Index_AD];
    [ZJNRequestManager postWithUrlString:urlStr parameters:nil success:^(id data) {
        NSLog(@"data");
        
        urlArray = @[@"http://ckezw.com:8081/chuangke/images/d10ea703595d4f43902abe63255b4d4d.png",@"http://ckezw.com:8081/chuangke/images/1c621f952ef7410080bf896681c34f9e.png",@"http://ckezw.com:8081/chuangke/images/25a086a78f85478aaf83c5a0282a81f2.png",@"http://ckezw.com:8081/chuangke/images/4ed1f56c885647eca02456f7ba15dbea.png",@"http://ckezw.com:8081/chuangke/images/da5ce0059a2d4b349007511b9b165a5c.png",@"http://ckezw.com:8081/chuangke/images/50f5467ee42247318afa98cc6bd437ad.png"];
        [self setScrollView];
        [self setpageController];
        if (urlArray.count >0)
        {
            [self setImage];
            
        }
        
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScrollView:) userInfo:nil repeats:YES];
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

//监听tableview的偏移量
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld;
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    //    [self.tableView addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) options:options context:nil];之所以用这种方法是为了防止拼写错误
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (![keyPath isEqualToString:@"contentOffset"]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    UITableView *tableView = (UITableView *)object;
    CGFloat tableViewOffsetY = tableView.contentOffset.y;
    
    if (tableViewOffsetY < (29/64.0)*ScreenWidth-64) {

        self.frame = CGRectMake(0, -tableViewOffsetY, ScreenWidth, (29/64.0)*ScreenWidth+45);
        
    
    }else if (tableViewOffsetY >= (29/64.0)*ScreenWidth-64){
        self.frame = CGRectMake(0, -((29/64.0)*ScreenWidth)+64, ScreenWidth, (29/64.0)*ScreenWidth+45);
        
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(zjnPremisesTableHeaderFrameChanged)]) {
        [self.delegate zjnPremisesTableHeaderFrameChanged];
    }
}
-(void)setScrollView
{
    mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,(29/64.0)*ScreenWidth)];
    [self addSubview:mainScroll];
    mainScroll.delegate = self;
    [mainScroll setContentSize:CGSizeMake(ScreenWidth * (urlArray.count + 2), 0)];
    [mainScroll setPagingEnabled:YES];
    mainScroll.showsHorizontalScrollIndicator = NO;
    mainScroll.showsVerticalScrollIndicator = NO;
    [mainScroll setContentOffset:CGPointMake(ScreenWidth, 0)];
}

- (void)setpageController {
    pageControll = [[UIPageControl alloc]init];
    pageControll.frame = CGRectMake(0, CGRectGetHeight(mainScroll.frame) - 20, ScreenWidth, 20) ;
    [self addSubview:pageControll];
    pageControll.currentPageIndicatorTintColor = MainColor;
    pageControll.pageIndicatorTintColor = [UIColor colorWithHex:0x34aee1 alpha:0.5];
    pageControll.numberOfPages = urlArray.count;
    pageControll.currentPage = 0;
    pageControll.defersCurrentPageDisplay = YES;
}

-(void)setImage
{
    for (int i = 0; i<urlArray.count + 2; i++)
    {
        UIScrollView *s = [[UIScrollView alloc]initWithFrame:CGRectMake(i * ScreenWidth, 0, ScreenWidth, (29/64.0)*ScreenWidth)];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(-1, -1, ScreenWidth+2, (29/64.0)*ScreenWidth+2)];
        
        if (i == 0)
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:urlArray[urlArray.count-1]]];
            imageView.tag = urlArray.count-1;
        }else if (i == urlArray.count +1)
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:urlArray[0]]];
            imageView.tag = 0;
        }else
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:urlArray[i-1]]];
            imageView.tag = i-1;
        }
        [s addSubview:imageView];
        [Utile addClickEvent:self action:@selector(imgClick:) owner:imageView];
        imageView.userInteractionEnabled = YES;
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        imageView.clipsToBounds = YES;
        [mainScroll addSubview:s];
    }
    
}
- (void)setThreeButton{
    NSArray *titleArray = @[@"全部",@"区域",@"类型"];
    for (int i = 0; i <3; i ++) {
        CGFloat width = ScreenWidth/3.0f;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i *width, CGRectGetHeight(self.frame)-45, width, 45);
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"sjx"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"sjx_l"] forState:UIControlStateSelected];
        [button setTitleColor:LightGray forState:UIControlStateNormal];
        [button setTitleColor:MainColor forState:UIControlStateSelected];
        CGFloat imageViewWidth = 10;
        CGFloat labelWidth = 30;
        
        [button setImageEdgeInsets:UIEdgeInsetsMake(0,0 + labelWidth,0,0 - labelWidth)];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:LightGray forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0,0 - imageViewWidth,0, 0 + imageViewWidth)];
        button.tag = i+1;
        
        [self addSubview:button];
    }
}
- (void)setBottomLine{
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-0.5, ScreenWidth, 0.5)];
    lineV.backgroundColor = SeparateLineColor;
    [self addSubview:lineV];
}

-(void)imgClick:(UITapGestureRecognizer *)gesture
{
    UIImageView *imgView = (UIImageView *)gesture.view;
    NSLog(@"当前点击的是第%ld张图片",(long)imgView.tag);
//    if (self.delegate && [(UIViewController *)self.delegate respondsToSelector:@selector(headerViewScrollClick:)])
//    {
//        [self.delegate headerViewScrollClick:imgView.tag];
//    }
}
-(void)buttonClick:(UIButton *)button{
    
    if (button.selected && _signButton==button) {
        _signButton.selected = NO;
    }else if (_signButton == button && !button.selected){
        _signButton.selected = YES;
    }else{
        _signButton.selected = NO;
        button.selected = YES;
        _signButton = button;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(zjnPremisesTableHeaderButtonClickWithTag:selected:)]) {
        [self.delegate zjnPremisesTableHeaderButtonClickWithTag:button.tag selected:_signButton.selected];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger x = scrollView.contentOffset.x/ScreenWidth;
    if (x == urlArray.count +1) {
        [scrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:NO];
        [pageControll setCurrentPage:0];
    }else if (scrollView.contentOffset.x <= 0) {
        [scrollView setContentOffset:CGPointMake(ScreenWidth * urlArray.count,0) animated:NO];
        [pageControll setCurrentPage:urlArray.count-1];
    }else {
        
        [pageControll setCurrentPage:x-1];
    }
}
-(void)autoScrollView:(id)sender
{
    NSInteger x = mainScroll.contentOffset.x/ScreenWidth;
    [mainScroll setContentOffset:CGPointMake((x+1)*ScreenWidth, 0) animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
