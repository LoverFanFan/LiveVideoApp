//
//  YQBannerController.h
//  Demo
//
//  Created by Mopon on 16/5/11.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQBannerController : UIViewController

-(instancetype)initWithNetWorkImages:(NSArray *)images titles:(NSArray *)titles frame:(CGRect)frame;

/**
 *  显示
 *
 *  @param viewcontroller 目标控制器
 */
-(void)showInViewController:(UIViewController *)viewcontroller;

@end
