//
//  ZJNPasswordTextField.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/10.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "ZJNPasswordTextField.h"

@implementation ZJNPasswordTextField
-(void)deleteBackward{
    [super deleteBackward];
    if (self.zjn_delegate && [self.zjn_delegate respondsToSelector:@selector(ZJNTextFieldDeleteBackward:)]) {
        [self.zjn_delegate ZJNTextFieldDeleteBackward:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
