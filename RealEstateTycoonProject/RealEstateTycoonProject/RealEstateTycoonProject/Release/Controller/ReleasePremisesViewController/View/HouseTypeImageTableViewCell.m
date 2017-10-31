//
//  HouseTypeImageTableViewCell.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/21.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "HouseTypeImageTableViewCell.h"
#import "AddImageView.h"
@interface HouseTypeImageTableViewCell()<AddImageViewDelegate>
{
    AddImageView *addImageV;
}
@end
@implementation HouseTypeImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier imageArray:(NSMutableArray *)imageArray imageSize:(CGSize)imageSize{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, ScreenWidth-60, 44)];
        _titleLabel.font = TextFont(16);
        _titleLabel.textColor = SetColor(0x333333);
        [self.contentView addSubview:_titleLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(8, 44, ScreenWidth-16, 0.5)];
        lineView.backgroundColor = SeparateLineColor;
        [self.contentView addSubview:lineView];
        
        _imageSize = imageSize;
        
        UIImageView *photoImageV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame)+7, _titleLabel.centerY-15, 30, 30)];
        photoImageV.image = [UIImage imageNamed:@"xj"];
        [self.contentView addSubview:photoImageV];
        
        UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        photoButton.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame), 0, 44, 44);
//        [photoButton setBackgroundImage:[UIImage imageNamed:@"xj"] forState:UIControlStateNormal];
        [photoButton addTarget:self action:@selector(photoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:photoButton];
    }
    return self;
}
-(void)setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    if (!addImageV) {
        addImageV = [[AddImageView alloc]initWithFrame:CGRectMake(8, 50, ScreenWidth-16, 15+_imageSize.height) imageArray:imageArray imageSize:_imageSize];
        
        addImageV.delegate = self;
        [self.contentView addSubview:addImageV];
    }else{
        [addImageV updateAddImageViewWithImageArr:imageArray];
    }
    
}
//
-(void)photoButtonClick{
    [self addImageViewAddImageButtonClick];
}
#pragma mark--AddImageViewDelegate
-(void)addImageViewAddImageButtonClick{
    //添加图片
    if (self.delegate && [self.delegate respondsToSelector:@selector(addHouseTypeImage)]) {
        [self.delegate addHouseTypeImage];
    }
}
-(void)deleteImageViewDelImageButtonClick:(NSInteger)index{
    //删除图片
    if (self.delegate && [self.delegate respondsToSelector:@selector(delegateHouseTypeImageWithIndex:)]) {
        [self.delegate delegateHouseTypeImageWithIndex:index];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
