//
//  DemandTableViewCell.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/17.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "DemandTableViewCell.h"

@implementation DemandTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headerImageV.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageV.clipsToBounds = YES;
    [Utile makeCorner:27.5 view:self.headerImageV];
    
    // Initialization code
}
-(void)updateConstraints{
    [super updateConstraints];
    self.typeLabelWidth.constant = (ScreenWidth-16)/3.0;
    self.souceLabelWidth.constant = (ScreenWidth-16)/3.0;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
