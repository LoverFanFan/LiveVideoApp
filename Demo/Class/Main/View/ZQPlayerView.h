//
//  ZQPlayerView.h
//  Demo
//
//  Created by Mopon on 16/5/11.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^backHandle)();
typedef void(^screenHandle)();

@interface ZQPlayerView : UIView

-(void)play;

-(instancetype)initWithFrame:(CGRect)frame videoURL:(NSString *)video_url;

-(void)didClickedbackBtnHandle:(backHandle)hadle;

@end
