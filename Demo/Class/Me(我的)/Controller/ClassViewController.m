//
//  ClassViewController.m
//  Demo
//
//  Created by 吴启凡 on 16/6/23.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "ClassViewController.h"
#import "YQBaseNavigationController.h"
#import "EditClassViewController.h"
#import "ChangeClassTimeView.h"

@interface ClassViewController ()
{
    UIButton *_forceRotationBtn;
    BOOL     _isPortrait;
}

@end

@implementation ClassViewController


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"课程表";
    _isPortrait = YES;
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNav];
    [self forceRotation];
    // Do any additional setup after loading the view.
}

- (void)initNav{
    
    NSMutableArray *array = [NSMutableArray array];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                             target:self
                                                                             action:@selector(back)];
    //self.navigationItem.leftBarButtonItem = leftItem;
    [array addObject:leftItem];
    
    UIBarButtonItem *leftItem2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(addAction)];
    [array addObject:leftItem2];
    self.navigationItem.leftBarButtonItems = array;
    
}

#pragma mark - ClickAction

- (void)back
{
    /**
     *  页面关闭前将方向复原
     */
    if (!_isPortrait) {
        [self ForcePortrait];
        [self.navigationController popViewControllerAnimated:NO];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)addAction{
    
    ChangeClassTimeView *timeView = [[ChangeClassTimeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT)
                                                                      WithBtn:nil];
    [self.view addSubview:timeView];
    
}

- (void)gotoEditVC{
    
    EditClassViewController *editVC = [[EditClassViewController alloc]init];
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void)forceRotation
{
    if (_isPortrait) {
        _isPortrait = NO;
        [self ForceLandscapeLeft];
    } else {
        _isPortrait = YES;
        [self ForcePortrait];
        
    }
}

/// 强制左横屏
- (void)ForceLandscapeLeft
{
    [(YQBaseNavigationController *)self.navigationController changeSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscapeLeft];
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeLeft;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

/// 强制竖屏
- (void)ForcePortrait
{
    [(YQBaseNavigationController *)self.navigationController changeSupportedInterfaceOrientations:UIInterfaceOrientationMaskPortrait];
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
