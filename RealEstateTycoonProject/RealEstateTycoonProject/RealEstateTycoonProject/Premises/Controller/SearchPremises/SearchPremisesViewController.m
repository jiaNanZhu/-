//
//  SearchPremisesViewController.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/10.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "SearchPremisesViewController.h"
#import "PremisesListTableViewCell.h"
@interface SearchPremisesViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar *_searchBar;
    UITableView *_tableView;
}
@end

@implementation SearchPremisesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    _searchBar = [[UISearchBar alloc]init];
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = NO;
    [_searchBar setPlaceholder:@"搜索关键字"];
    self.navigationItem.titleView = _searchBar;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(searchButtonClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self creatView];
    // Do any additional setup after loading the view.
}
-(void)creatView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    _tableView.tableFooterView = [[UIView alloc]init];
    [_tableView registerNib:[UINib nibWithNibName:@"PremisesListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellid"];

    [self.view addSubview:_tableView];
}
#pragma mark--UISearchBarDelegate
//点击键盘搜索按钮实现方法
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PremisesListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    
    cell.coverImageView.image = [UIImage imageNamed:@"xq_bg"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//点击取消按钮实现方法
-(void)searchButtonClick{
    [self.navigationController popViewControllerAnimated:NO];
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
