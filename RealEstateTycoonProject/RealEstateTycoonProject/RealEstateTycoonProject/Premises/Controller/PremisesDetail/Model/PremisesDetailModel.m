//
//  PremisesDetailModel.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/25.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "PremisesDetailModel.h"

@implementation PremisesDetailModel
-(id)initWithDictionary:(NSDictionary *)detailInfoDic{
    self = [super init];
    if (self) {
        self.adArray = detailInfoDic[@"ad"];
        self.houseArray = detailInfoDic[@"house"];
        self.htArray = detailInfoDic[@"ht"];
        
        self.add_time = detailInfoDic[@""];
        self.agent = detailInfoDic[@"agent"];
        self.area = detailInfoDic[@"area"];
        self.c_recommend = detailInfoDic[@"c_recommend"];
        self.city = detailInfoDic[@"city"];
        self.commission = detailInfoDic[@"commission"];
        self.decorate = detailInfoDic[@"decorate"];
        self.developer = detailInfoDic[@"developer"];
        self.end_time = detailInfoDic[@"end_time"];
        self.lid = detailInfoDic[@"lid"];
        self.info = detailInfoDic[@"info"][0];
        self.location = detailInfoDic[@"location"];
        self.name = detailInfoDic[@"name"];
        self.payment = detailInfoDic[@"payment"];
        self.price = detailInfoDic[@"price"];
        self.property = detailInfoDic[@"property"];
        self.province = detailInfoDic[@"province"];
        self.recommend = detailInfoDic[@"recommend"];
        self.report = detailInfoDic[@"report"];
        self.size = detailInfoDic[@"size"];
        self.start_time = detailInfoDic[@"start_time"];
        self.status = detailInfoDic[@"status"];
        self.total = detailInfoDic[@"total"];
        self.uid = detailInfoDic[@"uid"];
        self.userinfo = [PremisesUserInfoModel yy_modelWithDictionary:detailInfoDic[@"userInfo"]];
    }
    return self;
}
@end
