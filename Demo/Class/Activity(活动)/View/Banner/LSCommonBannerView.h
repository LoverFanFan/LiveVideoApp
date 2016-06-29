//
//  LSCommonBannerView.h
//  lemonshow
//
//  Created by Emma on 15/7/30.
//  Copyright (c) 2015年 lemonshow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSCommonBannerItemView.h"
#import "LSCommonBannerDataManager.h"

@interface LSCommonBannerView : UITableViewCell

@property(nonatomic,assign) id<CommonBannerViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame BannerData:(NSArray*)items DefaultImageName:(NSString*)defaultImageName ShowCloseButton:(BOOL)closeButFlag Type:(LS_ENUM_Banner_Type)bannerType bannerDelegate:(id)bannerDelegate navigator:(UINavigationController *)navigator;


@end
