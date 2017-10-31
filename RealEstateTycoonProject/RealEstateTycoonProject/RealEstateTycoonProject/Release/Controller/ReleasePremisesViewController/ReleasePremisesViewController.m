//
//  ReleasePremisesViewController.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/20.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "ReleasePremisesViewController.h"
#import "DoubleTextFieldTableViewCell.h"
#import "PremisesNameTableViewCell.h"
#import "ButtonATextFieldTableViewCell.h"
#import "PremisesNameTableViewCell.h"
#import "ReleaseAddressTableViewCell.h"
#import "DoubleSelectTimeTableViewCell.h"
#import "DoubleSelectTimeTableViewCell.h"
#import "HouseTypeImageTableViewCell.h"
#import "ContractImageTableViewCell.h"
#import "ZYQAssetPickerController.h"
#import "PremisesParameterTableViewCell.h"
#import "PremisesInfoAndRuleTableViewCell.h"
#import "AreaPremisesView.h"
#import "XHDatePickerView.h"
#import "NSDate+Extension.h"
#import "AddImageView.h"

@interface ReleasePremisesViewController ()<UITableViewDelegate,UITableViewDataSource,ReleaseAddressDelegate,ButtonATextFieldDelegate,AreaPremisesViewDelegate,DoubleSelectTimeDelegate,AddImageViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZYQAssetPickerControllerDelegate,HouseTypeImageCellDelegate,ContractImageCellDelegate,PremisesParameterDelegate>
{
    UITableView *_tableView;
    AreaPremisesView *areaPremisesV;//省市区选择页面
    AddImageView *addimageV;//添加头视图图片
    NSString *nameStr;//楼盘名称
    NSString *averagePrice;//楼盘均价
    NSString *areaStr;//房屋面积
    NSString *firstMoney;//首付
    NSString *commission;//佣金
    NSString *premisesDelegate;//楼盘代理方式
    NSString *predictPriceStr;//预计金额
    NSString *premisesAddress;//楼盘地址省市区
    NSString *proviceStr;//楼盘所在省
    NSString *cityStr;//楼盘所在市
    NSString *districtStr;//楼盘所在区
    NSString *premisesDetailAddress;//楼盘详细地址
    NSString *openTimeStr;//预计开盘时间
    NSString *giveTimeStr;//交房时间
    NSString *premisesType;//楼盘类型
    NSString *standardStr;//装修标准
    NSString *developerNameStr;//开发商名字
    NSString *infoStr;//楼盘资料
    NSString *ruleStr;//报备规则
    NSString *typeStr;//判断当前选择的什么类型的图片
    NSString *adImageStr;//楼盘广告图base64
    NSString *houseTypeImageStr;//楼盘户型图base64
    NSString *contractImageStr;//合同图片base64
    NSMutableArray *adImageArr;//楼盘广告图片数组
    NSMutableArray *houseTypeImageArr;//楼盘热销户型图盘数组
    NSMutableArray *contractImageArr;//楼盘合同图片数组
    UIImagePickerController  *imagePicker;
    ZYQAssetPickerController *zyqImagePicker;
}
@end

