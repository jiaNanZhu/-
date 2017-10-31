//
//  ReleaseRequirementsViewController.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/19.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "ReleaseRequirementsViewController.h"
#import "PriceRangeTableViewCell.h"
#import "ReleaseSelectTableViewCell.h"
#import "ReleaseAddressTableViewCell.h"
#import "AreaPremisesView.h"
@interface ReleaseRequirementsViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,ReleaseAddressDelegate,AreaPremisesViewDelegate>
{
    UITableView *_tableView;
    UILabel     *placeHolderLabel;
    NSString *typeStr;//房源类型
    NSString *souceStr;//房源
    NSString *addressStr;//省市区地址
    NSString *proviceStr;//楼盘所在省
    NSString *cityStr;//楼盘所在市
    NSString *districtStr;//楼盘所在区
    NSString *detailAddressStr;//详细地址
    NSString *minFirstMoney;//最低首付金额
    NSString *maxFirstMoney;//最高首付金额
    NSString *minMoney;//最低预计总价
    NSString *maxMoney;//最高预计总价
    NSString *remarkStr;//备注
    NSArray  *typeArr;//房源类型数组
    NSArray  *souceArr;//房源数组
    AreaPremisesView *areaPremisesV;//省市区选择页面
    
}
@end

@implementation ReleaseRequirementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布需求";
    typeArr = @[@"住宅",@"别墅",@"酒店",@"办公",@"商铺",@"其它"];
    souceArr = @[@"新房",@"二手房",@"不限"];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backanniu"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self creatView];
    // Do any additional setup after loading the view from its nib.
}
-(void)creatView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableView.tableFooterView = [self tableViewFooterView];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    areaPremisesV = [[AreaPremisesView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    areaPremisesV.delegate = self;
    [self.view addSubview:areaPremisesV];
    areaPremisesV.hidden = YES;
}
-(UIView *)tableViewFooterView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 310)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    topLineView.backgroundColor = SeparateLineColor;
    [view addSubview:topLineView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 20, ScreenWidth-16, 20)];
    titleLabel.text = @"备注";
    titleLabel.textColor = DarkGray;
    titleLabel.font = TextFont(15);
    [view addSubview:titleLabel];
    
    UITextView *inputTextView = [[UITextView alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(titleLabel.frame)+4, ScreenWidth-16, 160)];
    inputTextView.delegate = self;
    inputTextView.font = [UIFont systemFontOfSize:14];
    inputTextView.textColor = LightGray;
    [view addSubview:inputTextView];
    
    placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(titleLabel.frame)+6, 100, 20)];
    placeHolderLabel.text = @"请输入备注...";
    placeHolderLabel.textColor = LightGray;
    placeHolderLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:placeHolderLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(inputTextView.frame)+4, ScreenWidth, 0.5)];
    lineView.backgroundColor = SeparateLineColor;
    [view addSubview:lineView];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(10, CGRectGetMaxY(lineView.frame)+50, ScreenWidth-20, 40);
    [submitButton setBackgroundColor:MainColor];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [Utile makeCorner:3 view:submitButton];
    [view addSubview:submitButton];
    
    return view;
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 80;
    }
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *cellid = @"cellid";
        ReleaseAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ReleaseAddressTableViewCell" owner:self options:nil]lastObject];
        }
        cell.delegate = self;
        cell.detailAddressBlock = ^(NSString *detailAddress) {
            detailAddressStr = detailAddress;
        };
        if (addressStr.length >0) {
            cell.addressLabel.text = addressStr;
        }
        cell.detailAddressTextField.text = detailAddressStr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1 || indexPath.row == 2){
        static NSString *cellid = @"cellID";
        ReleaseSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ReleaseSelectTableViewCell" owner:self options:nil]lastObject];
        }
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"类型";
            cell.typeLabel.text = @"选择房源类型";
            if (typeStr.length>0) {
                cell.typeLabel.text = typeStr;
            }
            
        }else{
            cell.titleLabel.text = @"房源";
            cell.typeLabel.text = @"选择房源";
            if (souceStr.length>0) {
                cell.typeLabel.text = souceStr;
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *cellid = @"cellId";
        PriceRangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PriceRangeTableViewCell" owner:self options:nil]lastObject];
        }
        if (indexPath.row == 3) {
            cell.titleLabel.text = @"首付";
            cell.minTextField.placeholder = @"首付金额范围";
            cell.maxTextField.placeholder = @"首付金额范围";
            cell.minPriceBlock = ^(NSString *minPrice) {
                minFirstMoney = minPrice;
            };
            cell.maxPriceBlock = ^(NSString *maxPrice) {
                maxFirstMoney = maxPrice;
            };
            cell.minTextField.text = minFirstMoney;
            cell.maxTextField.text = maxFirstMoney;
        }else{
            cell.titleLabel.text = @"预计总价";
            cell.minTextField.placeholder = @"预计总价范围";
            cell.maxTextField.placeholder = @"预计总价范围";
            cell.minPriceBlock = ^(NSString *minPrice) {
                minMoney = minPrice;
            };
            cell.maxPriceBlock = ^(NSString *maxPrice) {
                maxMoney = maxPrice;
            };
            cell.minTextField.text = minMoney;
            cell.maxTextField.text = maxMoney;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        [self showAlertWithTitle:@"房源类型" stateArray:typeArr type:@"type"];
    }else if (indexPath.row == 2){
        [self showAlertWithTitle:@"房源" stateArray:souceArr type:@"souce"];
    }
}
//返回按钮点击实现方法
-(void)backButtonClick{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
#pragma mark--UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    placeHolderLabel.hidden = YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length>0) {
        placeHolderLabel.hidden = YES;
    }else{
        placeHolderLabel.hidden = NO;
    }
    remarkStr = textView.text;
}
#pragma mark--ReleaseAddressDelegate
-(void)selectAddress{
    areaPremisesV.hidden = NO;
}
#pragma mark--AreaPremisesViewDelegate
-(void)areaPremisesViewSelectedAddress:(NSDictionary *)address{
    areaPremisesV.hidden = YES;
    NSLog(@"%@",address);
    proviceStr = address[@"provice"];
    cityStr = address[@"city"];
    districtStr = address[@"district"];
    ReleaseAddressTableViewCell *cell = (ReleaseAddressTableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    addressStr = [NSString stringWithFormat:@"%@%@%@",proviceStr,cityStr,districtStr];
    cell.addressLabel.text = addressStr;
    
}
//展示警示框
-(void)showAlertWithTitle:(NSString *)title stateArray:(NSArray *)stateArray type:(NSString *)type{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i <stateArray.count; i ++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:stateArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if ([type isEqualToString:@"type"]) {
                ReleaseSelectTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                cell.typeLabel.text = stateArray[i];
                typeStr = stateArray[i];
            }else if ([type isEqualToString:@"souce"]){
                ReleaseSelectTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
                cell.typeLabel.text = stateArray[i];
                souceStr = stateArray[i];
            }
            
        }];
        [action setValue:MainColor forKey:@"_titleTextColor"];
        [alert addAction:action];
    }
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [action setValue:MiddleGray forKey:@"_titleTextColor"];
    [alert addAction:action];
    if (stateArray.count >5) {
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:alert.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:350];
        [alert.view addConstraint:height];
    }
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}
//提交按钮点击实现方法
-(void)submitButtonClick:(UIButton *)button{
    NSArray *keysArray = @[@"token",@"province",@"city",@"area",@"type",@"hose_resource",@"pay_low",@"pay_height",@"total_low",@"total_height",@"remark"];
    NSArray *valueArray = @[Token,proviceStr,cityStr,districtStr,typeStr,souceStr,minFirstMoney,maxFirstMoney,minMoney,maxMoney,remarkStr];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:valueArray forKeys:keysArray];
    NSLog(@"%@",dic);
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",RequestUrl,AddDemand];
    [ZJNRequestManager postWithUrlString:urlStr parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        if ([[data[@"code"] stringValue] isEqualToString:@"200"]) {
            [self dismissViewControllerAnimated:NO completion:^{
                
            }];
        }
        [self showHint:data[@"mes"]];
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
