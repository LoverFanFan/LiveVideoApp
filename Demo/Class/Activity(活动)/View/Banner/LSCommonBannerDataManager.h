//
//  LSCommonBannerDataManager.h
//  lemonshow
//
//  Created by Emma on 15/7/30.
//  Copyright (c) 2015年 lemonshow. All rights reserved.
//

/**
 *  管理app中所有通用Banner数据的读取等；方便各个页面显示各自的Banner时，能根据类型直接拿到对应的数据；
    并且，当没有server数据时，直接提供默认的Banner数据；
 */

#import <Foundation/Foundation.h>

// 定义banner定型： 精选页、分类页的banner Type
typedef NS_ENUM(NSUInteger, LS_ENUM_Banner_Type)
{
    Banner_Type_Succint   = 1,    // 精选页面顶部Banner
    Banner_Type_Category  = 2,           // 分类页面Banner
    Banner_Type_Discover  = 3,
};

@interface LSCommonBannerDataManager : NSObject

/**
 *  按照类型，获取对应的Banner数据
 *
 *  @param bannerType
 *
 *  @return 返回Banner数据：数组
 */
+ (NSArray*)getBannerDataByType:(LS_ENUM_Banner_Type)bannerType;

/**
 *
 // 下载banner数据
 */
+ (void)getCommonBannerData;

///下载精选界面banner数据
+(void)getSuccintBannerData;
///下载分类界面banner数据
+(void)getCategoryBannerData;
///下载发现界面banner数据
+(void)getDiscoverBannerData;

@end
