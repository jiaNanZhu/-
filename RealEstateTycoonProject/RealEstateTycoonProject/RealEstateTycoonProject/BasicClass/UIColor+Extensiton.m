//
//  UIColor+Extensiton.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/7.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "UIColor+Extensiton.h"

@implementation UIColor (Extensiton)
+ (id)colorWithHex:(unsigned int)hex {
    return [UIColor colorWithHex:hex alpha:1.0];
}

+ (id)colorWithHex:(unsigned int)hex alpha:(float)alpha {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:alpha];
    
    
    
    
}

@end
