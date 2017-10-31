//
//  RealEstateTycoonTabbarController.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/7.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "RealEstateTycoonTabbarController.h"
#import "ZJNTabbar.h"
#import "DemandViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"
#import "PremisesViewController.h"
#import "ReleaseViewController.h"
#import "RealEstateTycoonViewController.h"
@interface RealEstateTycoonTabbarController ()<ZJNTabbarDelegate>

@end

@implementation RealEstateTycoonTabbarController
#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = LightGray;
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = MainColor;
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllChildVc];
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    ZJNTabbar *tabbar = [[ZJNTabbar alloc] init];
    tabbar.myDelegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
    // Do any additional setup after loading the view.
}
#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc
{
    //楼盘
    PremisesViewController *premisesVC = [[PremisesViewController alloc] init];
    [self addChildViewController:premisesVC andTitle:@"楼盘" andImageName:@"lp_h" andSelectedImage:@"lp_l"];
    
    //供求
    DemandViewController *demandVC = [[DemandViewController alloc] init];
    [self addChildViewController:demandVC andTitle:@"需求" andImageName:@"xq_h" andSelectedImage:@"xq_l"];
    ReleaseViewController *releaseVC = [[ReleaseViewController alloc]init];
    [self addChildViewController:releaseVC andTitle:@"" andImageName:@"" andSelectedImage:@""];
    //消息
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    [self addChildViewController:messageVC andTitle:@"消息" andImageName:@"xx_h" andSelectedImage:@"xx_l"];
    
    //我的
    MineViewController *mineVC = [[MineViewController alloc] init];
    [self addChildViewController:mineVC andTitle:@"我的" andImageName:@"wd_h" andSelectedImage:@"wd_l"];
    
}
#pragma mark - 初始化设置tabBar上面单个按钮的方法

//添加自控制器，设置标题，图片，和被选图片
-(void)addChildViewController:(UIViewController *)childViewController andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectedImage:(NSString *)selectedImageName{
    
    childViewController.view.backgroundColor = [self randomColor];
    childViewController.tabBarItem.title = title;
    
    childViewController.tabBarItem.image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childViewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if ([childViewController isKindOfClass:[ReleaseViewController class]]) {
        [self addChildViewController:childViewController];
    }else{
        RealEstateTycoonViewController *nav = [[RealEstateTycoonViewController alloc]initWithRootViewController:childViewController];
        
        [self addChildViewController:nav];
    }
    
}

#pragma mark - ZJNTabBarDelegate
-(void)tabbarPlusButtonClick:(ZJNTabbar *)tabbar{
//    ReleaseViewController *plusVC = [[ReleaseViewController alloc] init];
//    plusVC.view.backgroundColor = [UIColor redColor];
//    
//    [self presentViewController:plusVC animated:YES completion:nil];
    self.selectedIndex = 2;
}

- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
