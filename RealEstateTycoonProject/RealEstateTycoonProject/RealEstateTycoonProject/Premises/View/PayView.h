//
//  PayView.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/10.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 * 查看地产详情的时候先支付金豆
 */

@protocol PayViewDelegate <NSObject>

@optional
-(void)payViewSureButtonClickWithPassword:(NSString *)password;

@end
@interface PayView : UIView
@property (nonatomic ,weak)id<PayViewDelegate>delegate;
@end
