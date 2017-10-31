//
//  CroppingImageViewController.m
//  CroppingImageDemo
//
//  Created by 朱佳男 on 2017/4/24.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "CroppingImageViewController.h"
#define ImageWithName(name)  ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]])
@interface CroppingImageViewController (){
    __block void(^cropCompleteBlock)(UIImage*img);
    UIView *contentView;
    CGFloat imageScale;//default zoomscale
    UIImage *originImage;
    UIImageView *originImageView;//原图view
    UIImageView *reviewImageView;//预览view
    CGRect originImageViewFrame;//默认的图片frame
    UIImageView *dashedBoxView;//裁剪框
    UIButton *confirmButton;//确定按钮
    UIButton *cancelButton;//取消裁剪
    CGSize signSize;
}

@end

@implementation CroppingImageViewController
-(id)initWithCompleteBlock:(void (^)(UIImage *))block{
    self = [super init];
    if (self) {
        cropCompleteBlock = block;
        
    }
    return self;
}
-(id)initWithRect:(CGSize)size completeBlock:(void (^)(UIImage *img))block{
    self = [super init];
    if (self) {
        cropCompleteBlock = block;
        signSize = size;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    originImage = self.selectedImage;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirmButtonAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    switch (originImage.imageOrientation) {
        case UIImageOrientationLeft:{//90 deg CCW
            originImage = [self image:originImage rotatedByDegrees:-90];
            originImage = [self scaleImage:originImage toSize:CGSizeMake(originImage.size.height, originImage.size.width)];
            break;
        }
        case UIImageOrientationRight:{//90 deg CW
            originImage = [self image:originImage rotatedByDegrees:90];
            originImage = [self scaleImage:originImage toSize:CGSizeMake(originImage.size.height, originImage.size.width)];
            break;
        }
        case UIImageOrientationDown:{// 180 deg rotation
            // 180 deg rotation
            originImage = [self image:originImage rotatedByDegrees:180];
            break;
        }
        default:
            break;
    }
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//    contentView.transform = CGAffineTransformMakeRotation(M_PI/2.0);
    contentView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:contentView];
    
    originImageView = [[UIImageView alloc] init];
    originImageView.image = originImage;
    originImageView.clipsToBounds = NO;
    originImageView.userInteractionEnabled = YES;
    if (originImage.size.height>=originImage.size.width) {
        imageScale = contentView.frame.size.height/originImage.size.height;
    }else{
        imageScale = contentView.frame.size.width/originImage.size.width;
    }
    originImageView.frame = CGRectMake(0, 0, 2*originImage.size.width*imageScale, 2*originImage.size.height*imageScale);
    [contentView addSubview:originImageView];
    originImageView.center = self.view.center;
    [self addUserGustrue];
    originImageViewFrame = originImageView.frame;
    
    // 虚线框
    CGFloat cropWithd = signSize.width;
    CGFloat cropHeight = signSize.height;
    dashedBoxView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - cropWithd)/2.0, self.view.center.y-signSize.height/2.0, cropWithd, cropHeight)];
    dashedBoxView.userInteractionEnabled = NO;
    dashedBoxView.image = [UIImage imageNamed:@"caijian_bg"];
    
    // 预览view
    reviewImageView = [[UIImageView alloc] initWithFrame:dashedBoxView.frame];
    reviewImageView.userInteractionEnabled = NO;
    [contentView addSubview:reviewImageView];
    [contentView addSubview:dashedBoxView];
    // Do any additional setup after loading the view.
}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden = NO;
//}
-(void)backButtonClick:(id)sender{
    [self.navigationController popViewControllerAnimated:NO];
}
// 确定按钮
- (void)confirmButtonAction{
    float zoomScale = originImageView.frame.size.height/originImage.size.height;
    CGFloat originX = dashedBoxView.frame.origin.x-originImageView.frame.origin.x;
    CGFloat originY = dashedBoxView.frame.origin.y-originImageView.frame.origin.y;
    CGSize cropSize = CGSizeMake(dashedBoxView.frame.size.width/zoomScale, dashedBoxView.frame.size.height/zoomScale);
    
    
    CGRect cropRect = CGRectMake(originX/zoomScale, originY/zoomScale, cropSize.width, cropSize.height);
    NSLog(@"originX:%lf originY:%lf,corpRect:%@",originX,originY,[NSValue valueWithCGRect:cropRect]);
    
    CGImageRef tmp = CGImageCreateWithImageInRect([originImage CGImage], cropRect);
    self.croppedImage = [UIImage imageWithCGImage:tmp scale:originImage.scale orientation:originImage.imageOrientation];
    NSLog(@"image size:%@",[NSValue valueWithCGSize:self.croppedImage.size]);
    if (self.croppedImage.size.width > 720) {
        self.croppedImage = [self scaleImage:self.croppedImage toSize:CGSizeMake(720, 480)];
    }
    
    // 显示裁剪结果
    reviewImageView.image = self.croppedImage;
    // 隐藏原图
    originImageView.hidden = YES;
    // 显示确定按钮
    confirmButton.hidden = NO;
    // 显示取消按钮
    cancelButton.hidden = NO;
    cropCompleteBlock(self.croppedImage);
    [self.navigationController popViewControllerAnimated:NO];
}

