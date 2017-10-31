//
//  HouseTypeView.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/12.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "HouseTypeView.h"

@implementation HouseTypeView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.houseTypeImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self.houseTypeImageV setContentMode:UIViewContentModeScaleAspectFill];
        self.houseTypeImageV.clipsToBounds = YES;
        [self addSubview:self.houseTypeImageV];
        
        self.houseTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height-30, self.width, 30)];
        self.houseTypeLabel.font = TextFont(16);
        self.houseTypeLabel.backgroundColor = RGBColor(0, 0, 0, 0.5);
        self.houseTypeLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.houseTypeLabel];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
