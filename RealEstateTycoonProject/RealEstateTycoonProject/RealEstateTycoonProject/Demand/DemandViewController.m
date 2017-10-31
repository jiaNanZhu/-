//
//  DemandViewController.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/7.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "DemandViewController.h"
#import "DemandTableViewCell.h"
#import "AllOrTypePremisesView.h"
#import "AreaPremisesView.h"
#import "DemandDetailViewController.h"
@interface DemandViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,AreaPremisesViewDelegate>
{
    UITableView *_tableView;
    AllOrTypePremisesView *allOrTypeV;
    AreaPremisesView *areaPremisesV;
    UIView *coverView;
    UIButton *signButton;
    UISearchBar *_searchBar;
    
    NSString *pushTimeStr;//发布时间
    NSString *proviceStr;//省
    NSString *cityStr;//市
    NSString *areaStr;//区
    NSString *priceStr;//价格区间
    NSString *typeStr;//类型
    NSString *searchStr;//搜索框文字
}
@end

@implementation DemandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searchTitleButtonClick)];
    _searchBar = [[UISearchBar alloc]init];
    _searchBar.delegate = self;
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTitle:@"搜索"];
    [_searchBar setPlaceholder:@"搜索关键字"];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.titleView = _searchBar;
    [self setTitle:@"需求"];
    [self getDateFromService];
    [self creatView];
    // Do any additional setup after loading the view.
}

-(void)creatView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49) style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    allOrTypeV = [[AllOrTypePremisesView alloc]initWithFrame:CGRectMake(0, 109, ScreenWidth, ScreenHeight-158)];
    allOrTypeV.allOrTypePremisesBlock = ^(NSString *str) {
        if (signButton.tag == 1) {
            pushTimeStr = str;
        }else if (signButton.tag == 3){
            priceStr = str;
        }else if (signButton.tag == 4){
            typeStr = str;
        }
    };
    [self.view addSubview:allOrTypeV];
    allOrTypeV.hidden = YES;
    
    areaPremisesV = [[AreaPremisesView alloc]initWithFrame:CGRectMake(0, 109, ScreenWidth, ScreenHeight-158)];
    areaPremisesV.delegate = self;
    [self.view addSubview:areaPremisesV];
    areaPremisesV.hidden = YES;
    
    //创建一个view 遮挡tabbar
    coverView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
    coverView.backgroundColor = LightGray;
    coverView.alpha = 0.5;
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    NSArray *titleArray = @[@"发布时间",@"区域",@"价格",@"类型"];
    for (int i = 0; i <4; i ++) {
        CGFloat width = ScreenWidth/4.0f;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i *width, 0, width, 45);
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"sjx"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"sjx_l"] forState:UIControlStateSelected];
        [button setTitleColor:LightGray forState:UIControlStateNormal];
        [button setTitleColor:MainColor forState:UIControlStateSelected];
        CGFloat imageViewWidth = 10;
        CGFloat labelWidth = 30;
        
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:LightGray forState:UIControlStateNormal];
        if (i == 0) {
            [button setImageEdgeInsets:UIEdgeInsetsMake(0,0 + 60,0,0 - 60)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0,0 - imageViewWidth,0, 0 + imageViewWidth)];
        }else{
            [button setImageEdgeInsets:UIEdgeInsetsMake(0,0 + labelWidth,0,0 - labelWidth)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0,0 - imageViewWidth,0, 0 + imageViewWidth)];
        }
        
        button.tag = i+1;
        
        [headerView addSubview:button];
    }
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 44.5, ScreenWidth, 0.5)];
    lineView.backgroundColor = SeparateLineColor;
    [headerView addSubview:lineView];
    return headerView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    DemandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DemandTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DemandDetailViewController *view = [[DemandDetailViewController alloc]init];
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:NO];
    
}
//分类按钮点击实现方法
-(void)buttonClick:(UIButton *)button{
    if (button.selected && signButton==button) {
        signButton.selected = NO;
    }else if (signButton == button && !button.selected){
        signButton.selected = YES;
    }else{
        signButton.selected = NO;
        button.selected = YES;
        signButton = button;
    }
    
    if (signButton.tag == 1) {
        if (signButton.selected) {
            [[UIApplication sharedApplication].keyWindow addSubview:coverView];
            areaPremisesV.hidden = YES;
            allOrTypeV.hidden = NO;
            allOrTypeV.titleArr = @[@"全部",@"最近三天",@"最近一周",@"最近一个月"];
            [allOrTypeV.tableView reloadData];
        }else{
            [coverView removeFromSuperview];
            allOrTypeV.hidden = YES;
        }
    }else if (signButton.tag == 2){
        if (signButton.selected) {
            [[UIApplication sharedApplication].keyWindow addSubview:coverView];
            allOrTypeV.hidden = YES;
            areaPremisesV.hidden = NO;
        }else{
            [coverView removeFromSuperview];
            areaPremisesV.hidden = YES;
        }
    }else if (signButton.tag == 3){
        if (signButton.selected) {
            [[UIApplication sharedApplication].keyWindow addSubview:coverView];
            areaPremisesV.hidden = YES;
            allOrTypeV.hidden = NO;
            allOrTypeV.titleArr = @[@"全部",@"100万以下",@"100-150万",@"500-800万",@"1000万以上"];
            [allOrTypeV.tableView reloadData];
        }else{
            [coverView removeFromSuperview];
            allOrTypeV.hidden = YES;
        }
    }else if (signButton.tag == 4){
        if (signButton.selected) {
            [[UIApplication sharedApplication].keyWindow addSubview:coverView];
            areaPremisesV.hidden = YES;
            allOrTypeV.hidden = NO;
            allOrTypeV.titleArr = @[@"不限",@"住宅",@"办公",@"别墅"];
            [allOrTypeV.tableView reloadData];
        }else{
            [coverView removeFromSuperview];
            allOrTypeV.hidden = YES;
        }
    }
}
#pragma mark--UISearchBarDelegate
//点击键盘搜索按钮实现方法
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSLog(@"跳转到搜索结果页面");

}
//点击导航栏上的搜索按钮实现方法
-(void)searchTitleButtonClick{
    [_searchBar resignFirstResponder];
    NSLog(@"跳转到搜索结果页面");

}
#pragma mark--AreaPremisesViewDelegate
-(void)areaPremisesViewSelectedAddress:(NSDictionary *)address{
    cityStr = address[@"city"];
    areaStr = address[@"district"];
    proviceStr = address[@"provice"];
}
#pragma mark--数据请求
-(void)getDateFromService{
//    NSArray *keysArray = @[@"",@"",@"",@"",@""];
//    NSArray *valuesArray = @[];
//    NSDictionary *dic = [NSDictionary dictionaryWithObjects:valuesArray forKeys:keysArray];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",RequestUrl,DemandList];
    [ZJNRequestManager postWithUrlString:urlStr parameters:nil success:^(id data) {
        NSLog(@"%@",data);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
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
