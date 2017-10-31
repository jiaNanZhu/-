//
//  BasicViewController.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/7.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "BasicViewController.h"
#import "PayView.h"
@interface BasicViewController ()
{
    UIView *grayView;
}
@end

@implementation BasicViewController
- (id)init{
    self = [super init];
    if (self) {
//        self.hidesBottomBarWhenPushed = YES;
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center  addObserver:self selector:@selector(keyboardWillShow:)  name:UIKeyboardWillShowNotification  object:nil];
        [center addObserver:self selector:@selector(keyboardDidHide)  name:UIKeyboardWillHideNotification object:nil];
        grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        grayView.backgroundColor = RGBColor(0, 0, 0, 0.5);
        [Utile addClickEvent:self action:@selector(hideKeyboard) owner:grayView];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //键盘正在展示
    
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyboardHeight = keyboardRect.size.height;
    
    [self.view addSubview:grayView];
    [self.view bringSubviewToFront:grayView];
    
    NSArray *array = self.view.subviews;
    for (UIView *payView in array) {
        if ([payView isKindOfClass:[PayView class]]) {
            [self.view bringSubviewToFront:payView];
            break;
        }
    }

}

- (void)keyboardDidHide
{
    //键盘消失了
    [grayView removeFromSuperview];
}
//
-(void)hideKeyboard{
    
    [self.view endEditing:YES];
    NSArray *navArray = self.navigationController.navigationBar.subviews;
    for (UIView *searchBar in navArray) {
        if ([searchBar isKindOfClass:[UISearchBar class]]) {
            [searchBar resignFirstResponder];
            break;
        }
    }
    NSArray *array = self.view.subviews;
    for (UIView *payView in array) {
        if ([payView isKindOfClass:[PayView class]]) {
            [payView removeFromSuperview];
            break;
        }
    }
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
