//
//  YQBaseViewController.h
//  Demo
//
//  Created by Mopon on 16/4/29.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQBaseViewController : UIViewController

@property(nonatomic,strong) UIView             *statusView;
@property(nonatomic,strong) CALayer            *statusLayer;
@property(nonatomic,assign) float              statusHeight;
@property(nonatomic,strong) UIView             *navBar;
@property(nonatomic,strong) CATextLayer        *navTextLayer;
@property(nonatomic,strong) UIVisualEffectView *navBarEffectView;
@property(nonatomic,strong) UIView             *navBarBackView;


- (UIButton *)navButtonWithFrame:(CGRect)frame Title:(NSString *)title;
- (UIButton *)navButtonWithFrameAndImage:(CGRect)frame image:(NSString *)image;
- (UIButton *)navButtonWithFrame:(CGRect)frame Title:(NSString *)title withImage:(NSString *)image;
- (void)setViewTitle:(NSString *)aTitle;
- (void)initAuthenNavi:(NSString *)title;
- (void)showBlurBar;
- (void)hiddenBlurBar;

@end
