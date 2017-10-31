//
//  PremisesListTableViewCell.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/7.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PremisesListModel.h"
@interface PremisesListTableViewCell : UITableViewCell
//封面图
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
//小区名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//小区面积
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
//每平米价格
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
//代理
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
//首付
@property (weak, nonatomic) IBOutlet UILabel *downPaymentLabel;
//地址
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
//推荐
@property (weak, nonatomic) IBOutlet UIImageView *recommendImageView;
@property (nonatomic ,strong)PremisesListModel *model;
@end
