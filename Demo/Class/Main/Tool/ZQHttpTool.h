//
//  ZQHttpTool.h
//  Demo
//
//  Created by Mopon on 16/5/10.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZQAPI.h"
@class ZQHttpTool;

//网络请求成功失败的block
typedef void (^httpRequestSuccess)(ZQHttpTool *manager,id responseObject);
typedef void (^httpRequestFailure)(ZQHttpTool *manager,NSError *error);

@interface ZQHttpTool : NSObject

+(ZQHttpTool *)shareInstance;

/**
 *  广告轮播数据
 */
-(void)getBannerDataWithSuccesed:(httpRequestSuccess)success faild:(httpRequestFailure)failure;

/**
 *  获取游戏首页
 */
-(void)getGameHomeDataWithSuccesed:(httpRequestSuccess)success
                             faild:(httpRequestFailure)failure;

/**
 *  获取游戏列表
 *
 *  @param page    页数
 *  @param success 成功返回值
 *  @param failure 失败返回值
 */
- (void)getGameDataLisetWithPage:(NSInteger)page
                       Successed:(httpRequestSuccess)success
                           Faile:(httpRequestFailure)failure;

/**
 *  获取游戏详情
 */
-(void)getGameDetailDataWithGameID:(NSString *)gameID
                          Succesed:(httpRequestSuccess)success
                             faild:(httpRequestFailure)failure;

@end
