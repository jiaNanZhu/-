//
//  DoubleSelectTimeTableViewCell.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/20.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "DoubleSelectTimeTableViewCell.h"

@implementation DoubleSelectTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}
-(void)creatView{
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 12, 66, 20)];
    leftLabel.text = @"预计开盘:";
    leftLabel.textColor = SetColor(0x333333);
    leftLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:leftLabel];
    
    self.openTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftLabel.frame)+7, 12, ScreenWidth/2.0-32-15-65, 20)];
    if (IS_IPHONE_5) {
        self.openTimeLabel.frame = CGRectMake(CGRectGetMaxX(leftLabel.frame)+7, 12, 80, 20);
        UIButton *openButton = [UIButton buttonWithType:UIButtonTypeCustom];
        openButton.frame = CGRectMake(CGRectGetMaxX(leftLabel.frame)+7, 0, ScreenWidth-leftLabel.width-15, 44);
        [openButton addTarget:self action:@selector(selectOpenTime) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:openButton];
    }else{
        self.openTimeLabel.frame = CGRectMake(CGRectGetMaxX(leftLabel.frame)+7, 12, ScreenWidth/2.0-32-15-65, 20);
        [Utile addClickEvent:self action:@selector(selectOpenTime) owner:self.openTimeLabel];
    }
    self.openTimeLabel.text = @"请选择时间";
    self.openTimeLabel.textColor = SetColor(0x999999);
    self.openTimeLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.openTimeLabel];
    
    UIImageView *leftTimeImageV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.openTimeLabel.frame)+8, leftLabel.centerY-8, 16, 16)];
    leftTimeImageV.image = [UIImage imageNamed:@"rl"];
    [self.contentView addSubview:leftTimeImageV];
    
    if (IS_IPHONE_5) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, ScreenWidth, 0.5)];
        lineView.backgroundColor = SeparateLineColor;
        [self.contentView addSubview:lineView];
    }
    
    UILabel *rightLabel = [[UILabel alloc]init];
    if (IS_IPHONE_5) {
        rightLabel.frame = CGRectMake(8, CGRectGetMaxY(leftLabel.frame)+24, 66, 20);
    }else{
        rightLabel.frame = CGRectMake(CGRectGetMaxX(leftTimeImageV.frame)+16, 12, 66, 20);
    }
    rightLabel.text = @"交房时间:";
    rightLabel.textColor = SetColor(0x333333);
    rightLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:rightLabel];
    
    self.giveTimeLabel = [[UILabel alloc]init];
    
    if (IS_IPHONE_5) {
        self.giveTimeLabel.frame = CGRectMake(CGRectGetMaxX(rightLabel.frame)+7, rightLabel.y, 80, 20);
        UIButton *giveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        giveButton.frame = CGRectMake(CGRectGetMaxX(rightLabel.frame)+7, 44, ScreenWidth-leftLabel.width-15, 44);
        [giveButton addTarget:self action:@selector(selectGiveTime) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:giveButton];
    }else{
        self.giveTimeLabel.frame = CGRectMake(CGRectGetMaxX(rightLabel.frame)+7, rightLabel.y, ScreenWidth/2.0-32-15-65, 20);
        [Utile addClickEvent:self action:@selector(selectGiveTime) owner:self.giveTimeLabel];
    }
    
    self.giveTimeLabel.text = @"请选择时间";
    self.giveTimeLabel.textColor = SetColor(0x999999);
    self.giveTimeLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.giveTimeLabel];
    
    UIImageView *rightTimeImageV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.giveTimeLabel.frame)+8, rightLabel.centerY-8, 16, 16)];
    rightTimeImageV.image = [UIImage imageNamed:@"rl"];
    [self.contentView addSubview:rightTimeImageV];
    
}
//选择预计开盘时间
-(void)selectOpenTime{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectTimeWithType:)]) {
        [self.delegate selectTimeWithType:@"open"];
    }
    NSLog(@"选择开盘时间");
}
//选择交房时间
-(void)selectGiveTime{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectTimeWithType:)]) {
        [self.delegate selectTimeWithType:@"give"];
    }
    NSLog(@"选择交房时间");
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
