//
//  PriceRangeTableViewCell.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/19.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceRangeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *minTextField;
@property (weak, nonatomic) IBOutlet UITextField *maxTextField;
@property (copy, nonatomic) void(^minPriceBlock)(NSString *minPrice);
@property (copy, nonatomic) void(^maxPriceBlock)(NSString *maxPrice);
@end