@implementation ReleasePremisesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    adImageArr = [NSMutableArray array];
    houseTypeImageArr = [NSMutableArray array];
    contractImageArr = [NSMutableArray array];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backanniu"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self initString];
    self.title = @"发布楼盘";
    [self creatView];
    // Do any additional setup after loading the view.
}
-(void)initString{
    openTimeStr = @"";
    giveTimeStr = @"";
    nameStr     = @"";
    averagePrice= @"";
    areaStr     = @"";
    firstMoney  = @"";
    commission  = @"";
    premisesDelegate = @"";
    predictPriceStr = @"";
    premisesAddress = @"";
    proviceStr = @"";
    cityStr = @"";
    districtStr = @"";
    premisesDetailAddress = @"";
    openTimeStr = @"";
    giveTimeStr = @"";
    premisesType= @"";
    standardStr = @"";
    developerNameStr = @"";
    infoStr     = @"";
    ruleStr     = @"";
}
-(void)creatView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableHeaderView = [self creatTableHeaderView];
    _tableView.tableFooterView = [self creatFooterView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    areaPremisesV = [[AreaPremisesView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    areaPremisesV.delegate = self;
    [self.view addSubview:areaPremisesV];
    areaPremisesV.hidden = YES;
}
-(UIView *)creatTableHeaderView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, ScreenWidth-16, 44)];
    titleLabel.font = TextFont(16);
    titleLabel.textColor = SetColor(0x333333);
    titleLabel.text = @"添加楼盘广告图";
    [view addSubview:titleLabel];
    
    UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, ScreenWidth, 0.5)];
    topLineView.backgroundColor = SeparateLineColor;
    [view addSubview:topLineView];
    
    addimageV = [[AddImageView alloc]initWithFrame:CGRectMake(8, 50, ScreenWidth-16, 90) imageArray:adImageArr imageSize:CGSizeMake(75, 75)];
    addimageV.delegate = self;
    [view addSubview:addimageV];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, view.height-0.5, ScreenWidth, 0.5)];
    lineView.backgroundColor = SeparateLineColor;
    [view addSubview:lineView];
    return view;
}
-(UIView *)creatFooterView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(10, 50, ScreenWidth-20, 50);
    [Utile makeCorner:3 view:submitButton];
    [submitButton setBackgroundColor:MainColor];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 6;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 4) {
            return 80;
        }else if (indexPath.row == 5){
            if (IS_IPHONE_5) {
                return 88;
            }
        }
    }else if (indexPath.section == 1){
        return 60+15+(ScreenWidth/2.0-12)*0.75;
    }else if (indexPath.section == 2){
        return 132;
    }else if (indexPath.section == 3){
        return 60+15+((ScreenWidth-32)/3.0)*1.3;
    }else if (indexPath.section == 4 || indexPath.section == 5){
        return 200;
    }
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *cellid = @"CELLID";
            PremisesNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"PremisesNameTableViewCell" owner:self options:nil]lastObject];
            }
            cell.premisesNameBlock = ^(NSString *premisesName) {
                nameStr = premisesName;
                NSLog(@"楼盘姓名是:%@",nameStr);
            };
            cell.textField.text = nameStr;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 1 || indexPath.row == 3){
            static NSString *cellid = @"CELLId";
            DoubleTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"DoubleTextFieldTableViewCell" owner:self options:nil]lastObject];
            }
            if (indexPath.row == 1) {
                cell.leftTextFieldBlock = ^(NSString *leftStr) {
                    averagePrice = leftStr;
                    NSLog(@"楼盘均价%@",leftStr);
                };
                cell.rightTextFieldBlock = ^(NSString *rightStr) {
                    areaStr = rightStr;
                    NSLog(@"房屋面积:%@",rightStr);
                };
                cell.leftTextField.text = averagePrice;
                cell.rightTextField.text = areaStr;
            }else if (indexPath.row == 3){
                cell.leftLabel.text = @"首付";
                cell.leftTextField.placeholder = @"请输入首付金额";
                cell.rightLabel.text = @"佣金额";
                cell.rightTextField.placeholder = @"请输入佣金额";
                cell.leftTextFieldBlock = ^(NSString *leftStr) {
                    firstMoney = leftStr;
                    NSLog(@"首付:%@",leftStr);
                };
                cell.rightTextFieldBlock = ^(NSString *rightStr) {
                    commission = rightStr;
                    NSLog(@"佣金额:%@",rightStr);
                };
                cell.leftTextField.text = firstMoney;
                cell.rightTextField.text = commission;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 2){
            static NSString *cellid = @"CELLid";
            
            ButtonATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"ButtonATextFieldTableViewCell" owner:self options:nil]lastObject];
            }
            cell.delegate = self;
            cell.buttonATextBlock = ^(NSString *delegateType) {
                premisesDelegate = delegateType;
                NSLog(@"楼盘代理方式:%@",delegateType);
            };
            cell.predictPriceBlock = ^(NSString *predictPrice) {
                predictPriceStr = predictPrice;
                NSLog(@"预计金额:%@",predictPrice);
            };
            if (premisesType.length>0) {
                cell.delegateLabel.text = premisesType;
            }
            
            cell.predictPriceTextField.text = predictPriceStr;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 4){
            static NSString *cellid = @"CELlid";
            ReleaseAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"ReleaseAddressTableViewCell" owner:self options:nil]lastObject];
            }
            cell.detailAddressBlock = ^(NSString *detailAddress) {
                premisesDetailAddress = detailAddress;
                NSLog(@"房源详细地址:%@",detailAddress);
            };
            if (premisesAddress.length>0) {
                cell.addressLabel.text = premisesAddress;
            }
            if (premisesDetailAddress.length>0) {
                cell.detailTextLabel.text = premisesDetailAddress;
            }
            cell.detailAddressTextField.text = premisesDetailAddress;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
        }else{
            static NSString *cellid = @"CEllid";
            DoubleSelectTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[DoubleSelectTimeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (openTimeStr.length >0) {
                cell.openTimeLabel.text = openTimeStr;
            }
            if (giveTimeStr.length >0) {
                cell.giveTimeLabel.text = giveTimeStr;
            }
            cell.delegate = self;
            return cell;
        }
        
    }else if (indexPath.section == 1){
        static NSString *cellid = @"Cellid";
        HouseTypeImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[HouseTypeImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid imageArray:houseTypeImageArr imageSize:CGSizeMake((ScreenWidth-24)/2.0, (ScreenWidth/2.0-12)*0.75)];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.titleLabel.text = @"热销户型图片";
        cell.imageArray = houseTypeImageArr;
        return cell;
    }else if (indexPath.section == 2){
        static NSString *cellid = @"parameter";
        PremisesParameterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PremisesParameterTableViewCell" owner:self options:nil]lastObject];
        }
        cell.delegate = self;
        cell.developerNameBlock = ^(NSString *developerName) {
            developerNameStr = developerName;
            NSLog(@"开发商名称:%@",developerName);
        };
        cell.premisesParameterBlock = ^(NSDictionary *infoDic) {
            NSString *string = infoDic[@"type"];
            if ([string isEqualToString:@"1"]) {
                premisesType = infoDic[@"info"];
                NSLog(@"楼盘类型:%@",infoDic[@"info"]);
            }else{
                standardStr = infoDic[@"info"];
                NSLog(@"装修标准:%@",infoDic[@"info"]);
            }
        };
        cell.developersNameTextField.text = developerNameStr;
        if (premisesType.length>0) {
            cell.typeLabel.text = premisesType;
        }
        if (standardStr.length>0) {
            cell.standardLabel.text = standardStr;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 3){
        
        static NSString *cellid = @"cellid";
        ContractImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[ContractImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid imageArray:houseTypeImageArr imageSize:CGSizeMake((ScreenWidth-32)/3.0, ((ScreenWidth-32)/3.0)*1.3)];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.titleLabel.text = @"合同图片";
        cell.imageArray = contractImageArr;
        return cell;
    }
    
    static NSString *cellid = @"celliden";
    PremisesInfoAndRuleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PremisesInfoAndRuleTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 4) {
        cell.titleLabel.text = @"楼盘资料";
        cell.policeHolderLabel.text = @"请输入楼盘资料...";
        cell.textViewBlock = ^(NSString *text) {
            infoStr = text;
        };
        cell.textView.text = infoStr;
    }else{
        cell.titleLabel.text = @"报备规则";
        cell.policeHolderLabel.text = @"请输入报备规则...";
        cell.textViewBlock = ^(NSString *text) {
//            NSArray *array = [text componentsSeparatedByString:@","];
//            NSString *string = [array componentsJoinedByString:@"\n"];
            ruleStr = text;
        };
        cell.textView.text = ruleStr;
    }
    return cell;
    
}
//选择楼盘地址
-(void)selectAddress{
    areaPremisesV.hidden = NO;
}
//选择楼盘地址后执行方法
-(void)areaPremisesViewSelectedAddress:(NSDictionary *)address{
    areaPremisesV.hidden = YES;
    NSLog(@"%@",address);
    proviceStr = address[@"provice"];
    cityStr = address[@"city"];
    districtStr = address[@"district"];
    
    ReleaseAddressTableViewCell *cell = (ReleaseAddressTableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    premisesAddress = [NSString stringWithFormat:@"%@%@%@",proviceStr,cityStr,districtStr];
    cell.addressLabel.text = premisesAddress;
}
//展示房源代理方式
-(void)ButtonATextFieldShowAlert:(UIAlertController *)alertC{
    [self presentViewController:alertC animated:NO completion:^{
        
    }];
}
//选择时间
-(void)selectTimeWithType:(NSString *)type{
    
    NSDate *currentDate = [NSDate date];
    NSString *currentDateString = [currentDate stringWithFormat:@"yyyy-MM-dd"];
    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCurrentDate:[NSDate date:currentDateString WithFormat:@"yyyy-MM-dd"] CompleteBlock:^(NSDate *startDate, NSDate *endDate) {
        NSLog(@"\n开始时间： %@，结束时间：%@",startDate,endDate);
        if ([type isEqualToString:@"open"]) {
            openTimeStr = [startDate stringWithFormat:@"yyyy-MM-dd"];
        }else{
            giveTimeStr = [startDate stringWithFormat:@"yyyy-MM-dd"];
        }
        
        [_tableView reloadData];
    }];
    
    datepicker.datePickerStyle = DateStyleShowYearMonthDay;
    datepicker.selectType = SingleSelect;
    datepicker.dateType = DateTypeStartDate;
    datepicker.minLimitDate = [NSDate date:@"1970-01-01" WithFormat:@"yyyy-MM-dd"];
    datepicker.maxLimitDate = [NSDate date:@"2050-01-01" WithFormat:@"yyyy-MM-dd"];
    [datepicker show];
}
#pragma mark--AddImageViewDelegate
//添加楼盘广告图片
-(void)addImageViewAddImageButtonClick{
    [self chosePhotoWithType:@"0"];
}
//删除楼盘广告图片
-(void)deleteImageViewDelImageButtonClick:(NSInteger)index{
    [adImageArr removeObjectAtIndex:index];
    [addimageV updateAddImageViewWithImageArr:adImageArr];
}
#pragma mark--HouseTypeImageCellDelegate
//添加楼盘户型图片
-(void)addHouseTypeImage{
    [self chosePhotoWithType:@"1"];
}
//删除楼盘户型图片
-(void)delegateHouseTypeImageWithIndex:(NSInteger)index{
    [houseTypeImageArr removeObjectAtIndex:index];
    [_tableView reloadData];
}
#pragma mark--ContractImageCellDelegate
//添加合同图片
-(void)addContractImage{
    [self chosePhotoWithType:@"2"];
}
//删除合同图片
-(void)deleteContractImageWithIndex:(NSInteger)index{
    [contractImageArr removeObjectAtIndex:index];
    [_tableView reloadData];
}
#pragma mark--PremisesParameterDelegate
-(void)premisesParameterSelectTypeOrStandarWithAlertController:(UIAlertController *)alertC{
    [self presentViewController:alertC animated:YES completion:^{
        
    }];
}
#pragma mark--拍照
#pragma mark 选择照片
- (void)chosePhotoWithType:(NSString *)type{
    //type == 0 选择楼盘广告图 type==1 选择热销户型图 type==2 选择合同图片
    typeStr = type;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *firstAct = [UIAlertAction actionWithTitle:@"拍照上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (!imagePicker) {
            imagePicker = [[UIImagePickerController alloc]init];
        }
        imagePicker.delegate = self;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
    }];
    [firstAct setValue:MainColor forKey:@"_titleTextColor"];
    UIAlertAction *secondAct = [UIAlertAction actionWithTitle:@"本地相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        zyqImagePicker = [[ZYQAssetPickerController alloc]init];
        if ([type isEqualToString:@"0"]) {
            zyqImagePicker.maximumNumberOfSelection = 9 - adImageArr.count;
        }else if ([type isEqualToString:@"1"]){
            zyqImagePicker.maximumNumberOfSelection = 9 - houseTypeImageArr.count;
        }else if ([type isEqualToString:@"2"]){
            zyqImagePicker.maximumNumberOfSelection = 9 - contractImageArr.count;
        }
        
        zyqImagePicker.assetsFilter = [ALAssetsFilter allPhotos];
        zyqImagePicker.delegate = self;
        zyqImagePicker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id  evaluatedObject, NSDictionary*  bindings) {
            if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType]isEqual:ALAssetTypeVideo]) {
                NSTimeInterval duration = [[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyDuration]doubleValue];
                return duration >= 9;
            }else{
                return YES;
            }
        }];
        [self presentViewController:zyqImagePicker animated:YES completion:NULL];
    }];
    [secondAct setValue:MainColor forKey:@"_titleTextColor"];
    UIAlertAction *thirdAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [thirdAct setValue:MiddleGray forKey:@"_titleTextColor"];
    [alert addAction:firstAct];
    [alert addAction:secondAct];
    [alert addAction:thirdAct];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}
