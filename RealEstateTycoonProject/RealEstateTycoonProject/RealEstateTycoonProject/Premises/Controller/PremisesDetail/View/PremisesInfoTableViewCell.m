//
//  PremisesInfoTableViewCell.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/12.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "PremisesInfoTableViewCell.h"

@implementation PremisesInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDetailModel:(PremisesDetailModel *)detailModel{
    _detailModel = detailModel;
    self.premisesTypeLabel.text = [NSString stringWithFormat:@"物业类型:%@",_detailModel.property];
    self.standardLabel.text = [NSString stringWithFormat:@"装修标准:%@",_detailModel.decorate];
    self.companyLabel.text = [NSString stringWithFormat:@"开发商:%@",_detailModel.developer];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
