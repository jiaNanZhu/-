//
//  PremisesDetailViewController.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/11.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "PremisesDetailViewController.h"
#import "PremisesDetailHeaderView.h"
#import "HouseTypeTableViewCell.h"
#import "PremisesInfoTableViewCell.h"
#import "PremisesProjectInfoTableViewCell.h"
#import "LeaveWordsTextViewTableViewCell.h"
#import "PremisesDetailModel.h"
@interface PremisesDetailViewController ()<UITableViewDelegate,UITableViewDataSource,PremisesDetailMapDelegate>
{
    UITableView *_tableView;
    BOOL showSecondSection;
    BOOL showThirdSection;
    NSString *ruleString;//报备规则
    NSArray *infoArray;//楼盘资料
    
    PremisesDetailModel *detailModel;
}
@end

@implementation PremisesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    showSecondSection = NO;
    showThirdSection = NO;
    
    
    [self getDetailInfoFromService];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)creatView{
    ruleString = detailModel.report;

    infoArray = [detailModel.info componentsSeparatedByString:@"\n"];
    NSString *str = [NSString stringWithFormat:@"楼盘地址:%@%@%@%@",detailModel.province,detailModel.city,detailModel.area,detailModel.location];
    //先计算房源详情里边房源地址label的高度
    CGFloat addressHeight = [str boundingRectWithSize:CGSizeMake(ScreenWidth-54, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:TextFont(15),NSFontAttributeName, nil] context:nil].size.height;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    PremisesDetailHeaderView *headerV = [[PremisesDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, (29/64.0)*ScreenWidth+200+addressHeight) premisesDetail:detailModel];
    headerV.delegate = self;
    _tableView.tableHeaderView = headerV;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 24, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"backanniu"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        if (indexPath.section == 2 && indexPath.row>0 && indexPath.row<4) {
            [cell setLayoutMargins:UIEdgeInsetsMake(0, ScreenWidth, 0, 0)];
        }else{
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        if (indexPath.section == 2 && indexPath.row>0 && indexPath.row<4) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, ScreenWidth, 0, 0)];
        }else{
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 0;
    }
    return 8;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        if (showSecondSection) {
            return 5;
        }else{
            return 1;
        }
    }else if (section == 3){
        if (showThirdSection) {
            return 2;
        }else{
            return 1;
        }
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 52+(ScreenWidth-16)*0.35;
    }else if (indexPath.section == 1){
        return 104;
    }else if (indexPath.section == 4){
        return 52+(ScreenWidth-16)*0.4;
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            return 40;
        }else{
            return [self boundingRectWithFont:14 String:infoArray[indexPath.row-1] contentSize:CGSizeMake(ScreenWidth-16, MAXFLOAT)firstLineHeadIndent:24]+4;
        }
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            return 40;
        }else{
            return [self boundingRectWithFont:14 String:ruleString contentSize:CGSizeMake(ScreenWidth-16, MAXFLOAT)firstLineHeadIndent:0]+16;
        }
    }else if (indexPath.section == 5){
        return 340;
    }
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellid = @"Cellid";
        HouseTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HouseTypeTableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.houseTypeArray = detailModel.houseArray;
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellid = @"CEllid";
        PremisesInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PremisesInfoTableViewCell" owner:self options:nil]lastObject];
        }
        cell.detailModel = detailModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2||indexPath.section == 3){
        if (indexPath.row == 0) {
            static NSString *cellid = @"CELlid";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-28, 10, 20, 20)];
                imageV.tag = 10;
                [cell.contentView addSubview:imageV];
                
                UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 10, ScreenWidth-44, 20)];
                titleLabel.font = [UIFont systemFontOfSize:16];
                titleLabel.textColor = SetColor(0x333333);
                titleLabel.tag = 11;
                [cell.contentView addSubview:titleLabel];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *imageV = (UIImageView *)[cell.contentView viewWithTag:10];
            
            UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:11];
            if (indexPath.section == 2) {
                titleLabel.text = @"项目资料";
                if (showSecondSection) {
                    imageV.image = [UIImage imageNamed:@"kzs"];
                }else{
                    imageV.image = [UIImage imageNamed:@"kz"];
                }
            }else if (indexPath.section == 3){
                titleLabel.text = @"报备规则";
                if (showThirdSection) {
                    imageV.image = [UIImage imageNamed:@"kzs"];
                }else{
                    imageV.image = [UIImage imageNamed:@"kz"];
                }
            }
            return cell;
        }else if(indexPath .section == 2){
            static NSString *cellid = @"CELLid";
            PremisesProjectInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"PremisesProjectInfoTableViewCell" owner:self options:nil]lastObject];
            }
            //设置label行间距
            NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil];
            NSMutableAttributedString*text = [[NSMutableAttributedString alloc]initWithString:infoArray[indexPath.row-1]];
            
            NSMutableParagraphStyle*style = [[NSMutableParagraphStyle alloc]init];
            style.headIndent = 0;
            style.lineSpacing = 4;
            style.firstLineHeadIndent = 24;
            style.paragraphSpacing = 8;
            //需要设置的范围
            NSString *string = infoArray[indexPath.row-1];
            NSRange range =NSMakeRange(0,string.length);
            [text addAttribute:NSParagraphStyleAttributeName value:style range:range];
            [text addAttributes:attrs range:range];
            cell.contentInfoLabel.attributedText = text;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *cellid = @"CELLId";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
                CGFloat height = [self boundingRectWithFont:14 String:ruleString contentSize:CGSizeMake(ScreenWidth-16, MAXFLOAT)firstLineHeadIndent:0]+16;
                UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, ScreenWidth-16, height-16)];
                contentLabel.font = [UIFont systemFontOfSize:14];
                contentLabel.textColor = LightGray;
                contentLabel.numberOfLines = 0;
                contentLabel.tag = 10;
                [cell.contentView addSubview:contentLabel];
            }
            UILabel *contentlabel = (UILabel *)[cell.contentView viewWithTag:10];
            //设置label行间距
            NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil];
            NSMutableAttributedString*text = [[NSMutableAttributedString alloc]initWithString:ruleString];
            
            NSMutableParagraphStyle*style = [[NSMutableParagraphStyle alloc]init];
            style.headIndent = 0;
            style.lineSpacing = 4;
            style.firstLineHeadIndent = 0;
            style.paragraphSpacing = 8;
            //需要设置的范围
            NSRange range =NSMakeRange(0,ruleString.length);
            [text addAttribute:NSParagraphStyleAttributeName value:style range:range];
            [text addAttributes:attrs range:range];
            contentlabel.attributedText = text;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }else if (indexPath.section == 4){
        static NSString *cellid = @"CELLID";
        HouseTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HouseTypeTableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contractArray = detailModel.htArray;
        return cell;
    }else if (indexPath.section == 5){
        static NSString *cellid = @"cellide";
        LeaveWordsTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LeaveWordsTextViewTableViewCell" owner:self options:nil]lastObject];
        }
        cell.infoModel = detailModel.userinfo;
        return cell;
    }
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            showSecondSection = !showSecondSection;
            [tableView reloadData];//还是感觉这种效果会好点儿
            
