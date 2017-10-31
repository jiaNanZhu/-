//
//  MiddleLabelTableViewCell.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/7.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "MiddleLabelTableViewCell.h"

@implementation MiddleLabelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.titleLabel.textColor = MainColor;
        self.separateLine.backgroundColor = MainColor;
    }else{
        self.titleLabel.textColor = MiddleGray;
        self.separateLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    // Configure the view for the selected state
}

@end
