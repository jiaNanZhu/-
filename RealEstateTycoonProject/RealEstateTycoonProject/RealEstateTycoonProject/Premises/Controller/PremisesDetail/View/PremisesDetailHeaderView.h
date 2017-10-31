//
//  PremisesDetailHeaderView.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/11.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PremisesDetailModel.h"
@protocol PremisesDetailMapDelegate<NSObject>
-(void)premisesDetailSelectMapWithAlertController:(UIAlertController *)alertController;
@end
@interface PremisesDetailHeaderView : UIView
@property (nonatomic ,weak)id<PremisesDetailMapDelegate>delegate;

-(id)initWithFrame:(CGRect)frame premisesDetail:(PremisesDetailModel *)detailModel;
@end