//            NSIndexSet *set = [NSIndexSet indexSetWithIndex:2];
//            [tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            showThirdSection = !showThirdSection;
            [tableView reloadData];
//            NSIndexSet *set = [NSIndexSet indexSetWithIndex:3];
//            [tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}
#pragma mark--PremisesDetailMapDelegate

//选择地图
-(void)premisesDetailSelectMapWithAlertController:(UIAlertController *)alertController{
    [self presentViewController:alertController animated:NO completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)boundingRectWithFont:(CGFloat)font String:(NSString *)string contentSize:(CGSize)size firstLineHeadIndent:(CGFloat)indent{
    //设置label行间距
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil];
    NSMutableAttributedString*text = [[NSMutableAttributedString alloc]initWithString:string];
    
    NSMutableParagraphStyle*style = [[NSMutableParagraphStyle alloc]init];
    style.headIndent = 0;
    style.lineSpacing = 4;
    style.firstLineHeadIndent = indent;
    style.paragraphSpacing = 8;
    //需要设置的范围
    NSRange range =NSMakeRange(0,string.length);
    [text addAttribute:NSParagraphStyleAttributeName value:style range:range];
    [text addAttributes:attrs range:range];
    //计算 string 的高度
    CGFloat height = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height+10;
    return height;
}
-(CGFloat)boundingRectWithInitSize:(CGSize)size String:(NSString *)string Font:(UIFont*)font{
    CGRect rect=[string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];

    return rect.size.height;
}
/***********************************************************************/
/*
 *请求楼盘详情
 */
-(void)getDetailInfoFromService{
    NSDictionary *dic = @{@"id":self.lid};
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",RequestUrl,ProjectInfo];
    [self showHudInView:self.view hint:nil];
    [ZJNRequestManager postWithUrlString:urlStr parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        if ([[data[@"code"] stringValue] isEqualToString:@"200"]) {
            detailModel = [[PremisesDetailModel alloc]initWithDictionary:data[@"info"]];
            [self creatView];
        }else{
            [self dismissViewControllerAnimated:YES completion:^{
                [self showHint:data[@"mes"]];
            }];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self dismissViewControllerAnimated:YES completion:^{
            [self showHint:@"连接服务器失败"];
        }];
        [self hideHud];
    }];
}
//返回按钮点击实现方法
-(void)backButtonClick{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
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
