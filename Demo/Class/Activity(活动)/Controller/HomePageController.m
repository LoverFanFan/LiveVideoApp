//
//  HomePageController.m
//  Demo
//
//  Created by Mopon on 16/5/10.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "HomePageController.h"
#import "YQBannerController.h"
#import "BannerModel.h"
#import "LSCommonBannerDataManager.h"
#import "LSCommonBannerView.h"

@interface HomePageController ()
{
    
//    LSCommonBannerView  *
}

@end

@implementation HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setBanner)
                                                 name:@"loadBanner"
                                               object:nil];
    
    [self setViewTitle:@"首页"];
    NSLog(@"");
    
    [self showBlurBar];
    
}

#pragma mark 初始化轮播广告
-(void)setBanner{
    
    
    NSArray *bannerData = [LSCommonBannerDataManager getBannerDataByType:Banner_Type_Succint];
    if(bannerData && [bannerData count] > 0){

        LSCommonBannerView *bannerView = [[LSCommonBannerView alloc] initWithFrame: CGRectMake(0, 64, SCREEN_WIDTH, 200)
                                                                        BannerData: bannerData
                                                                  DefaultImageName: nil
                                                                   ShowCloseButton: NO
                                                                              Type:Banner_Type_Succint
                                                                    bannerDelegate: self
                                                                         navigator: self.navigationController];
        [self.view addSubview:bannerView];
    }
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
