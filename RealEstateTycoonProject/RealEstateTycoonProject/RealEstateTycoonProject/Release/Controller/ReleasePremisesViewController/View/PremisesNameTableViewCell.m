//
//  PremisesNameTableViewCell.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/20.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "PremisesNameTableViewCell.h"
@interface PremisesNameTableViewCell ()<UITextFieldDelegate>

@end
@implementation PremisesNameTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textField.delegate = self;
    self.textField.borderStyle = UITextBorderStyleNone;
    // Initialization code
}
#pragma mark--UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.premisesNameBlock) {
        self.premisesNameBlock(textField.text);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
