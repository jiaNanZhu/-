//
//  ZJNPasswordTextField.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/10.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJNPasswordTextField;

@protocol ZJNPasswordTextFieldDelegate <NSObject>

@optional
-(void)ZJNTextFieldDeleteBackward:(ZJNPasswordTextField *)textField;

@end

@interface ZJNPasswordTextField : UITextField
@property (nonatomic ,weak)id<ZJNPasswordTextFieldDelegate>zjn_delegate;
@end
