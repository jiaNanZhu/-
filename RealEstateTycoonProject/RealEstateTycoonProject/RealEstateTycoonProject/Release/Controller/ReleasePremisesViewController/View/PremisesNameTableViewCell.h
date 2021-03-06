//
//  PremisesNameTableViewCell.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/20.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PremisesNameTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (copy, nonatomic) void(^premisesNameBlock)(NSString *premisesName);
@end
