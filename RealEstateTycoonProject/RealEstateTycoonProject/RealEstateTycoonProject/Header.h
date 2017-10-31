//
//  Header.h
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/6.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#ifndef Header_h
#define Header_h
#import "FMDB.h"
#import "Utile.h"
#import "YYModel.h"
#import "MJRefresh.h"
#import "UIViewController+HUD.h"
#import "AFNetworking.h"
#import "UIImage+image.h"
#import "SDPhotoBrowser.h"
#import "UIColor+Extensiton.h"
#import "UIView+Extension.h"
#import "IQKeyboardManager.h"
#import "ZJNRequestManager.h"
#import "UIImageView+WebCache.h"
#import "UILabel+BoundingRect.h"
#import "BasicViewController.h"

//屏幕宽度
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
//屏幕宽高比
#define ScreenScale  ScreenWidth/320
//屏幕高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//适配字体大小
#define SizeScale (ScreenWidth != 320 ? 1 : 1)
#define TextFont(value) [UIFont systemFontOfSize:value * SizeScale]
#define PXToPtFont(value) [UIFont systemFontOfSize:value * 0.75 * SizeScale]
//根据rgb值设置颜色
#define RGBColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//判断当前机型
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && ScreenHeight == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && ScreenHeight == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && ScreenHeight == 736.0)
//设置16进制颜色
#define SetColor(a) [UIColor colorWithHex:a]
//页面主色
#define MainColor [UIColor colorWithHex:0x34aee1]
//深灰色
#define DarkGray [UIColor colorWithHex:0x333333]
//中灰色
#define MiddleGray [UIColor colorWithHex:0x666666]
//浅灰色
#define LightGray [UIColor colorWithHex:0x999999]
//分割线颜色
#define SeparateLineColor RGBColor(200,198,204,1)

//token
#define Token [[NSUserDefaults standardUserDefaults]objectForKey:@"token"]
/*
 * 网络数据请求
 */
#define RequestUrl @"http://122.114.208.180:8082/"
/*
 * 楼盘模块首页
 */
//广告轮播图
#define Index_AD @"app/index/index_ad"
//楼盘类型
#define Project_Type @"app/index/project_type"
//楼盘列表
#define Project_list @"app/project/projectlist"
//楼盘详情
#define ProjectInfo @"app/project/projectInfo"
//发布需求
#define AddDemand @"app/project/addDemand"
//发布楼盘
#define AddProject @"app/project/addProject"
//需求列表
#define DemandList @"app/project/demandlist"
#endif /* Header_h */
