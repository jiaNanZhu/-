//
//  AddImageView.m
//  ChaseFishProject
//
//  Created by 朱佳男 on 2017/5/10.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "AddImageView.h"
#import "EvaluationPreview.h"
@interface AddImageView()<UIScrollViewDelegate>
{
    UIScrollView *bottomScrollV;
}
@end
@implementation AddImageView
-(id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray  imageSize:(CGSize)imageSize{
    self = [super initWithFrame:frame];
    if (self) {
        _imageSize = imageSize;
        [self updateAddImageViewWithImageArr:imageArray];
    }
    return self;
}
//添加图片按钮
-(void)addImageButtonClick:(EvaluationPreview *)view{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addImageViewAddImageButtonClick)]) {
        [self.delegate addImageViewAddImageButtonClick];
    }
}
//图片预览按钮
-(void)previewImageViewButtonClick:(EvaluationPreview *)view{
    
}
//删除按钮点击实现方法
-(void)delButtonClick:(UIButton *)button{
    EvaluationPreview *preview = (EvaluationPreview *)[button superview];
    NSInteger tag = preview.tag-10;
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteImageViewDelImageButtonClick:)]) {
        [self.delegate deleteImageViewDelImageButtonClick:tag];
    }
    
}
//更新
-(void)updateAddImageViewWithImageArr:(NSArray *)imageArray{
    if (!bottomScrollV) {
        bottomScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        bottomScrollV.delegate = self;
        bottomScrollV.showsHorizontalScrollIndicator = NO;
        [self addSubview:bottomScrollV];
    }
    for (UIView *view in bottomScrollV.subviews) {
        if ([view isKindOfClass:[EvaluationPreview class]]) {
            [view removeFromSuperview];
        }
    }
    if (imageArray.count<9) {
        bottomScrollV.contentSize = CGSizeMake(12+(imageArray.count+1)*(_imageSize.width+4), 0);
    }else{
        bottomScrollV.contentSize = CGSizeMake(12+imageArray.count*(_imageSize.width+4), 0);
    }
    
    
    if (imageArray.count == 0) {
        EvaluationPreview *preview = [[EvaluationPreview alloc]initWithFrame:CGRectMake(0, 4, _imageSize.width, _imageSize.height)];
        preview.imageView.image = [UIImage imageNamed:@"addImage"];
        [Utile addClickEvent:self action:@selector(addImageButtonClick:) owner:preview];
        preview.delButton.hidden = YES;
        [bottomScrollV addSubview:preview];
    }else if (imageArray.count == 9){
        for (int i = 0; i <imageArray.count; i ++) {
            EvaluationPreview *view = [[EvaluationPreview alloc]initWithFrame:CGRectMake(i*(_imageSize.width +4), 4, _imageSize.width, _imageSize.height)];
            
            view.imageView.image = imageArray[i];
            
            view.tag = 10+i;
            [Utile addClickEvent:self action:@selector(previewImageViewButtonClick:) owner:view];
            [view.delButton addTarget:self action:@selector(delButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [bottomScrollV addSubview:view];
        }
    }else{
        for (int i =0; i <imageArray.count+1; i ++) {
            if (i <= imageArray.count-1) {
                EvaluationPreview *view = [[EvaluationPreview alloc]initWithFrame:CGRectMake(i*(_imageSize.width +4), 4, _imageSize.width, _imageSize.height)];
                view.imageView.image = imageArray[i];
                view.tag = 10+i;
                [Utile addClickEvent:self action:@selector(previewImageViewButtonClick:) owner:view];
                [view.delButton addTarget:self action:@selector(delButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [bottomScrollV addSubview:view];
            }else{
                EvaluationPreview *preview = [[EvaluationPreview alloc]initWithFrame:CGRectMake(i*(_imageSize.width +4), 4, _imageSize.width, _imageSize.height)];
                preview.imageView.image = [UIImage imageNamed:@"addImage"];
                [Utile addClickEvent:self action:@selector(addImageButtonClick:) owner:preview];
                preview.delButton.hidden = YES;
                [bottomScrollV addSubview:preview];
            }
        }
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
