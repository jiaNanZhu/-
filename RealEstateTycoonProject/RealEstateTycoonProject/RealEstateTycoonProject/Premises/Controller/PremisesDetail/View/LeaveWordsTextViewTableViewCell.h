//
//  LeaveWordsTextViewTableViewCell.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/14.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PremisesUserInfoModel.h"
@interface LeaveWordsTextViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authenticImageV;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UIButton *callPhoneButton;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UITextView *leaveWordsTextView;
@property (weak, nonatomic) IBOutlet UILabel *residueLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic ,strong)PremisesUserInfoModel *infoModel;
@end
