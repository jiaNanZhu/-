//
//  AreaPremisesView.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/7.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AreaPremisesViewDelegate<NSObject>
-(void)areaPremisesViewSelectedAddress:(NSDictionary *)address;
@end
@interface AreaPremisesView : UIView
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,weak)id<AreaPremisesViewDelegate>delegate;
-(void)updateFrameWithFrame:(CGRect)frame;
@end
