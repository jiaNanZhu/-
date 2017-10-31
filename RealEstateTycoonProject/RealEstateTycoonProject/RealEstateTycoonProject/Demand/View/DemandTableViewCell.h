//
//  DemandTableViewCell.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/17.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemandTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authenImageV;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *souceLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeLabelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *souceLabelWidth;

@end
