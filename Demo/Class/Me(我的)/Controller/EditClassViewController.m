//
//  EditClassViewController.m
//  Demo
//
//  Created by 吴启凡 on 16/6/23.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "EditClassViewController.h"

@interface EditClassViewController ()
{
    UIImageView              *_bgImageView;
    NSDictionary             *_weekDic;
    
}

@end

@implementation EditClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)initData{
    
    _weekDic = @{@"星期一":@"1",@"星期二":@"2",@"星期三":@"3",@"星期四":@"4",@"星期五":@"5",@"星期六":@"6",@"星期日":@"7"};
    
    
}

- (void)initBgScrollView{
    
    
    
}


- (void)createWeekLabel{
    
    
    for (NSInteger i=0; i<_weekDic.count; i++) {
        
        UILabel *weekLab = [[UILabel alloc]init];
        weekLab.frame = CGRectMake(kTheme_Weekday_StartPositionX + (i-1) * (kTheme_Weekday_Width + kTheme_Weekday_Interval),
                                   kTheme_Weekday_StartPositionY,
                                   kTheme_Weekday_Width,
                                   kTheme_Weekday_Height);
        
        
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
