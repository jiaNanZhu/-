//
//  ReleaseAddressTableViewCell.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/19.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "ReleaseAddressTableViewCell.h"
@interface ReleaseAddressTableViewCell()<UITextFieldDelegate>

@end
@implementation ReleaseAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile addClickEvent:self action:@selector(selectAddress) owner:self.addressLabel];
    self.detailAddressTextField.delegate = self;
    self.detailAddressTextField.borderStyle = UITextBorderStyleNone;
    // Initialization code
}
-(void)selectAddress{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectAddress)]) {
        [self.delegate selectAddress];
    }
}
#pragma mark--
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.detailAddressBlock) {
        self.detailAddressBlock(textField.text);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
