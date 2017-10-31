//
//  HouseTypeTableViewCell.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/12.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HouseTypeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentScrollViewHeight;
@property (nonatomic ,strong)NSArray *houseTypeArray;
@property (nonatomic ,strong)NSArray *contractArray;
@end
