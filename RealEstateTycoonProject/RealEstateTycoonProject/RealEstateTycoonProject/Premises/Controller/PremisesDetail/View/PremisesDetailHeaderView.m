//
//  PremisesDetailHeaderView.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/11.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "PremisesDetailHeaderView.h"
#import <MapKit/MapKit.h>
@interface PremisesDetailHeaderView()<UIScrollViewDelegate>
{
    PremisesDetailModel *_detailModel;
    UIPageControl *pageControll;
    UIScrollView  *mainScroll;
    NSArray       *urlArray;
}
@property (nonatomic, strong) NSString *urlScheme;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end
@implementation PremisesDetailHeaderView
- (id)initWithFrame:(CGRect)frame premisesDetail:(PremisesDetailModel *)detailModel{
    self = [super initWithFrame:frame];
    if (self) {
        _detailModel = detailModel;
        urlArray = _detailModel.adArray;
        [self setScrollView];
        [self setpageController];
        if (urlArray.count >0)
        {
            [self setImage];
            
        }
        [self setInfoView];
        [self setBottomLine];
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScrollView:) userInfo:nil repeats:YES];
    }
    return self;
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
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RequestUrl,urlArray[urlArray.count-1]]]];
            imageView.tag = urlArray.count-1;
        }else if (i == urlArray.count +1)
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RequestUrl,urlArray[0]]]];
            imageView.tag = 0;
        }else
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RequestUrl,urlArray[i-1]]]];
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
-(void)setInfoView{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(mainScroll.frame)+8, self.width-56, 30)];
    titleLabel.textColor = DarkGray;
    titleLabel.font = TextFont(16);
    titleLabel.text = [NSString stringWithFormat:@"(%@)%@",_detailModel.city,_detailModel.name];
    [self addSubview:titleLabel];
    
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collectButton.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame), CGRectGetMaxY(mainScroll.frame)+3, 40, 40);
    [collectButton setImage:[UIImage imageNamed:@"sc_hh"] forState:UIControlStateNormal];
    [self addSubview:collectButton];
    
    for (int i =0; i <6; i ++) {
        NSInteger x = i%2;
        NSInteger y = i/2;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(8+x*(self.width/2.0), CGRectGetMaxY(collectButton.frame)+15+y*25, self.width/2.0-16, 15)];
        label.textColor = MiddleGray;
        label.font = TextFont(15);
        label.tag = 10+i;
        [self addSubview:label];
        if (i == 0) {
            label.text = [NSString stringWithFormat:@"均价:%@/m²",_detailModel.price];
            [Utile setUILabel:label data:nil setData:@"均价:" color:LightGray font:15*SizeScale underLine:NO];
        }else if (i == 1){
            label.text = [NSString stringWithFormat:@"房屋面积:%@m²",_detailModel.size];
            [Utile setUILabel:label data:nil setData:@"房屋面积:" color:LightGray font:15*SizeScale underLine:NO];
        }else if (i == 2){
            label.text = [NSString stringWithFormat:@"楼盘代理:%@",_detailModel.agent];
            [Utile setUILabel:label data:nil setData:@"楼盘代理:" color:LightGray font:15*SizeScale underLine:NO];
        }else if (i == 3){
            label.text = [NSString stringWithFormat:@"预计总价:%@万",_detailModel.total];
            [Utile setUILabel:label data:nil setData:@"总价范围:" color:LightGray font:15*SizeScale underLine:NO];
        }else if (i == 4){
            label.text = [NSString stringWithFormat:@"首付:%@万起",_detailModel.payment];
            [Utile setUILabel:label data:nil setData:@"首付:" color:LightGray font:15*SizeScale underLine:NO];
        }else{
            label.text = [NSString stringWithFormat:@"佣金额:%@万",_detailModel.commission];
            [Utile setUILabel:label data:nil setData:@"佣金额:" color:LightGray font:15*SizeScale underLine:NO];
        }
    }
    
    UILabel *basicLabel = (UILabel *)[self viewWithTag:15];
    
    UIImageView *addressImageV = [[UIImageView alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(basicLabel.frame)+15, 16, 16)];
    addressImageV.image = [UIImage imageNamed:@"wz"];
    [self addSubview:addressImageV];
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(addressImageV.frame)+2, CGRectGetMaxY(basicLabel.frame)+15, self.width-54, 16)];
    addressLabel.numberOfLines = 0;
    addressLabel.font = TextFont(15);
    addressLabel.textColor = MiddleGray;
    addressLabel.text = [NSString stringWithFormat:@"楼盘地址:%@%@%@%@",_detailModel.province,_detailModel.city,_detailModel.area,_detailModel.location];
    [Utile setUILabel:addressLabel data:nil setData:@"楼盘地址:" color:LightGray font:15*SizeScale underLine:NO];
    [Utile addClickEvent:self action:@selector(addressLabelClick) owner:addressLabel];
    CGRect rect = [addressLabel boundingRectWithInitSize:CGSizeMake(self.width-54, MAXFLOAT)];
    addressLabel.frame = CGRectMake(CGRectGetMaxX(addressImageV.frame)+2, CGRectGetMaxY(basicLabel.frame)+15, self.width-54, CGRectGetHeight(rect));
    [self addSubview:addressLabel];
    
    UIImageView *arrowImageV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(addressLabel.frame), CGRectGetMaxY(addressLabel.frame)-20, 20, 20)];
    arrowImageV.image = [UIImage imageNamed:@"kz"];
    [self addSubview:arrowImageV];

    UIImageView *timeImageV = [[UIImageView alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(addressLabel.frame)+8, 16, 16)];
    timeImageV.image = [UIImage imageNamed:@"rl"];
    [self addSubview:timeImageV];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeImageV.frame)+2, CGRectGetMaxY(addressLabel.frame)+8, self.width-34, 16)];
    timeLabel.font = TextFont(15);
    timeLabel.textColor = LightGray;
    timeLabel.text = [NSString stringWithFormat:@"预计开盘:%@",_detailModel.start_time];
