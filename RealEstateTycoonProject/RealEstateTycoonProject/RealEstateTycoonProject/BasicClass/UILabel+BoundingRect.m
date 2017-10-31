//
//  UILabel+BoundingRect.m
//  SYChuangKeProject
//
//  Created by yu on 16/7/22.
//  Copyright © 2016年 ShangYuKeJi. All rights reserved.
//

#import "UILabel+BoundingRect.h"

@implementation UILabel (BoundingRect)
//初始化的size，size中高度或者宽度为0
-(CGRect)boundingRectWithInitSize:(CGSize)size{
    self.lineBreakMode=NSLineBreakByWordWrapping;
    
    CGRect rect=[self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil];
    CGRect kRect = rect;
//    kRect.size.height +=8;
    return kRect;
}

@end
