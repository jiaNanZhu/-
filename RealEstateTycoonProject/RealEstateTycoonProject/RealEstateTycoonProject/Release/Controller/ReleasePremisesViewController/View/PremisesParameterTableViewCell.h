//
//  PremisesParameterTableViewCell.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/21.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PremisesParameterDelegate<NSObject>
-(void)premisesParameterSelectTypeOrStandarWithAlertController:(UIAlertController *)alertC;

@end
@interface PremisesParameterTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeViewWidth;
@property (weak, nonatomic) IBOutlet UIView *premisesTypeView;
@property (weak, nonatomic) IBOutlet UIView *standardView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *standardLabel;
@property (weak, nonatomic) IBOutlet UITextField *developersNameTextField;
@property (weak, nonatomic) id<PremisesParameterDelegate>delegate;
@property (copy, nonatomic) void(^premisesParameterBlock)(NSDictionary *infoDic);
@property (copy, nonatomic) void(^developerNameBlock)(NSString *developerName);
@end
