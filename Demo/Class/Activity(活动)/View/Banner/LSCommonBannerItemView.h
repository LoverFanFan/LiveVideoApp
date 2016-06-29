//
//  LSCommonBannerItemView.h
//  lemonshow
//
//  Created by Emma on 15/7/30.
//  Copyright (c) 2015年 lemonshow. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "LSCommonBannerDataManager.h"
#import "LSCommonBannerItemModel.h"


@protocol CommonBannerViewDelegate <NSObject>
@required
// 用户关闭Banner的显示
- (void)closeBannerView;

@end



@interface LSCommonBannerItemView : UIView


@property (nonatomic,assign)    LS_ENUM_Banner_Type                        thebannerType;
@property (nonatomic,assign)    id<CommonBannerViewDelegate>               delegate;
@property (nonatomic,strong)    UINavigationController                     *bannernavigator;


- (void)configItemWithData:(LSCommonBannerItemModel*)itemModel placeholderImage:(NSString*)imageName;

@end
