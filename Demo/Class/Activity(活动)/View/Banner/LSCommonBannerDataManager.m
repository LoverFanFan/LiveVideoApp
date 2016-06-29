//
//  LSCommonBannerDataManager.m
//  lemonshow
//
//  Created by Emma on 15/7/30.
//  Copyright (c) 2015年 lemonshow. All rights reserved.
//

#import "LSCommonBannerDataManager.h"
#import "JSONKit.h"

#define LS_Banner_Data                  @"LS_Banner_Data"

NSMutableDictionary             *bannerDic;

@interface LSCommonBannerDataManager ()

/**
 *  获取默认的Banner数据，按照Banner类型
 *
 *  @param bannerType
 *
 *  @return 返回Banner数据：数组
 */
//+ (NSArray*)getDefaultBannerDataByType:(LS_ENUM_Banner_Type)bannerType;

@end

@implementation LSCommonBannerDataManager


/**
 *  按照类型，获取对应的Banner数据
 *
 *  @param bannerType
 *
 *  @return 返回Banner数据：数组
 */
+ (NSArray*)getBannerDataByType:(LS_ENUM_Banner_Type)bannerType{
    
    if(!bannerDic || ![bannerDic objectForKey:[NSNumber numberWithInt:bannerType]])
        return nil;
    
    NSArray    *bannerArray = [bannerDic objectForKey:[NSNumber numberWithInt:bannerType]];
    
    return bannerArray;
}



/**
 *
 // 下载banner数据：
 */
