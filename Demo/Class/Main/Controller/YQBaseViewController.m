//
//  YQBaseViewController.m
//  Demo
//
//  Created by Mopon on 16/4/29.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "YQBaseViewController.h"

@interface YQBaseViewController ()
{
    
    UIView          *_separateLine;
    
}

@end

@implementation YQBaseViewController
@synthesize navBarBackView = _navBarBackView;

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.statusLayer = [CALayer layer];
    self.statusLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.statusHeight);
    self.statusLayer.backgroundColor = [UIColor orangeColor].CGColor;
    
    // [self.view.layer addSublayer:self.statusLayer];
    self.statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.statusHeight)];
    self.statusView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.statusView];
    
    
    self.navBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.statusHeight, SCREEN_WIDTH, 44)];
    self.navBar.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.navBar];
    [self.view bringSubviewToFront:self.navBar];
    
    //底部分隔线
    _separateLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.navBar.height-0.5, SCREEN_WIDTH, 0.5)];
    _separateLine.backgroundColor = [UIColor lightGrayColor];
    [self.navBar addSubview:_separateLine];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

/**
 *  毛玻璃
 */
- (void)showBlurBar{
    
    NSString  *systemVersion = [[UIDevice currentDevice] systemVersion];
    if([systemVersion floatValue] < 8.0)
        return;
    
    if (!self.navBarEffectView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        self.navBarEffectView =  [[UIVisualEffectView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.navBar.bottom)];
        [self.navBarEffectView setEffect:blurEffect];
        [self.view addSubview:self.navBarEffectView];
    }
    else {
        [self.view bringSubviewToFront:self.navBarEffectView];
    }
    
    if (!_navBarBackView) {
        _navBarBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.navBar.bottom)];
        _navBarBackView.backgroundColor = [UIColor orangeColor];
        _navBarBackView.alpha = 0.5;
        
        [self.view addSubview:_navBarBackView];
    }
    else{
        [self.view bringSubviewToFront:_navBarBackView];
    }
    self.navBar.backgroundColor = [UIColor clearColor];
    [self.view bringSubviewToFront:self.navBar];
}

- (void)hiddenBlurBar{
    
    if (_navBarBackView) {
        [_navBarBackView removeFromSuperview];
        _navBarBackView = nil;
    }
    if (_navBarEffectView) {
        [_navBarEffectView removeFromSuperview];
        _navBarEffectView = nil;
    }
}

- (UIButton *)navButtonWithFrameAndImage:(CGRect)frame image:(NSString *)image{
    
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    
    return button;
    
}

- (UIButton *)navButtonWithFrame:(CGRect)frame Title:(NSString *)title withImage:(NSString *)image{
    
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    button.backgroundColor = [UIColor clearColor];
    
    UIImageView *imgView    =[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 12, 20)];
    imgView.image           = [UIImage imageNamed:image];
    imgView.center          = CGPointMake(imgView.center.x, frame.size.height/2);
    imgView.backgroundColor = [UIColor clearColor];
    [button addSubview:imgView];
    
    if (title&&title.length>0) {
        
        UILabel *backLab  = [[UILabel alloc]init];
        backLab.textColor = [UIColor whiteColor];
        backLab.text      = title;
        backLab.font      = [UIFont systemFontOfSize:16];
        [backLab sizeToFit];
        backLab.center    = CGPointMake(imgView.right+8+backLab.width/2, imgView.center.y);
        [button addSubview:backLab];
    }
    
    return button;
}

- (UIButton *)navButtonWithFrame:(CGRect)frame Title:(NSString *)title{
    
    UIButton *button;
    if(title){
        
        button = [UIButton new];
        button.frame = frame;
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = CGRectMake(10, (button.height-10)*0.5, 12, 10);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(5, 0)];
        [path addLineToPoint:CGPointMake(0 ,5)];
        [path addLineToPoint:CGPointMake(5, 10)];
        [path moveToPoint:CGPointMake(0, 5)];
        [path addLineToPoint:CGPointMake(12, 5)];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [UIColor blackColor].CGColor;
        shapeLayer.lineWidth = 1;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        [button.layer addSublayer:shapeLayer];
        if (title&&title.length>0) {
            CATextLayer *textLayer = [CATextLayer layer];
            textLayer = [self textLayer:textLayer withBoldSize:13 andString:title color:[UIColor blackColor].CGColor];
            textLayer.frame = CGRectMake(28, (button.height-18)*0.5, title.length*15, 18);
            textLayer.alignmentMode = kCAAlignmentLeft;
            [button.layer addSublayer:textLayer];
        }
        
    }
    else{
        
        button = [[UIButton alloc]initWithFrame:frame];
        [button setImage:[UIImage imageNamed:@"back-black.png"] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
    }
    return button;
}

-(void)setViewTitle:(NSString *)aTitle{
    
    self.navTextLayer = [CATextLayer layer];
    self.navTextLayer = [self textLayer:self.navTextLayer withBoldSize:18 andString:aTitle color:[UIColor blackColor].CGColor];
    self.navTextLayer.frame = CGRectMake(0, 0, 140, 24);
    self.navTextLayer.position = CGPointMake(SCREEN_WIDTH*0.5, CGRectGetMidY(self.navBar.bounds));
    self.navTextLayer.alignmentMode = kCAAlignmentCenter;
    self.navTextLayer.truncationMode = @"end";
    [self.navBar.layer addSublayer:self.navTextLayer];
}

-(void)initAuthenNavi:(NSString *)title{
    
    [self setViewTitle:title];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIButton *backBtn = [self navButtonWithFrame:CGRectMake(0, 0, 80, 30) Title:@"返回" withImage:@"profile_back.png"];
    backBtn.center = CGPointMake(backBtn.center.x, CGRectGetMidY(self.navBar.bounds));
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:backBtn];
    
}

- (CATextLayer *)textLayer:(CATextLayer *)textLayer withBoldSize:(float)size andString:(id)str color:(CGColorRef)colorRef{
    
    UIFont *titleFont = [UIFont systemFontOfSize:size];
    CFStringRef titleFontName = (__bridge CFStringRef)titleFont.fontName;
    CGFontRef titleFontRef = CGFontCreateWithFontName(titleFontName);
    textLayer.font = titleFontRef;
    textLayer.foregroundColor = colorRef;
    textLayer.fontSize = titleFont.pointSize;
    textLayer.alignmentMode = kCAAlignmentJustified;
    CGFontRelease(titleFontRef);
    textLayer.string = str;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    return textLayer;
}


-(void)backAction:(id)sender{
    
    if (self.navigationController.viewControllers.count>1) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
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
