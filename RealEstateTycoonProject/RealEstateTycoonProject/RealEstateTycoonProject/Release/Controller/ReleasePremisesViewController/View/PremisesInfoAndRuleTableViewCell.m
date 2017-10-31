//
//  PremisesInfoAndRuleTableViewCell.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/21.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "PremisesInfoAndRuleTableViewCell.h"
@interface PremisesInfoAndRuleTableViewCell()<UITextViewDelegate>

@end
@implementation PremisesInfoAndRuleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textView.delegate = self;
    // Initialization code
}
#pragma mark--
-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.policeHolderLabel.hidden = YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length>0) {
        
    }else{
        self.policeHolderLabel.hidden = NO;
    }
    if (self.textViewBlock) {
//        NSArray *array = [textView.text componentsSeparatedByString:@"\n"];
//        NSLog(@"%@",array);
//        NSString *text = [array componentsJoinedByString:@","];
        self.textViewBlock(textView.text);
        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
