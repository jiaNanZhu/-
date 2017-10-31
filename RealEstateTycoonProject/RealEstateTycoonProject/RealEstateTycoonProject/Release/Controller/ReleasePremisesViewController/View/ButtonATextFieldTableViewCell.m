//
//  ButtonATextFieldTableViewCell.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/20.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "ButtonATextFieldTableViewCell.h"
@interface ButtonATextFieldTableViewCell()<UITextFieldDelegate>

@end
@implementation ButtonATextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [Utile addClickEvent:self action:@selector(selectDelegate) owner:self.delegateView];
    self.predictPriceTextField.delegate = self;
    self.predictPriceTextField.borderStyle = UITextBorderStyleNone;
    // Initialization code
}
//选择楼盘代理
-(void)selectDelegate{
    NSArray *stateArray = @[@"全案",@"联合",@"自销",@"其它"];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i <stateArray.count; i ++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:stateArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            self.delegateLabel.text = stateArray[i];
            if (self.buttonATextBlock) {
                self.buttonATextBlock(stateArray[i]);
            }
        }];
        [action setValue:MainColor forKey:@"_titleTextColor"];
        [alert addAction:action];
    }
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [action setValue:MiddleGray forKey:@"_titleTextColor"];
    [alert addAction:action];
    if (stateArray.count >5) {
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:alert.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:350];
        [alert.view addConstraint:height];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(ButtonATextFieldShowAlert:)]) {
        [self.delegate ButtonATextFieldShowAlert:alert];
    }
    
}
#pragma mark--
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.predictPriceBlock) {
        self.predictPriceBlock(textField.text);
    }
}
-(void)updateConstraints{
    [super updateConstraints];
    self.delegateViewWidth.constant = ScreenWidth/2.0-65-16;
    
    NSLayoutConstraint *standardLableWidth = [NSLayoutConstraint constraintWithItem:self.delegateLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:ScreenWidth/2.0-65-16-16];
    [self.delegateLabel addConstraint:standardLableWidth];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
