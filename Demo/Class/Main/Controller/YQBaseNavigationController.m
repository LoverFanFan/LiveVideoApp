//
//  YQBaseNavigationController.m
//  Demo
//
//  Created by Mopon on 16/4/29.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "YQBaseNavigationController.h"

@interface YQBaseNavigationController ()

@property (nonatomic, assign) UIInterfaceOrientationMask interfaceOrientationMask;

@end

@implementation YQBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    self.navigationBar.translucent = YES;
    [self.navigationBar removeFromSuperview];
}

/// 改变支持的旋转方向
- (void)changeSupportedInterfaceOrientations:(UIInterfaceOrientationMask)interfaceOrientation{
    
    _interfaceOrientationMask = interfaceOrientation;
}

/// 返回是否支持屏幕旋转
- (BOOL)shouldAutorotate
{
    return YES;
}


/// 返回支持的旋转方向
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return _interfaceOrientationMask;
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
