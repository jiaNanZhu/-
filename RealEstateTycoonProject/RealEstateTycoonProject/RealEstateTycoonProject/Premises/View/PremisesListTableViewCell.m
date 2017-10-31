//
//  PremisesListTableViewCell.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/7.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "PremisesListTableViewCell.h"

@implementation PremisesListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.coverImageView setContentMode:UIViewContentModeScaleAspectFill];
    self.coverImageView.clipsToBounds = YES;
    
    // Initialization code
}
-(void)setModel:(PremisesListModel *)model{
    _model = model;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RequestUrl,self.model.ad]] placeholderImage:[UIImage imageNamed:@"xq_bg"]];
    self.nameLabel.text = [NSString stringWithFormat:@"(%@)%@",self.model.city,self.model.name];
    self.areaLabel.text = [NSString stringWithFormat:@"面积：%@m²",self.model.size];
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@/m²",self.model.price];
    [Utile setUILabel:self.moneyLabel data:@"¥" setData:[NSString stringWithFormat:@"%@/m²",self.model.price] color:[UIColor redColor] font:15 underLine:NO];
    self.typeLabel.text = [NSString stringWithFormat:@"代理：%@",self.model.agent];
    self.downPaymentLabel.text = [NSString stringWithFormat:@"首付：%@万起",self.model.payment];
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",self.model.province,self.model.city,self.model.area,self.model.location];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
