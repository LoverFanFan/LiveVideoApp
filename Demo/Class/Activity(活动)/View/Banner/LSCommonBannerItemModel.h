//
//  LSCommonBannerItemModel.h
//  lemonshow
//
//  Created by Emma on 15/7/30.
//  Copyright (c) 2015年 lemonshow. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface LSCommonBannerItemModel : NSObject

//@property (nonatomic,assign)    NSUInteger               bannerID;
//@property (nonatomic,assign)    NSUInteger               bannerType;  //1:广告；2:直播间列表；3:直播间
//@property (nonatomic,copy)      NSString                 *imageurl;   //图片链接
//@property (nonatomic,copy)      NSString                 *jumpurl;    //跳转链接
//@property (nonatomic,copy)      NSString                 *text;       //推送内容描述
//@property (nonatomic,assign)    BOOL                     is_ext_url;   //是否是外部链接
//@property (nonatomic,copy)      NSString                 *key;         //调用二次接口需要的参数（直播间列表：分类名称 直播间：直播间ID）
//
//- (void)fillModelWithDict:(NSDictionary *)dict;


@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *position;

@property (nonatomic, copy) NSString *gameId;

@property (nonatomic, copy) NSString *positionType;

@property (nonatomic, copy) NSString *bpic;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *chnId;

@property (nonatomic, copy) NSString *roomId;

@property (nonatomic, copy) NSString *spic;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, copy) NSString *contents;

@property (nonatomic, copy) NSString *startTime;

@property (nonatomic, copy) NSString *matchId;

@end
