//
//  UILabel+BoundingRect.h
//  SYChuangKeProject
//
//  Created by yu on 16/7/22.
//  Copyright © 2016年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (BoundingRect)
//初始化的size，size中高度或者宽度为0
-(CGRect)boundingRectWithInitSize:(CGSize)size;
@end
