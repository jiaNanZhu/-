//
//  ContractImageTableViewCell.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/21.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ContractImageCellDelegate<NSObject>
//添加图片
-(void)addContractImage;
//删除图片
-(void)deleteContractImageWithIndex:(NSInteger)index;
@end
@interface ContractImageTableViewCell : UITableViewCell
@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)NSArray *imageArray;
@property (nonatomic ,assign)CGSize  imageSize;
@property (nonatomic ,weak)id<ContractImageCellDelegate>delegate;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier imageArray:(NSMutableArray *)imageArray imageSize:(CGSize)imageSize;
@end
