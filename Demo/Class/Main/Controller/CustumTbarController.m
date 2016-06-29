//
//  CustumTbarController.m
//  Demo
//
//  Created by Mopon on 16/4/29.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "CustumTbarController.h"
#import "HomePageController.h"
#import "LiveController.h"
#import "GameController.h"
#import "MeController.h"

@interface CustumTbarController ()

@property (nonatomic ,strong)HomePageController *home;

@property (nonatomic ,strong)LiveController *live;

@property (nonatomic ,strong)GameController *game;

@property (nonatomic ,strong)MeController *me;

@end

@implementation CustumTbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllChildVcs];
    
}

//创建自定义tabbar

- (void)addAllChildVcs {
    
    HomePageController *home = [[HomePageController alloc]init];
    [self addChildVC:home title:@"首页" imageName:@"tabbar_home" selectImageName:@"tabbar_home_sel"];
    _home = home;
    
    LiveController *live = [[LiveController alloc]init];
    [self addChildVC:live title:@"直播" imageName:@"tabbar_room" selectImageName:@"tabbar_room_sel"];
    _live = live;
    
    GameController *game = [[GameController alloc]init];
    [self addChildVC:game title:@"游戏" imageName:@"tabbar_game" selectImageName:@"tabbar_game_sel"];
    _game = game;
    
     MeController *me = [[MeController alloc]init];
    [self addChildVC:me title:@"我的" imageName:@"tabbar_me" selectImageName:@"tabbar_me_sel"];
    _me = me;
    
}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中图标
 */
-(void)addChildVC:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectedImageName{
    
    childVc.title = title;
    childVc.view.backgroundColor = [UIColor whiteColor];
    
    //    设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    //    设置选中图标
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
    //设置选中图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    childVc.tabBarItem.selectedImage = selectedImage;
    
    YQBaseNavigationController *nav = [[YQBaseNavigationController alloc]initWithRootViewController:childVc];
    
    
    UIColor *titleNomalColor = [UIColor lightGrayColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleNomalColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    
    UIColor *titleHighlightedColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    [self addChildViewController:nav];
    
}


@end
