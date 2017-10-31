//
//  HouseTypeTableViewCell.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/12.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "HouseTypeTableViewCell.h"
#import "HouseTypeView.h"
#define Width (ScreenWidth-16)/2.0-5
#define SecondWidth (ScreenWidth -16)/3.0-5
@interface HouseTypeTableViewCell()<SDPhotoBrowserDelegate>
{
    NSArray *imageArray;
    SDPhotoBrowser *brower;
}
@end
@implementation HouseTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
-(void)setHouseTypeArray:(NSArray *)houseTypeArray{
    _houseTypeArray = houseTypeArray;
    self.contentScrollViewHeight.constant = (ScreenWidth-16)*0.35;
    self.titleLabel.text = @"热销户型";
    imageArray = _houseTypeArray;
    self.contentScrollView.contentSize = CGSizeMake(imageArray.count*(Width+10)-10, 0);
    
    for (int i = 0; i <imageArray.count; i ++) {
        HouseTypeView *view = [[HouseTypeView alloc]initWithFrame:CGRectMake(i*(Width+10), 0, Width, (ScreenWidth-16)*0.35)];
        view.houseTypeImageV.tag = 20+i;
        [view.houseTypeImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RequestUrl,imageArray[i]]] placeholderImage:[UIImage imageNamed:@"hxpic"]];
        [Utile addClickEvent:self action:@selector(showImageView:) owner:view.houseTypeImageV];
        view.houseTypeLabel.text = @" 三室一厅75m";
        [self.contentScrollView addSubview:view];
    }
}
-(void)setContractArray:(NSArray *)contractArray{
    _contractArray = contractArray;
    self.contentScrollViewHeight.constant = (ScreenWidth-16)*0.4;
    self.titleLabel.text = @"合同图片";
    imageArray = _contractArray;
    self.contentScrollView.contentSize = CGSizeMake(imageArray.count*(SecondWidth+10)-10, 0);
    for (int i = 0; i <imageArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i *(SecondWidth+10), 0, SecondWidth, (ScreenWidth-16)*0.4)];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        imageView.clipsToBounds = YES;
        imageView.tag = 100+i;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RequestUrl,imageArray[i]]] placeholderImage:[UIImage imageNamed:@"htpic"]];
        [Utile addClickEvent:self action:@selector(showImageView:) owner:imageView];
        [self.contentScrollView addSubview:imageView];
    }
}

-(void)showImageView:(UIGestureRecognizer *)recognizer{
    brower = [[SDPhotoBrowser alloc]init];
    UIImageView *views = (UIImageView *)recognizer.view;
    if (self.houseTypeArray==nil) {
        brower.sourceImagesContainerView = views.superview;
        brower.currentImageIndex = views.tag - 100;
    }else{
        brower.sourceImagesContainerView = views.superview.superview;
        brower.currentImageIndex = views.tag - 20;
    }
    brower.imageCount = imageArray.count;
    brower.delegate = self;
    [brower show];
}
#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RequestUrl,imageArray[index]]];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RequestUrl,imageArray[index]]];
    __block UIImage *images;
    [[SDWebImageManager sharedManager]downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (image) {///下载完成
            
            images = image;
        }
    }];
    
    return images;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
