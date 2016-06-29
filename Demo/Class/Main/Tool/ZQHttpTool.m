//
//  ZQHttpTool.m
//  Demo
//
//  Created by Mopon on 16/5/10.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "ZQHttpTool.h"
//网络请求成功失败的block
typedef void (^httpRequestSuccess)(ZQHttpTool *manager,id responseObject);
typedef void (^httpRequestFailure)(ZQHttpTool *manager,NSError *error);

@implementation ZQHttpTool

+(ZQHttpTool *)shareInstance{
    
    static ZQHttpTool *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZQHttpTool alloc]init];
    });
    return manager;
}

-(AFHTTPSessionManager *)AFNManager{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    return manager;
}

-(void)getBannerDataWithSuccesed:(httpRequestSuccess)success faild:(httpRequestFailure)failure{

    [[self AFNManager] GET:BANNER_URL
                parameters:nil
                  progress:^(NSProgress * _Nonnull downloadProgress) {
                      
                      
                      
                  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      
                      success(self,responseObject);
                      
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      
                      failure(self,error);
                  }];
}

-(void)getGameHomeDataWithSuccesed:(httpRequestSuccess)success faild:(httpRequestFailure)failure{

    [[self AFNManager] GET:GAME_HOME_URL
                parameters:nil
                  progress:^(NSProgress * _Nonnull downloadProgress) {
                      
                      
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(self,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(self,error);
    }];
}

-(void)getGameDetailDataWithGameID:(NSString *)gameID Succesed:(httpRequestSuccess)success faild:(httpRequestFailure)failure{
    
    [[self AFNManager] GET:GAME_DETAIL_URL(gameID)
                parameters:nil
                  progress:^(NSProgress * _Nonnull downloadProgress) {
                      
                      
                      
                  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      
                      success(self,responseObject);
                      
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      
                      failure(self,error);
                  }];
    
}


@end
