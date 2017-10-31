//
//  AddImageView.h
//  ChaseFishProject
//
//  Created by 朱佳男 on 2017/5/10.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddImageViewDelegate<NSObject>
//添加项目图片
-(void)addImageViewAddImageButtonClick;
//删除项目图片
-(void)deleteImageViewDelImageButtonClick:(NSInteger)index;
@end
@interface AddImageView : UIView
@property (nonatomic ,assign)CGSize imageSize;
@property (nonatomic ,weak)id<AddImageViewDelegate>delegate;
-(id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray imageSize:(CGSize)imageSize;
-(void)updateAddImageViewWithImageArr:(NSArray *)imageArray;
@end
