//
//  Utile.h
//  SYChuangKeProject
//
//  Created by 朱佳男 on 16/6/29.
//  Copyright © 2016年 ShangYuKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Utile : NSObject
//添加单击手势
+(void)addClickEvent:(id)target action:(SEL)action owner:(UIView *)view;
//给某个控件添加圆角
+(void)makeCorner:(CGFloat)corner view:(UIView *)view;
//给某给控件添加边框
+(void)makecorner:(CGFloat)corner view:(UIView *)view color:(UIColor *)color;
//控件边缘添加灰色线条
+(void)setFourSides:(UIView *)view direction:(NSString *)direction sizeW:(CGFloat)width color:(UIColor *)color;
//设置label的不同颜色和大小
+(void)setUILabel:(UILabel *)label data:(NSString *)data setData:(NSString *)setData color:(UIColor *)color font:(CGFloat)font underLine:(BOOL)isbool;
//返回控件的坐标
+(CGFloat)returnViewFrame:(UIView *)view direction:(NSString *)direction;
@end
