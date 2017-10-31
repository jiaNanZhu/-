//
//  PremisesInfoTableViewCell.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/12.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PremisesDetailModel.h"
@interface PremisesInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *premisesTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *standardLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (nonatomic ,strong)PremisesDetailModel *detailModel;
@end