#pragma mark - ZYQAssetPickerColltroller delegate
- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    for (int i = 0; i < assets.count; i ++) {
        ALAsset *asset = assets[i];
        UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        if ([typeStr isEqualToString:@"0"]) {
            [adImageArr addObject:image];
            [addimageV updateAddImageViewWithImageArr:adImageArr];
        }else if ([typeStr isEqualToString:@"1"]){
            [houseTypeImageArr addObject:image];
            [_tableView reloadData];
        }else if ([typeStr isEqualToString:@"2"]){
            [contractImageArr addObject:image];
            [_tableView reloadData];
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];

    if ([typeStr isEqualToString:@"0"]) {
        [adImageArr addObject:image];
        [addimageV updateAddImageViewWithImageArr:adImageArr];
    }else if ([typeStr isEqualToString:@"1"]){
        [houseTypeImageArr addObject:image];
        [_tableView reloadData];
    }else if ([typeStr isEqualToString:@"2"]){
        [contractImageArr addObject:image];
        [_tableView reloadData];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{

    }];
}

- (void)assetPickerControllerDidMaximum:(ZYQAssetPickerController *)picker{
    NSLog(@"到达上限");
}
//返回按钮点击实现方法
-(void)backButtonClick{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
#pragma mark--提交
-(void)submitButtonClick:(UIButton *)button{
    for (UIImage *image in adImageArr) {
        NSData *data = UIImageJPEGRepresentation(image, 0.1);
        NSString *imageStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        if (adImageStr.length == 0) {
            adImageStr = imageStr;
        }else{
            adImageStr = [NSString stringWithFormat:@"%@,%@",adImageStr,imageStr];
        }
    }
    for (UIImage *image in houseTypeImageArr) {
        NSData *data = UIImageJPEGRepresentation(image, 0.1);
        NSString *imageStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        if (houseTypeImageStr.length == 0) {
            houseTypeImageStr = imageStr;
        }else{
            houseTypeImageStr = [NSString stringWithFormat:@"%@,%@",houseTypeImageStr,imageStr];
        }
    }
    for (UIImage *image in contractImageArr) {
        NSData *data = UIImageJPEGRepresentation(image, 0.1);
        NSString *imageStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        if (contractImageStr.length == 0) {
            contractImageStr = imageStr;
        }else{
            contractImageStr = [NSString stringWithFormat:@"%@,%@",contractImageStr,imageStr];
        }
    }
    
    NSArray *keysArray = @[@"token",@"name",@"price",@"size",@"payment",@"agent",@"commission",@"province",@"city",@"area",@"location",@"start_time",@"end_time",@"property",@"decorate",@"developer",@"contract",@"info",@"report",@"ad",@"house"];
    NSArray *valuesArray = @[Token,nameStr,averagePrice,areaStr,firstMoney,premisesDelegate,commission,proviceStr,cityStr,districtStr,premisesDetailAddress,openTimeStr,giveTimeStr,typeStr,standardStr,developerNameStr,contractImageStr,infoStr,ruleStr,adImageStr,houseTypeImageStr];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:valuesArray forKeys:keysArray];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",RequestUrl,AddProject];
    [self showHudInView:self.view hint:nil];
    [ZJNRequestManager postWithUrlString:urlStr parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        if ([[data[@"code"] stringValue] isEqualToString:@"200"]) {
            [self dismissViewControllerAnimated:NO completion:^{
                
            }];
        }
        [self showHint:data[@"mes"]];
        [self hideHud];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self hideHud];
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
