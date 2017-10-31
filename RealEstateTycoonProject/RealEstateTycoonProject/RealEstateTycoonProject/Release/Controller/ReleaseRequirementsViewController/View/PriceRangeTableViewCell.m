//
//  PriceRangeTableViewCell.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/19.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "PriceRangeTableViewCell.h"
@interface PriceRangeTableViewCell()<UITextFieldDelegate>

@end
@implementation PriceRangeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.minTextField.delegate = self;
    self.maxTextField.delegate = self;
    self.minTextField.borderStyle = UITextBorderStyleNone;
    self.maxTextField.borderStyle = UITextBorderStyleNone;
    // Initialization code
}
#pragma mark--
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.minTextField) {
        if (self.minPriceBlock) {
            self.minPriceBlock(textField.text);
        }
    }else{
        if (self.maxPriceBlock) {
            self.maxPriceBlock(textField.text);
        }
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
