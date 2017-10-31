//
//  Utile.m
//  SYChuangKeProject
//
//  Created by 朱佳男 on 16/6/29.
//  Copyright © 2016年 ShangYuKeJi. All rights reserved.
//

#import "Utile.h"

@implementation Utile
+(void)addClickEvent:(id)target action:(SEL)action owner:(UIView *)view
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    gesture.numberOfTouchesRequired = 1;
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:gesture];
}
+(void)makeCorner:(CGFloat)corner view:(UIView *)view
{
    CALayer *layer = view.layer;
    layer.cornerRadius = corner;
    layer.masksToBounds = YES;
}
+(void)makecorner:(CGFloat)corner view:(UIView *)view color:(UIColor *)color
{
    CALayer *layer = view.layer;
    layer.borderColor = color.CGColor;
    layer.borderWidth = corner;
}
+(void)setFourSides:(UIView *)view direction:(NSString *)direction sizeW:(CGFloat)width color:(UIColor *)color
{
    if ([direction isEqualToString:@"left"]) {
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, (view.frame.size.height-width)/2.0f, 0.5, width)];
        bottomview.backgroundColor = color;
        [view addSubview:bottomview];
    }else if ([direction isEqualToString:@"right"])
    {
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(view.frame.size.width - 0.5, (view.frame.size.height-width)/2.0f, 0.5, width)];
        bottomview.backgroundColor = color;
        [view addSubview:bottomview];
    }else if ([direction isEqualToString:@"top"])
    {
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0.5)];
        bottomview.backgroundColor = color;
        [view addSubview:bottomview];
    }else if ([direction isEqualToString:@"bottom"])
    {
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 0.5, width, 0.5)];
        bottomview.backgroundColor = color;
        [view addSubview:bottomview];
    }
}
+(void)setUILabel:(UILabel *)label data:(NSString *)data setData:(NSString *)setData color:(UIColor *)color font:(CGFloat)font underLine:(BOOL)isbool
{
    NSRange range = [label.text rangeOfString:setData];
    if (range.location != NSNotFound) {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:label.text];
        [string addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(data.length, setData.length)];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(data.length, setData.length)];
        if (isbool) {
            [string addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(data.length, setData.length)];
        }
        label.attributedText = string;
    }
}

+(CGFloat)returnViewFrame:(UIView *)view direction:(NSString *)direction
{
    if ([direction isEqualToString:@"X"]) {
        return view.frame.origin.x+view.frame.size.width;
    }else
    {
        return view.frame.origin.y+view.frame.size.height;
    }
}
@end
