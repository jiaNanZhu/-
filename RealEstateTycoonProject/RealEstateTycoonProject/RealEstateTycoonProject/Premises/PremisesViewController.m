//
//  PremisesViewController.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/7.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "PremisesViewController.h"
#import "PremisesListTableViewCell.h"
#import "ZJNPremisesTableHeaderView.h"
#import "AllOrTypePremisesView.h"
#import "SearchPremisesViewController.h"
#import "AreaPremisesView.h"
#import "PremisesDetailViewController.h"
#import "PayView.h"
#import "PremisesListModel.h"
@interface PremisesViewController ()<UITableViewDelegate,UITableViewDataSource,ZJNPremisesTableHeaderDelegate,UISearchBarDelegate,PayViewDelegate,AreaPremisesViewDelegate>
{
    UITableView *_tableView;
    AllOrTypePremisesView *allOrTypeV;
    AreaPremisesView *areaPremisesV;
    ZJNPremisesTableHeaderView *headerView;
    UIView *coverView;
    UISearchBar *_searchBar;
    UIBarButtonItem *searchItem;
    UIBarButtonItem *rightItem;
    PayView         *payView;
    NSMutableArray  *listArray;
    NSInteger page;
    NSInteger buttontag;
    NSString *provinceStr;
    NSString *cityStr;
    NSString *areaStr;
    NSString *typeStr;
    NSString *daysStr;
    NSIndexPath *signIndexPath;//记录当前被选中的单元格
}
@end

