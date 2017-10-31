//
//  EvaluationPreview.m
//  ChaseFishProject
//
//  Created by 朱佳男 on 2017/4/16.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "EvaluationPreview.h"

@implementation EvaluationPreview
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(4, 4, CGRectGetWidth(frame)-8, CGRectGetHeight(frame)-8)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self addSubview:self.imageView];
        self.delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.delButton.frame = CGRectMake(CGRectGetWidth(frame)-20, 0, 20, 20);
        [self.delButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [self addSubview:self.delButton];
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
