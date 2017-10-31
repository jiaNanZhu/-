//
//  AreaPremisesView.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/7.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "AreaPremisesView.h"
#import "MiddleLabelTableViewCell.h"
@interface AreaPremisesView()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataSourceArray;
    UITableView *leftTableView;
    UITableView *middleTableView;
    UITableView *rightTableView;
    NSArray     *middleTitleArray;
    NSArray     *rightTitleArray;
    NSString    *proviceStr;
    NSString    *cityStr;
    NSString    *districtStr;
    BOOL        firstCreat;
}
@end
@implementation AreaPremisesView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = SeparateLineColor;
        dataSourceArray = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
        middleTitleArray = dataSourceArray[0][@"cities"];
        rightTitleArray = middleTitleArray[0][@"areas"];
        firstCreat = YES;
        [self creatView];
    }
    return self;
}
-(void)updateFrameWithFrame:(CGRect)frame{
    leftTableView.frame = CGRectMake(0, 0, ScreenWidth/3.0-0.5, self.height);
    middleTableView.frame = CGRectMake(ScreenWidth/3.0, 0, ScreenWidth/3.0-0.5, self.height);
    rightTableView.frame = CGRectMake(2*(ScreenWidth/3.0), 0, ScreenWidth/3.0, self.height);
}
-(void)creatView{
    leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/3.0-0.5, self.height) style:UITableViewStylePlain];
    middleTableView = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth/3.0, 0, ScreenWidth/3.0-0.5, self.height) style:UITableViewStylePlain];
    rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(2*(ScreenWidth/3.0), 0, ScreenWidth/3.0, self.height) style:UITableViewStylePlain];
    
    leftTableView.showsVerticalScrollIndicator = NO;
    middleTableView.showsVerticalScrollIndicator = NO;
    rightTableView.showsVerticalScrollIndicator = NO;
    
    leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    middleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    leftTableView.delegate = self;
    middleTableView.delegate = self;
    rightTableView.delegate = self;
    
    leftTableView.dataSource = self;
    middleTableView.dataSource = self;
    rightTableView.dataSource = self;
    
    [self addSubview:leftTableView];
    [self addSubview:middleTableView];
    [self addSubview:rightTableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == leftTableView) {
        return dataSourceArray.count;
    }else if (tableView == middleTableView){
        return middleTitleArray.count;
    }else{
        
        return rightTitleArray.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    MiddleLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"MiddleLabelTableViewCell" owner:self options:nil].lastObject;
    }
    
    if (tableView == leftTableView) {
        if (indexPath.row == 0) {
            if (firstCreat) {
                [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                NSDictionary *dic = dataSourceArray[indexPath.row];
                proviceStr = dic[@"state"];
                firstCreat = NO;
            }
        }
        NSDictionary *dic = dataSourceArray[indexPath.row];
        cell.titleLabel.text = dic[@"state"];
    }else if(tableView == middleTableView){
        NSDictionary *dic = middleTitleArray[indexPath.row];
        cell.titleLabel.text = dic[@"city"];
    }else{
        
        cell.titleLabel.text = rightTitleArray[indexPath.row];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == leftTableView) {
        NSDictionary *dic = dataSourceArray[indexPath.row];
        proviceStr = dic[@"state"];
        cityStr = @"";
        middleTitleArray = dataSourceArray[indexPath.row][@"cities"];
        rightTitleArray = middleTitleArray[0][@"areas"];
        [middleTableView reloadData];
        [rightTableView reloadData];
    }else if (tableView == middleTableView){
        NSDictionary *dic = middleTitleArray[indexPath.row];
        cityStr = dic[@"city"];
        districtStr = @"";
        rightTitleArray = middleTitleArray[indexPath.row][@"areas"];
        if (rightTitleArray.count == 0) {
            NSLog(@"调用代理方法");
            if (self.delegate && [self.delegate respondsToSelector:@selector(areaPremisesViewSelectedAddress:)]) {
                [self.delegate areaPremisesViewSelectedAddress:@{@"provice":proviceStr,@"city":cityStr,@"district":@""}];
                
            }
        }else{
            [rightTableView reloadData];
        }
    }else{
        districtStr = rightTitleArray[indexPath.row];
        NSLog(@"省市区选择完毕");
        if (self.delegate && [self.delegate respondsToSelector:@selector(areaPremisesViewSelectedAddress:)]) {
            [self.delegate areaPremisesViewSelectedAddress:@{@"provice":proviceStr,@"city":cityStr,@"district":districtStr}];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