@implementation PremisesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"房源列表"];
    listArray = [NSMutableArray array];
    searchItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ss"] style:UIBarButtonItemStylePlain target:self action:@selector(searchButtonClick:)];
    rightItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searchTitleButtonClick)];
    self.navigationItem.rightBarButtonItem = searchItem;
    [self creatView];
    [self initString];
    [self getPremisesListFromService];
    // Do any additional setup after loading the view.
}
-(void)initString{
    page = 1;
    provinceStr = @"";
    cityStr = @"";
    areaStr = @"";
    typeStr = @"";
    daysStr = @"";
}
-(void)creatView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49) style:UITableViewStylePlain];
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        
        [self getPremisesListFromService];
    }];
    mj_header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_header = mj_header;
    
    MJRefreshBackNormalFooter *mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page += 1;

        [self getPremisesListFromService];
    }];
    _tableView.mj_footer = mj_footer;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.bounces = NO;
    _tableView.tableFooterView = [[UIView alloc]init];
    
    //创建一个view 遮挡tabbar
    coverView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
    coverView.backgroundColor = LightGray;
    coverView.alpha = 0.5;
    
    UIView *tabelHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, (29/64.0)*ScreenWidth+45)];
    tabelHeaderView.backgroundColor = LightGray;
    _tableView.tableHeaderView = tabelHeaderView;
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake((29/64.0)*ScreenWidth+45, 0, 0, 0);
    [_tableView registerNib:[UINib nibWithNibName:@"PremisesListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellid"];
    
    [self.view addSubview:_tableView];
    
    headerView = [[ZJNPremisesTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, (29/64.0)*ScreenWidth+45)];
    headerView.delegate = self;
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.tableView = _tableView;
    [self.view addSubview:headerView];
    
    allOrTypeV = [[AllOrTypePremisesView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame), ScreenWidth, ScreenHeight-49-CGRectGetMaxY(headerView.frame))];
    __weak ZJNPremisesTableHeaderView *headerV = headerView;
    __weak UIView *cover = coverView;
    __weak AllOrTypePremisesView *allOrType = allOrTypeV;
    allOrTypeV.allOrTypePremisesBlock = ^(NSString *str) {
        if (buttontag == 1) {
            daysStr = str;
        }else if (buttontag == 3){
            typeStr = str;
        }
        [cover removeFromSuperview];
        allOrType.hidden = YES;
        headerV.signButton.selected = NO;
    };
    [self.view addSubview:allOrTypeV];
    allOrTypeV.hidden = YES;
    
    areaPremisesV = [[AreaPremisesView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame), ScreenWidth, ScreenHeight-49-CGRectGetMaxY(headerView.frame))];
    areaPremisesV.delegate = self;
    [self.view addSubview:areaPremisesV];
    areaPremisesV.hidden = YES;
    
}
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PremisesListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = listArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    signIndexPath = indexPath;
    //创建支付view
    payView = [[PayView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-70, 201)];
    payView.delegate = self;
    payView.centerX = self.view.centerX;
    payView.centerY = self.view.centerY-50;
    [self.view addSubview:payView];
    [self.view bringSubviewToFront:payView];
}
#pragma mark--搜索按钮点击实现方法
-(void)searchButtonClick:(id)sender{
    _searchBar = [[UISearchBar alloc]init];
    _searchBar.delegate = self;
//    _searchBar.showsCancelButton = YES;
    
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTitle:@"搜索"];

    [_searchBar setPlaceholder:@"搜索关键字"];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.titleView = _searchBar;
    
}
-(void)zjnPremisesTableHeaderFrameChanged{
    allOrTypeV.frame = CGRectMake(0, CGRectGetMaxY(headerView.frame), ScreenWidth, ScreenHeight-49-CGRectGetMaxY(headerView.frame));
    allOrTypeV.tableView.frame = CGRectMake(0, 0, ScreenWidth, allOrTypeV.height);
    
    areaPremisesV.frame = CGRectMake(0, CGRectGetMaxY(headerView.frame), ScreenWidth, ScreenHeight-49-CGRectGetMaxY(headerView.frame));
    [areaPremisesV updateFrameWithFrame:areaPremisesV.frame];
}
#pragma mark--三个分类按钮点击实现方法
-(void)zjnPremisesTableHeaderButtonClickWithTag:(NSInteger)tag selected:(BOOL)isSelected{
    if (tag == 1) {
        buttontag = 1;
        if (isSelected) {
            [[UIApplication sharedApplication].keyWindow addSubview:coverView];
            areaPremisesV.hidden = YES;
            allOrTypeV.hidden = NO;
            allOrTypeV.titleArr = @[@"全部",@"最近三天",@"最近一周",@"最近一个月"];
            [allOrTypeV.tableView reloadData];
        }else{
            [coverView removeFromSuperview];
            allOrTypeV.hidden = YES;
        }
    }else if (tag == 2){
        if (isSelected) {
            [[UIApplication sharedApplication].keyWindow addSubview:coverView];
            allOrTypeV.hidden = YES;
            areaPremisesV.hidden = NO;
        }else{
            [coverView removeFromSuperview];
            areaPremisesV.hidden = YES;
        }
    }else if (tag == 3){
        buttontag = 3;
        if (isSelected) {
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
    SearchPremisesViewController *view = [[SearchPremisesViewController alloc]init];
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:NO];
}
//点击导航栏上的搜索按钮实现方法
-(void)searchTitleButtonClick{
    [_searchBar resignFirstResponder];
    NSLog(@"跳转到搜索结果页面");
    SearchPremisesViewController *view = [[SearchPremisesViewController alloc]init];
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:NO];
}
#pragma mark--PayViewDelegate
-(void)payViewSureButtonClickWithPassword:(NSString *)password{
    //密码输入正确后 进入到房源详情页面
    if ([password isEqualToString:@"123456"]) {
        NSLog(@"密码输入正确");
        PremisesDetailViewController *view = [[PremisesDetailViewController alloc]init];
        PremisesListModel *model = listArray[signIndexPath.row];
        view.lid = model.lid;
        [self presentViewController:view animated:NO completion:^{
            
        }];
    }else{
        NSLog(@"请输入正确的密码");
    }
}
/********************************************************************/
//数据请求
#pragma mark--AreaPremisesViewDelegate
-(void)areaPremisesViewSelectedAddress:(NSDictionary *)address{
    provinceStr = address[@"provice"];
    cityStr = address[@"city"];
    areaStr = address[@"district"];
    [coverView removeFromSuperview];
    headerView.signButton.selected = NO;
    areaPremisesV.hidden = YES;
}
//楼盘列表
-(void)getPremisesListFromService{
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)page];
    NSArray *keysArray = @[@"page",@"province",@"city",@"area",@"type"];
    NSArray *valuesArray = @[pageStr,provinceStr,cityStr,areaStr,typeStr];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:valuesArray forKeys:keysArray];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",RequestUrl,Project_list];
    [ZJNRequestManager postWithUrlString:urlStr parameters:dic success:^(id data) {
        NSLog(@"data%@",data);
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        if (page == 1) {
            [listArray removeAllObjects];
        }
        if ([[data[@"code"] stringValue] isEqualToString:@"200"]) {
            NSArray *array = data[@"info"];
            if (array.count == 0) {
                page>1?(page-=1):(page=1);
            }else{
                for (NSDictionary *dic in array) {
                    PremisesListModel *model = [PremisesListModel yy_modelWithDictionary:dic];
                    [listArray addObject:model];
                }
            }
        }else{
            page>1?(page-=1):(page=1);
            [self showHint:data[@"mes"]];
        }
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        [self showHint:@"请求服务器失败"];
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
