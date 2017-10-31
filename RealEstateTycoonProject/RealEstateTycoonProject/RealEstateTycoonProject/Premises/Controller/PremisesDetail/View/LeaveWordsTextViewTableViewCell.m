//
//  LeaveWordsTextViewTableViewCell.m
//  RealEstateTycoonProject
//
//  Created by 朱佳男 on 2017/7/14.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "LeaveWordsTextViewTableViewCell.h"
#define MAX_LIMIT_NUMS 200
@interface LeaveWordsTextViewTableViewCell()<UITextViewDelegate>

@end
@implementation LeaveWordsTextViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:30 view:self.headerImageV];
    [Utile makeCorner:8 view:self.callPhoneButton];
    [Utile makeCorner:3 view:self.submitButton];
    self.leaveWordsTextView.delegate = self;
    // Initialization code
}
-(void)setInfoModel:(PremisesUserInfoModel *)infoModel{
    _infoModel = infoModel;
    [self.headerImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RequestUrl,_infoModel.img]] placeholderImage:[UIImage imageNamed:@"xq_bg"]];
    self.nameLabel.text = _infoModel.uname;
    self.titleLabel.text = _infoModel.position;
    self.companyLabel.text = _infoModel.company;
    self.telLabel.text = _infoModel.phone;
}
#pragma mark--UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.placeholderLabel.text = @"";
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.placeholderLabel.text = @"请输入您的留言内容（不得多余200字）...";
    }
}
//-(void)textViewDidChange:(UITextView *)textView{
//    self.residueLabel.text = [NSString stringWithFormat:@"还可以输入%lu字",200-textView.text.length];
//}
#pragma mark -限制病情描述输入字数(最多不超过255个字)
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //不支持系统表情的输入
    if ([[textView textInputMode] primaryLanguage]==nil||[[[textView textInputMode] primaryLanguage]isEqualToString:@"emoji"]) {
        return NO;
    }
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange =NSMakeRange(startOffset, endOffset - startOffset);
        if (offsetRange.location <MAX_LIMIT_NUMS) {
            return YES;
        }else{
            return NO;
        }
    }
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen =MAX_LIMIT_NUMS - comcatstr.length;
    if (caninputlen >=0){
        return YES;
    }else{
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        if (rg.length >0){
            NSString *s =@"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }else{
                __block NSInteger idx =0;
                __block NSString  *trimString =@"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring,NSRange substringRange,NSRange enclosingRange,BOOL* stop) {
                                          if (idx >= rg.length) {
                                              *stop =YES;//取出所需要就break，提高效率
                                              return ;
                                          }
                                          trimString = [trimString stringByAppendingString:substring];
                                          idx++;
                                      }];
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，哪一定是最大限制了。
            self.residueLabel.text = [NSString stringWithFormat:@"%d/%ld",0,(long)MAX_LIMIT_NUMS];
        }
        return NO;
    }
}

#pragma mark -显示当前可输入字数/总字数
- (void)textViewDidChange:(UITextView *)textView{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    if (existTextNum >MAX_LIMIT_NUMS){
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        [textView setText:s];
    }
    //不让显示负数
    self.residueLabel.text = [NSString stringWithFormat:@"还可以输入%ld字",MAX(0,MAX_LIMIT_NUMS - existTextNum)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
