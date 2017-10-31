//
//  DoubleSelectTimeTableViewCell.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/20.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DoubleSelectTimeDelegate<NSObject>
-(void)selectTimeWithType:(NSString *)type;
@end
@interface DoubleSelectTimeTableViewCell : UITableViewCell
@property (nonatomic ,strong)UILabel *openTimeLabel;
@property (nonatomic ,strong)UILabel *giveTimeLabel;
@property (nonatomic ,weak)id<DoubleSelectTimeDelegate>delegate;
@end
