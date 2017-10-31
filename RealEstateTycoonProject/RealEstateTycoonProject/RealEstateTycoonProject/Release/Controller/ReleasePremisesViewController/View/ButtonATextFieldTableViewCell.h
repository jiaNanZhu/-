//
//  ButtonATextFieldTableViewCell.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/20.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ButtonATextFieldDelegate<NSObject>
-(void)ButtonATextFieldShowAlert:(UIAlertController *)alertC;
@end
@interface ButtonATextFieldTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *delegateViewWidth;
@property (weak, nonatomic) IBOutlet UILabel *delegateLabel;
@property (weak, nonatomic) IBOutlet UIView *delegateView;
@property (weak, nonatomic) IBOutlet UITextField *predictPriceTextField;
@property (weak, nonatomic) id<ButtonATextFieldDelegate>delegate;
@property (copy, nonatomic) void(^buttonATextBlock)(NSString *delegateType);
@property (copy, nonatomic) void(^predictPriceBlock)(NSString *predictPrice);
@end
