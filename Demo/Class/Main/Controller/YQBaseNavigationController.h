//
//  YQBaseNavigationController.h
//  Demo
//
//  Created by Mopon on 16/4/29.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQBaseNavigationController : UINavigationController

/**
 *  改变支持的旋转方向
 *
 *  @param interfaceOrientation 支持的旋转方向
 */
- (void)changeSupportedInterfaceOrientations:(UIInterfaceOrientationMask)interfaceOrientation;

@end
