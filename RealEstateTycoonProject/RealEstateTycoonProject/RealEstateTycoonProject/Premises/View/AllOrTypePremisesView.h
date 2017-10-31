//
//  AllOrTypePremisesView.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/7.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AllOrTypePremisesDelegate<NSObject>

@end
@interface AllOrTypePremisesView : UIView
@property (nonatomic,strong)NSArray     *titleArr;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)void(^allOrTypePremisesBlock)(NSString *str);
@end
