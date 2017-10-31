//
//  PayView.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/10.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "PayView.h"
#import "ZJNPasswordTextField.h"
@interface PayView()<UITextFieldDelegate,ZJNPasswordTextFieldDelegate>
{
    NSMutableArray *textFieldArray;
}
@end
@implementation PayView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
        [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
        self.backgroundColor = [UIColor whiteColor];
        textFieldArray = [NSMutableArray array];
        [Utile makeCorner:5 view:self];
        [self creatView];
    }
    return self;
}

-(void)creatView{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, CGRectGetWidth(self.frame)-48, 40)];
    titleLabel.text = @"请输入支付密码";
    titleLabel.textColor = DarkGray;
    [self addSubview:titleLabel];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, 40, 40);
    [closeButton setImage:[UIImage imageNamed:@"gb"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeCurrentView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
    
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), self.width, 0.5)];
    topLine.backgroundColor = SetColor(0xcccccc);
    [self addSubview:topLine];
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topLine.frame)+20, self.width, 25)];
    moneyLabel.text = @"支付1金豆";
    moneyLabel.textColor = DarkGray;
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.font = TextFont(20);
    [self addSubview:moneyLabel];
    
    UIView *textFieldView = [[UIView alloc]initWithFrame:CGRectMake((self.width-240)/2.0, CGRectGetMaxY(moneyLabel.frame)+20, 240, 40)];
    textFieldView.layer.borderColor = SetColor(0xcccccc).CGColor;
    textFieldView.layer.borderWidth = 0.5;
    [self addSubview:textFieldView];
    
    for (int i = 0; i <6; i ++) {
        ZJNPasswordTextField *textField = [[ZJNPasswordTextField alloc]initWithFrame:CGRectMake(i*40, 0, 40, 40)];
        textField.keyboardType = UIKeyboardTypePhonePad;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.secureTextEntry = YES;
        
        if (i <5) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake((i+1)*40, 0, 0.5, 40)];
            line.backgroundColor = SetColor(0xcccccc);
            [textFieldView addSubview:line];
        }
        if (i == 0) {
            [textField becomeFirstResponder];
        }
        textField.tintColor = [UIColor clearColor];
        textField.tag = 100+i;
        textField.delegate = self;
        textField.zjn_delegate = self;
        [textFieldView addSubview:textField];
        [textFieldArray addObject:textField];
    }
    //创建一个view遮挡住上边创建的六个textfield使其不能被点击
    UIView *coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, textFieldView.width, 40)];
    [textFieldView addSubview:coverView];
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(textFieldView.frame)+10, self.width, 0.5)];
    bottomLine.backgroundColor = SetColor(0xcccccc);
    [self addSubview:bottomLine];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, CGRectGetMaxY(bottomLine.frame), self.width/2.0, 45);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:SetColor(0xcccccc) forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(closeCurrentView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];
    [Utile setFourSides:cancelButton direction:@"right" sizeW:45 color:SetColor(0xcccccc)];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(CGRectGetMaxX(cancelButton.frame), CGRectGetMaxY(bottomLine.frame), self.width/2.0, 45);
    [sureButton setTitleColor:MainColor forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [self addSubview:sureButton];
    
}
//将当前页面移除
-(void)closeCurrentView{
    [self removeFromSuperview];
}
//点击确定按钮实现方法
-(void)sureButtonClick{
    NSString *password = @"";
    for (ZJNPasswordTextField *textField in textFieldArray) {
        if (textField.text.length == 0) {
            return;
        }else{
            password = [NSString stringWithFormat:@"%@%@",password,textField.text];
        }
    }

    //所有的textfield失去第一响应
    for (ZJNPasswordTextField *textfield in textFieldArray) {
        [textfield resignFirstResponder];
    }
    //从页面上移除self
    [self removeFromSuperview];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(payViewSureButtonClickWithPassword:)]) {
        [self.delegate payViewSureButtonClickWithPassword:password];
    }
}
#pragma mark--UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    textField.text = string;
    
    if (textField.text.length > 0) {//防止退格第一个的时候往后跳一格
        
        if (textField.tag<  [[textFieldArray lastObject] tag]) {
            
            UITextField *newTF =  (UITextField *)[self viewWithTag:textField.tag+1];
            
            [newTF becomeFirstResponder];
        }
        
    }else{
        
    }
    
    return NO;
}
#pragma mark--ZJNPasswordTextFieldDelegate
-(void)ZJNTextFieldDeleteBackward:(ZJNPasswordTextField *)textField{
    
    if (textField.tag > [[textFieldArray firstObject] tag]) {
        UITextField *newTF =  (UITextField *)[self viewWithTag:textField.tag-1];
        newTF.text = @"";
        [newTF becomeFirstResponder];
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
