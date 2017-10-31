//
//  DemandDetailTableViewCell.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/19.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemandDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *souceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeLabelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *souceLabelWidth;

@end
