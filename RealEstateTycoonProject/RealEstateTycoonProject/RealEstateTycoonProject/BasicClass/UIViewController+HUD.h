//
//  UIViewController+HUD.h
//  XuanMiLaywer
//
//  Created by MAC on 14-9-23.
//  Copyright (c) 2014年 许鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;

- (void)showHint:(NSString *)hint;
// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;
-(void)createShowMessage:(NSString *)labelTitle;
-(void)removeShowMessage;
@end
