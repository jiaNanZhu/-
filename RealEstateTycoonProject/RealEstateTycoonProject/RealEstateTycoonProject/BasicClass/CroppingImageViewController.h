//
//  CroppingImageViewController.h
//  CroppingImageDemo
//
//  Created by 朱佳男 on 2017/4/24.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CroppingImageViewController : UIViewController
@property (nonatomic ,strong) UIImage *croppedImage;
@property (nonatomic ,strong) UIImage *selectedImage;
- (id)initWithCompleteBlock:(void (^)(UIImage *img))block;
-(id)initWithRect:(CGSize)size completeBlock:(void (^)(UIImage *img))block;
@end
