//
//  PremisesInfoAndRuleTableViewCell.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/21.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PremisesInfoAndRuleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *policeHolderLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (copy, nonatomic) void(^textViewBlock)(NSString *text);
@end
