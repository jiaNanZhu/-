//
//  ZJNPremisesTableHeaderView.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/7.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZJNPremisesTableHeaderDelegate<NSObject>
@optional
-(void)zjnPremisesTableHeaderButtonClickWithTag:(NSInteger)tag selected:(BOOL)isSelected;
-(void)zjnPremisesTableHeaderFrameChanged;
@end
@interface ZJNPremisesTableHeaderView : UIView
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)UIButton    *signButton;
@property (nonatomic ,weak)id<ZJNPremisesTableHeaderDelegate>delegate;
@end
