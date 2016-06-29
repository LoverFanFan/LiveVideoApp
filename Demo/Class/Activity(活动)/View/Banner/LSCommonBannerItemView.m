//
//  LSCommonBannerItemView.m
//  lemonshow
//
//  Created by Emma on 15/7/30.
//  Copyright (c) 2015年 lemonshow. All rights reserved.
//

#import "LSCommonBannerItemView.h"
#import "LSCommonBannerItemModel.h"
#import "UIImageView+WebCache.h"



@interface LSCommonBannerItemView ()


@property (nonatomic, strong) UIButton *itemBtn;//
@property (nonatomic, strong) LSCommonBannerItemModel *model;// item 数据


/**
 *  点击处理
 *
 *  @param sender 被点击对象
 */
- (void)touchAction:(id)sender;

@end

@implementation LSCommonBannerItemView
@synthesize itemBtn = _itemBtn;
@synthesize model = _model;
@synthesize thebannerType;
@synthesize delegate;
@synthesize bannernavigator;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


/**
 *  传入数据
 *
 *  @param itemModel model数据
 */
- (void)configItemWithData:(LSCommonBannerItemModel*)itemModel placeholderImage:(NSString*)imageName{
    if (nil == itemModel) return;
    self.model = itemModel;
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    self.itemBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_itemBtn addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
    self.itemBtn.backgroundColor=[UIColor clearColor];
    
    UIImage *placeImage = [UIImage imageNamed:imageName];
    // 需要对图片URL进行判断，可能是网络图片，也可能是本地图片
    if ([itemModel.spic hasPrefix:@"http:"] || [itemModel.spic hasPrefix:@"https:"]) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:itemModel.spic] placeholderImage:placeImage options:SDWebImageRetryFailed];
    }else{
        UIImage *localImage = [UIImage imageNamed:itemModel.spic];
        if (nil == localImage) localImage = placeImage;
        imageView.image=localImage;
    }
    
    [self addSubview:imageView];
    [self addSubview:_itemBtn];
}

/**
 *  点击处理
 *
 *  @param sender 被点击对象
 */
- (void)touchAction:(id)sender{
    if (nil == _model) return;
    
    // 根据类型来进行不同的跳转
   // if(_model.bannerType == 1){      //广告
    
//        LSWebViewController    *webController = [[LSWebViewController alloc]init];
//        webController.adURL = _model.jumpurl;
//        webController.webtitle = _model.text;
//        [self.bannernavigator pushViewController:webController animated:YES];
    //}
   // else if(_model.bannerType == 2){   //直播间列表
//    
//        ThemeController *themeController = [[ThemeController alloc]initWithCategoryName:_model.key];
//        [self.bannernavigator pushViewController:themeController animated:YES];

        
   // }
   // else if(_model.bannerType == 3){   //直播间
        
//        NSUInteger   width = RESOLUTIONWIDHT;
//        NSDictionary  *params=@{@"req_page":@(1),@"req_number":@(1),@"req_width":@(width),@"room_id":_model.key};
//        [[HttpHelper shareInstance]getLIveRoomByRoomID:params completed:^(MKNetworkOperation *completedOperation){
//            
//            NSDictionary *responseDic = completedOperation.responseJSON;
//            if([responseDic objectForKey:@"error"]){
//                
//                if([[responseDic objectForKey:@"error"]integerValue]!=0)
//                    return ;
//            }
//            if([responseDic objectForKey:@"errCode"]){
//                
//                if([[responseDic objectForKey:@"errCode"] integerValue] != 0)
//                    return;
//                
//                NSDictionary *resultDic = [responseDic objectForKey:@"results"];
//                
//                RoomModel  *roomModel = [[RoomModel alloc]init];
//                [roomModel setWithDic:resultDic];
//                
//                DirectViewController *directVC = [[DirectViewController alloc] init];
//                DirectModel  *model = [[DirectModel alloc]init];
//                [model setWithDic:resultDic];
//                
//                directVC.directModel = model;
//                directVC.roomModel = roomModel;
//                [self.bannernavigator pushViewController:directVC animated:YES];
//            }
//            
//        }error:^(MKNetworkOperation *bulletCompletedOperation, NSError *error) {
//            
//        }];
   // }
}

@end
