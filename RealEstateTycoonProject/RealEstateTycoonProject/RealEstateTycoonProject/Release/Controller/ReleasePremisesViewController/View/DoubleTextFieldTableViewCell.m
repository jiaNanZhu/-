//
//  DoubleTextFieldTableViewCell.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/20.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "DoubleTextFieldTableViewCell.h"
@interface DoubleTextFieldTableViewCell ()<UITextFieldDelegate>

@end
@implementation DoubleTextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.leftTextField.delegate = self;
    self.rightTextField.delegate = self;
    self.leftTextField.borderStyle = UITextBorderStyleNone;
    self.rightTextField.borderStyle = UITextBorderStyleNone;
    // Initialization code
}
#pragma mark--UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.leftTextField) {
        if (self.leftTextFieldBlock) {
            self.leftTextFieldBlock(textField.text);
        }
    }else{
        if (self.rightTextFieldBlock) {
            self.rightTextFieldBlock(textField.text);
        }
    }
}
-(void)updateConstraints{
    [super updateConstraints];
    self.leftTextFieldWidth.constant = ScreenWidth/2.0-65-16;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
