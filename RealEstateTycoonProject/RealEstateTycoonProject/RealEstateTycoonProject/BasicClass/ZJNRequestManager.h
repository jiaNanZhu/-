//
//  ZJNNetWorking.h
//  OfficeAutomationSystem
//
//  Created by 朱佳男 on 2016/10/26.
//  Copyright © 2016年 ShangYuKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJNRequestManager : NSObject
//宏定义请求成功block 回调成功后得到的信息
typedef void (^HttpSuccess)(id data);
//宏定义请求失败block 回调失败后得到的信息
typedef void (^HttpFailure)(NSError *error);
//get请求
+(void)getWithUrlString:(NSString *)urlString success:(HttpSuccess)success failure:(HttpFailure)failure;

//post请求
+(void)postWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(HttpSuccess)success failure:(HttpFailure)failure;

@end
