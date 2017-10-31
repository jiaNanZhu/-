//
//  HouseTypeImageTableViewCell.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/21.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HouseTypeImageCellDelegate<NSObject>
//添加图片
-(void)addHouseTypeImage;
//删除图片
-(void)delegateHouseTypeImageWithIndex:(NSInteger)index;
@end
@interface HouseTypeImageTableViewCell : UITableViewCell
@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)NSArray *imageArray;
@property (nonatomic ,assign)CGSize  imageSize;
@property (nonatomic ,weak)id<HouseTypeImageCellDelegate>delegate;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier imageArray:(NSMutableArray *)imageArray imageSize:(CGSize)imageSize;
@end