//    [Utile setUILabel:timeLabel data:nil setData:@"预计开盘:" color:LightGray font:15*SizeScale underLine:NO];
    [self addSubview:timeLabel];
    
    UIImageView *endTimeImageV = [[UIImageView alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(timeImageV.frame)+8, 16, 16)];
    endTimeImageV.image = [UIImage imageNamed:@"rl"];
    [self addSubview:endTimeImageV];
    
    UILabel *endTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(endTimeImageV.frame)+2, CGRectGetMaxY(timeImageV.frame)+8, self.width-34, 16)];
    endTimeLabel.font = TextFont(15);
    endTimeLabel.textColor = LightGray;
    endTimeLabel.text = [NSString stringWithFormat:@"交房时间:%@",_detailModel.end_time];
//    [Utile setUILabel:endTimeLabel data:nil setData:@"交房时间:" color:LightGray font:15*SizeScale underLine:NO];
    [self addSubview:endTimeLabel];
}
- (void)setBottomLine{
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-8, ScreenWidth, 8)];
    lineV.backgroundColor = RGBColor(245, 245, 245, 1);
    [self addSubview:lineV];
}

-(void)imgClick:(UITapGestureRecognizer *)gesture
{
    UIImageView *imgView = (UIImageView *)gesture.view;
    NSLog(@"当前点击的是第%ld张图片",(long)imgView.tag);
    
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
//判断当前手机上安装的地图软件
-(void)addressLabelClick{
    
    __block NSString *urlScheme = @"RealEstateTycoon";
    __block NSString *appName = @"房产大咖";
    __block CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(40.010024,116.392239);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //这个判断其实是不需要的
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com/"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"苹果地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
            
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        }];
        [action setValue:MainColor forKey:@"_titleTextColor"];
        [alert addAction:action];
    }
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        [action setValue:MainColor forKey:@"_titleTextColor"];
        [alert addAction:action];
    }
    
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",appName,urlScheme,coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        [action setValue:MainColor forKey:@"_titleTextColor"];
        [alert addAction:action];
    }
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"谷歌地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",appName,urlScheme,coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        [action setValue:MainColor forKey:@"_titleTextColor"];
        [alert addAction:action];
    }
    
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [action setValue:MiddleGray forKey:@"_titleTextColor"];
    [alert addAction:action];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(premisesDetailSelectMapWithAlertController:)]) {
        [self.delegate premisesDetailSelectMapWithAlertController:alert];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