// 添加手势
- (void)addUserGustrue{
    UIPinchGestureRecognizer *scaleGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImage:)];
    [originImageView addGestureRecognizer:scaleGes];
    
    
    UIPanGestureRecognizer *moveGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveImage:)];
    [moveGes setMinimumNumberOfTouches:1];
    [moveGes setMaximumNumberOfTouches:1];
    [originImageView addGestureRecognizer:moveGes];
}
// 处理缩放
float _lastScale = 1.0;
- (void)scaleImage:(UIPinchGestureRecognizer *)sender
{
    if([sender state] == UIGestureRecognizerStateBegan) {
        _lastScale = 1.0;
        return;
    }
    
    
    CGFloat scale = [sender scale]/_lastScale;
    
    if([sender state] == UIGestureRecognizerStateEnded) {
        // 裁剪框必须在图片内部
        if (![self dashebBoxInsideOriginImageView]) {
            return;
        }
    }
    
    CGAffineTransform currentTransform = originImageView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [originImageView setTransform:newTransform];
    
    
    _lastScale = [sender scale];
}

// 处理移动
float _lastTransX = 0.0, _lastTransY = 0.0;
- (void)moveImage:(UIPanGestureRecognizer *)sender
{
    CGPoint translatedPoint = [sender translationInView:contentView];
    
    if([sender state] == UIGestureRecognizerStateBegan) {
        _lastTransX = 0.0;
        _lastTransY = 0.0;
    }
    
    if([sender state] == UIGestureRecognizerStateEnded) {
        if (![self dashebBoxInsideOriginImageView]) {
            return;
        }
    }
    
    CGAffineTransform trans = CGAffineTransformMakeTranslation(translatedPoint.x - _lastTransX, translatedPoint.y - _lastTransY);
    CGAffineTransform newTransform = CGAffineTransformConcat(originImageView.transform, trans);
    _lastTransX = translatedPoint.x;
    _lastTransY = translatedPoint.y;
    
    originImageView.transform = newTransform;
}


// 检查裁剪框是否还在图片矩形内部，不在还原
- (BOOL)dashebBoxInsideOriginImageView{
    if(!CGRectContainsRect(originImageView.frame, dashedBoxView.frame)){
        [self recoverOriginImageviewStatus];
        return NO;
    }
    return YES;
}

// 恢复originImageview的默认状态
- (void)recoverOriginImageviewStatus{
    [UIView animateWithDuration:0.3
                     animations:^{
                         originImageView.frame = originImageViewFrame;
                     }
                     completion:^(BOOL finished){}];
}

#pragma mark - CroppingController private
CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

- (UIImage *)image:(UIImage*)image rotatedByRadians:(CGFloat)radians{
    return [self image:image rotatedByDegrees:RadiansToDegrees(radians)];
}

- (UIImage *)image:(UIImage*)image rotatedByDegrees:(CGFloat)degrees{
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-image.size.width / 2, -image.size.height / 2, image.size.width, image.size.height), [image CGImage]);
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resImage;
}

//等比例缩放
-(UIImage*)scaleImage:(UIImage*)image toSize:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
