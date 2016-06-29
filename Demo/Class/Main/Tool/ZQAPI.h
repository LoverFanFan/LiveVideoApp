//
//  ZQAPI.h
//  Demo
//
//  Created by Mopon on 16/5/10.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#ifndef ZQAPI_h
#define ZQAPI_h


#endif /* ZQAPI_h */
//游戏首页
#define GAME_HOME_URL @"http://www.zhanqi.tv/api/static/game.lists/16-1.json"
//游戏详情
#define GAME_DETAIL_URL(gameID) [NSString stringWithFormat:@"http://www.zhanqi.tv/api/static/game.lives/%@/20-1.json",gameID]
//直播地址
#define LIVE_URL @"http://dlhls.cdn.zhanqi.tv/zqlive/"

//首页广告地址
#define BANNER_URL @"http://www.zhanqi.tv/api/touch/apps.banner?rand=1462938023665"