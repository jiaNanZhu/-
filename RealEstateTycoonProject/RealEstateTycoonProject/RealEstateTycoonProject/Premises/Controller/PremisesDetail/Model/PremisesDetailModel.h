//
//  PremisesDetailModel.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/25.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PremisesUserInfoModel.h"
@interface PremisesDetailModel : NSObject
@property (nonatomic ,strong)NSArray  *adArray;
@property (nonatomic ,strong)NSArray  *houseArray;
@property (nonatomic ,strong)NSArray  *htArray;
@property (nonatomic ,strong)NSString *add_time;
@property (nonatomic ,strong)NSString *agent;
@property (nonatomic ,strong)NSString *area;
@property (nonatomic ,strong)NSString *c_recommend;
@property (nonatomic ,strong)NSString *city;
@property (nonatomic ,strong)NSString *commission;
@property (nonatomic ,strong)NSString *decorate;
@property (nonatomic ,strong)NSString *developer;
@property (nonatomic ,strong)NSString *end_time;
@property (nonatomic ,strong)NSString *lid;
@property (nonatomic ,strong)NSString *info;
@property (nonatomic ,strong)NSString *location;
@property (nonatomic ,strong)NSString *name;
@property (nonatomic ,strong)NSString *payment;
@property (nonatomic ,strong)NSString *price;
@property (nonatomic ,strong)NSString *property;
@property (nonatomic ,strong)NSString *province;
@property (nonatomic ,strong)NSString *recommend;
@property (nonatomic ,strong)NSString *report;
@property (nonatomic ,strong)NSString *size;
@property (nonatomic ,strong)NSString *start_time;
@property (nonatomic ,strong)NSString *status;
@property (nonatomic ,strong)NSString *total;
@property (nonatomic ,strong)NSString *uid;
@property (nonatomic ,strong)PremisesUserInfoModel *userinfo;
-(id)initWithDictionary:(NSDictionary *)detailInfoDic;
@end
