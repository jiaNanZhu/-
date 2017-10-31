//
//  ReleaseAddressTableViewCell.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/19.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ReleaseAddressDelegate<NSObject>
-(void)selectAddress;
@end
@interface ReleaseAddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressTextField;
@property (weak, nonatomic) id<ReleaseAddressDelegate>delegate;
@property (copy, nonatomic) void(^detailAddressBlock)(NSString *detailAddress);
@end
