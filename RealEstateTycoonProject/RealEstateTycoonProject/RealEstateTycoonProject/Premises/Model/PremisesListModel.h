//
//  PremisesListModel.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/24.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PremisesListModel : NSObject
@property (nonatomic ,strong)NSString *agent;//代理方式
@property (nonatomic ,strong)NSString *area;//区
@property (nonatomic ,strong)NSString *city;//市
@property (nonatomic ,strong)NSString *lid;//房源ID
@property (nonatomic ,strong)NSString *location;//详细地址
@property (nonatomic ,strong)NSString *name;//小区名称
@property (nonatomic ,strong)NSString *payment;//首付
@property (nonatomic ,strong)NSString *price;//房价
@property (nonatomic ,strong)NSString *province;//省
@property (nonatomic ,strong)NSString *size;//房源面积
@property (nonatomic ,strong)NSString *ad;//封面图
@property (nonatomic ,strong)NSString *recommend;//推荐
@property (nonatomic ,strong)NSString *c_recommendme;//超级推荐
@property (nonatomic ,strong)NSString *add_time;//发布时间
@end
