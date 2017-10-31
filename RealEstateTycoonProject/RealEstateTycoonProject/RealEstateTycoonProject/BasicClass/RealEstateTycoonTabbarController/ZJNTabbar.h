//
//  ZJNTabbar.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/7.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJNTabbar;

@protocol ZJNTabbarDelegate <NSObject>

@optional
-(void)tabbarPlusButtonClick:(ZJNTabbar *)tabbar;

@end

@interface ZJNTabbar : UITabBar
@property (nonatomic ,weak)id<ZJNTabbarDelegate>myDelegate;
@end
