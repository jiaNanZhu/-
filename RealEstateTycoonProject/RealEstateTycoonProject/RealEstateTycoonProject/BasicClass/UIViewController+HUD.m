//
//  UIViewController+HUD.m
//  XuanMiLaywer
//
//  Created by MAC on 14-9-23.
//  Copyright (c) 2014年 许鹏. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.label.text = hint;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
}

- (void)showHint:(NSString *)hint {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    hud.yOffset = ScreenHeight / 2 - 100;
    hud.removeFromSuperViewOnHide = YES;
//    [hud hide:YES afterDelay:2];
    [hud hideAnimated:YES afterDelay:2];
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.yOffset += yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

- (void)hideHud
{
    [[self HUD] hideAnimated:YES];
}

-(void)createShowMessage:(NSString *)labelTitle {
    
    
    UIImageView * ImageView=(UIImageView *)[self.view viewWithTag:333];
    UILabel * label = (UILabel *)[self.view viewWithTag:222];
    
    if (!ImageView) {
        
        UIImageView * ShowImageView= [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2 - 95, ScreenHeight/2 - 45, 90, 90)];
        ShowImageView.image = [UIImage imageNamed:@"123.png"];
        ShowImageView.tag = 333;
        
        [self.view addSubview:ShowImageView];
    }else{
        
    }
    
    if (! label) {
        
        UILabel * Showlabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2 - 5, ScreenHeight/2 + 5, 90, 20)];
        Showlabel.textAlignment = NSTextAlignmentCenter;
        //        Showlabel.textColor = RGB11(212, 212, 212);
        Showlabel.textColor = [UIColor grayColor];
        Showlabel.tag = 222;
        Showlabel.text = labelTitle;
        [self.view addSubview:Showlabel];
    }
}


-(void)removeShowMessage{
    
    UIImageView * ImageView=(UIImageView *)[self.view viewWithTag:333];
    
    
    [ImageView removeFromSuperview];
    
    UILabel * label = (UILabel *)[self.view viewWithTag:222];
    
    [label removeFromSuperview];
}

@end
