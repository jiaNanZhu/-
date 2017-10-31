//
//  PremisesParameterTableViewCell.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/21.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "PremisesParameterTableViewCell.h"
@interface PremisesParameterTableViewCell()<UITextFieldDelegate>
{
    NSString *type;
}
@end
@implementation PremisesParameterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [Utile addClickEvent:self action:@selector(selectPremisesType) owner:self.premisesTypeView];
    
    [Utile addClickEvent:self action:@selector(selectStandard) owner:self.standardView];
    
    self.developersNameTextField.delegate = self;
    self.developersNameTextField.borderStyle = UITextBorderStyleNone;
}
-(void)updateConstraints{
    [super updateConstraints];
    
    self.typeViewWidth.constant = ScreenWidth/2.0-65-16;
    
    NSLayoutConstraint *typeLableWidth = [NSLayoutConstraint constraintWithItem:self.typeLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:ScreenWidth/2.0-65-16-16];
    [self.typeLabel addConstraint:typeLableWidth];
    
    NSLayoutConstraint *standardLableWidth = [NSLayoutConstraint constraintWithItem:self.standardLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:ScreenWidth/2.0-65-16-16];
    [self.standardLabel addConstraint:standardLableWidth];
//    [self.typeViewWidth setActive:YES];
}
//选择楼盘类型
-(void)selectPremisesType{
    type = @"1";
    NSArray *stateArray = @[@"住宅",@"别墅",@"酒店",@"办公",@"商铺",@"其它"];
    [self showAlertWithTitleArray:stateArray];
}
//选择装修标准
-(void)selectStandard{
    type = @"2";
    NSArray *stateArray = @[@"精装",@"毛坯",@"自选",@"其它"];
    [self showAlertWithTitleArray:stateArray];
}
-(void)showAlertWithTitleArray:(NSArray *)titleArr{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i <titleArr.count; i ++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleArr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            if ([type isEqualToString:@"1"]) {
                self.typeLabel.text = titleArr[i];
                
            }else{
                self.standardLabel.text = titleArr[i];
                
            }
            if (self.premisesParameterBlock) {
                self.premisesParameterBlock(@{@"type":type,@"info":titleArr[i]});
            }
        }];
        [action setValue:MainColor forKey:@"_titleTextColor"];
        [alert addAction:action];
    }
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [action setValue:MiddleGray forKey:@"_titleTextColor"];
    [alert addAction:action];
    if (titleArr.count >5) {
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:alert.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:350];
        [alert.view addConstraint:height];
    }
    
        
    if (self.delegate && [self.delegate respondsToSelector:@selector(premisesParameterSelectTypeOrStandarWithAlertController:)]) {
        [self.delegate premisesParameterSelectTypeOrStandarWithAlertController:alert];
    }
    
}
#pragma mark--
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.developerNameBlock) {
        self.developerNameBlock(textField.text);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