+ (void)getSuccintBannerData{
    
    if (bannerDic) {
        [bannerDic removeObjectForKey:[NSNumber numberWithInt:Banner_Type_Succint]];
    }
    if (!bannerDic) {
        bannerDic=[[NSMutableDictionary alloc]init];
    }
    
    [_ZQHttpTool getBannerDataWithSuccesed:^(ZQHttpTool *manager, id responseObject) {
        
        NSArray *data = responseObject[@"data"];
        if (data.count > 0) {
            
            [bannerDic setObject:data forKey:[NSNumber numberWithInt:Banner_Type_Succint]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loadBanner" object:nil];
        }
        
    } faild:^(ZQHttpTool *manager, NSError *error) {
        
        NSLog(@"%@",error);
    }];

}


+(void)getCategoryBannerData{
    
    if (bannerDic) {
        [bannerDic removeObjectForKey:[NSNumber numberWithInt:Banner_Type_Category]];
    }
    if (!bannerDic) {
        bannerDic=[[NSMutableDictionary alloc]init];
    }
//    NSDictionary  *param2 = @{@"display_page":@"2"};
//    [[HttpHelper shareInstance]getBannerInfoByPage:param2 compeleted:^(MKNetworkOperation *completedOperation){
//        
//        NSDictionary *responseDic = completedOperation.responseJSON;
//        
//        if([ErrorFilters justIsSuccess:responseDic]){
//            
//            NSUInteger   ncount = [[responseDic objectForKey:@"count"] integerValue];
//            if(ncount == 0)
//            {
//                [[NSNotificationCenter defaultCenter]postNotificationName:CATEGORYBANNER object:nil];
//                return;
//            }
//            
//            NSArray   *array = [responseDic objectForKey:@"info_list"];
//            [bannerDic setObject:array forKey:[NSNumber numberWithInt:Banner_Type_Category]];
//            
//            [[NSNotificationCenter defaultCenter]postNotificationName:CATEGORYBANNER object:nil];
//        }
//        
//    }error:^(MKNetworkOperation* completedOperation, NSError* error){
//        
//    }];
}

+ (void)getDiscoverBannerData{
    if (bannerDic) {
        [bannerDic removeObjectForKey:[NSNumber numberWithInt:Banner_Type_Discover]];
    }
    if (!bannerDic) {
        bannerDic=[[NSMutableDictionary alloc]init];
    }
    NSDictionary  *param3 = @{@"display_page":@"3"};
//    [[HttpHelper shareInstance]getBannerInfoByPage:param3 compeleted:^(MKNetworkOperation *completedOperation){
//        
//        NSDictionary *responseDic = completedOperation.responseJSON;
//        if([ErrorFilters justIsSuccess:responseDic]){
//           
//            NSUInteger   ncount = [[responseDic objectForKey:@"count"] integerValue];
//            if(ncount == 0)
//            {
//                [[NSNotificationCenter defaultCenter]postNotificationName:DISCOVERBANNER object:nil];
//                return;
//            }
//            NSArray   *array = [responseDic objectForKey:@"info_list"];
//            [bannerDic setObject:array forKey:[NSNumber numberWithInt:Banner_Type_Discover]];
//            
//            [[NSNotificationCenter defaultCenter]postNotificationName:DISCOVERBANNER object:nil];
//        }
//       
//    }error:^(MKNetworkOperation* completedOperation, NSError* error){
//        
//    }];
    
}

+ (void)getCommonBannerData{

//page 1用在精选页面
//page 2用在分类页面
//page 3用在发现页面
    
    if(bannerDic)
      [bannerDic removeAllObjects];
    
    if(!bannerDic){
        bannerDic = [[NSMutableDictionary alloc]init];
    }
    
//    NSDictionary *params1 = @{@"display_page":@"1"};
//    [[HttpHelper shareInstance]getBannerInfoByPage:params1 compeleted:^(MKNetworkOperation *completedOperation){
//    
//        NSDictionary *responseDic = completedOperation.responseJSON;
//        
//        if([ErrorFilters justIsSuccess:responseDic]){
//           
//            NSUInteger   ncount = [[responseDic objectForKey:@"count"] integerValue];
//            if(ncount == 0)
//            {
//                [[NSNotificationCenter defaultCenter]postNotificationName:SUCCINTBANNER object:nil];
//                return;
//            }
//            NSArray   *array = [responseDic objectForKey:@"info_list"];
//            [bannerDic setObject:array forKey:[NSNumber numberWithInt:Banner_Type_Succint]];
//            
//            [[NSNotificationCenter defaultCenter]postNotificationName:SUCCINTBANNER object:nil];
//
//        }
//    }
//    
//    error:^(MKNetworkOperation* completedOperation, NSError* error){
//        
//        
//    }];
    
//    NSDictionary  *param2 = @{@"display_page":@"2"};
//    [[HttpHelper shareInstance]getBannerInfoByPage:param2 compeleted:^(MKNetworkOperation *completedOperation){
//        
//        NSDictionary *responseDic = completedOperation.responseJSON;
//        
//        if([ErrorFilters justIsSuccess:responseDic]){
//          
//            NSUInteger   ncount = [[responseDic objectForKey:@"count"] integerValue];
//            if(ncount == 0)
//            {
//                [[NSNotificationCenter defaultCenter]postNotificationName:CATEGORYBANNER object:nil];
//                return;
//            }
//            NSArray   *array = [responseDic objectForKey:@"info_list"];
//            [bannerDic setObject:array forKey:[NSNumber numberWithInt:Banner_Type_Category]];
//            
//            [[NSNotificationCenter defaultCenter]postNotificationName:CATEGORYBANNER object:nil];
//        }
//    }
//     
//    error:^(MKNetworkOperation* completedOperation, NSError* error){
//                                                 
//                                                 
//    }];
    

//    NSDictionary  *param3 = @{@"display_page":@"3"};
//    [[HttpHelper shareInstance]getBannerInfoByPage:param3 compeleted:^(MKNetworkOperation *completedOperation){
//        
//        NSDictionary *responseDic = completedOperation.responseJSON;
//        if([ErrorFilters justIsSuccess:responseDic]){
//           
//            NSUInteger   ncount = [[responseDic objectForKey:@"count"] integerValue];
//            if(ncount == 0)
//            {
//                [[NSNotificationCenter defaultCenter]postNotificationName:DISCOVERBANNER object:nil];
//                return;
//            }
//            
//            NSArray   *array = [responseDic objectForKey:@"info_list"];
//            [bannerDic setObject:array forKey:[NSNumber numberWithInt:Banner_Type_Discover]];
//            
//            [[NSNotificationCenter defaultCenter]postNotificationName:DISCOVERBANNER object:nil];
//
//        }
//    }
//     
//    error:^(MKNetworkOperation* completedOperation, NSError* error){
//    }];


    
}


/**
 *  获取默认的Banner数据，按照Banner类型
 *
 *  @param bannerType
 *
 *  @return 返回Banner数据：数组
 */
+ (NSArray*)getDefaultBannerDataByType:(LS_ENUM_Banner_Type)bannerType{
    // 需求调整，不提供保底的banner数据
    return nil;
    
    
    // 默认的banner
//    NSDictionary *actionDic = [NSDictionary dictionaryWithObjectsAndKeys:@"loadpage", @"actiontype", @"link", @"pagetype", @"http://lemonshow.tv/", @"linkURL", @"柠檬秀", @"title", nil];
//    NSDictionary *itemDic = [NSDictionary dictionaryWithObjectsAndKeys:@"100001", @"imageid", @"defaultbanner@2x", @"imageurl", actionDic, @"action", nil];
//    NSMutableArray *bannerArr = [[NSMutableArray alloc] initWithObjects:itemDic,itemDic,itemDic,nil];
//    return bannerArr;
}

@end
