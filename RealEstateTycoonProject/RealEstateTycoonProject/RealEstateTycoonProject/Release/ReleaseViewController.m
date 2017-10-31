//
//  ReleaseViewController.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/7.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "ReleaseViewController.h"
#import "ReleaseRequirementsViewController.h"
#import "RealEstateTycoonViewController.h"
#import "ReleasePremisesViewController.h"
@interface ReleaseViewController ()

@end

@implementation ReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatView];
}
-(void)creatView{
    
    UIImageView *bgImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bgImageV.image = [UIImage imageNamed:@"fb_bg"];
    [self.view addSubview:bgImageV];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 42, ScreenWidth-16, 20)];
    titleLabel.text = @"发布";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = DarkGray;
    [self.view addSubview:titleLabel];
    
    UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    topButton.frame = CGRectMake(10, self.view.centerY-90, ScreenWidth-20, 40);
    [Utile makeCorner:3 view:topButton];
    [topButton setTitle:@"发布楼盘" forState:UIControlStateNormal];
    [topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [topButton addTarget:self action:@selector(topButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [topButton setBackgroundColor:MainColor];
    [self.view addSubview:topButton];
    
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomButton.frame = CGRectMake(10, CGRectGetMaxY(topButton.frame)+40, ScreenWidth-20, 40);
    [Utile makeCorner:3 view:bottomButton];
    [bottomButton setTitle:@"发布需求" forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(bottomButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomButton setBackgroundColor:MainColor];
    [self.view addSubview:bottomButton];
    
    
}
//发布楼盘
-(void)topButtonClick{
    ReleasePremisesViewController *view = [[ReleasePremisesViewController alloc]init];
    view.hidesBottomBarWhenPushed = YES;
    RealEstateTycoonViewController *nav = [[RealEstateTycoonViewController alloc]initWithRootViewController:view];
    [self presentViewController:nav animated:NO completion:^{
        
    }];
}
//发布需求
-(void)bottomButtonClick{
    ReleaseRequirementsViewController *view = [[ReleaseRequirementsViewController alloc]init];
    view.hidesBottomBarWhenPushed = YES;
    RealEstateTycoonViewController *nav = [[RealEstateTycoonViewController alloc]initWithRootViewController:view];
    [self presentViewController:nav animated:NO completion:^{
        
    }];
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
