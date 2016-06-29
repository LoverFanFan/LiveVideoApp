//
//  ZQPlayerView.m
//  Demo
//
//  Created by Mopon on 16/5/11.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "ZQPlayerView.h"

@interface ZQPlayerView ()

@property (nonatomic ,strong)AVPlayer *player;

@property (nonatomic ,strong)AVPlayerItem *playerItem;

@property (nonatomic ,strong)AVPlayerLayer *playerLayer;

@property (nonatomic ,strong)NSString *video_url;

/**
 *  全屏按钮
 */
@property (nonatomic ,strong)UIButton *fullScreenBtn;

/**
 *  返回按钮
 */
@property (nonatomic ,strong)UIButton *backbtn;

@property (nonatomic ,copy)backHandle backHandle;

@end

@implementation ZQPlayerView


-(instancetype)initWithFrame:(CGRect)frame videoURL:(NSString *)video_url{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.video_url = video_url;
        
        [self setUpSubViews];
    }
    
    return self;
}

#pragma mark - 初始化子控件
-(void)setUpSubViews{
    
//    单击手势
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    singleTap.numberOfTapsRequired = 1; // 单击
    [self addGestureRecognizer:singleTap];
    
    [self setPlayer];
    
    _fullScreenBtn = [[UIButton alloc]init];
    [_fullScreenBtn setShowsTouchWhenHighlighted:YES];
    [self addSubview:_fullScreenBtn];
    UIImage *fullScreenImg = [UIImage imageNamed:@"movie_fullscreen"];
    [_fullScreenBtn setImage:fullScreenImg forState:UIControlStateNormal];
    [_fullScreenBtn addTarget:self action:@selector(fullScreenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _backbtn = [[UIButton alloc]init];
    [_backbtn setShowsTouchWhenHighlighted:YES];
    [self addSubview:_backbtn];
    UIImage *backImg = [UIImage imageNamed:@"movie_back"];
    UIImage *backSelectImg = [UIImage imageNamed:@"movie_back_s"];
    [_backbtn setImage:backImg forState:UIControlStateNormal];
    [_backbtn setImage:backSelectImg forState:UIControlStateHighlighted];
    [_backbtn addTarget:self action:@selector(backbtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self layoutSubview];
}

-(void)didClickedbackBtnHandle:(backHandle)hadle{

    self.backHandle = [hadle copy];
}

#pragma mark - 全屏按钮
-(void)fullScreenBtnClick{

}

#pragma mark - 返回按钮
-(void)backbtnClick{

    if (_backHandle) {
        _backHandle();
        _backHandle = nil;
    }
}

-(void)layoutSubview{
    
    [_fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_fullScreenBtn.currentImage.size.width, _fullScreenBtn.currentImage.size.height));
        make.right.mas_equalTo(self.mas_right).offset(-5);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
    }];
    
    [_backbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_backbtn.currentImage.size.width, _backbtn.currentImage.size.height));
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(self.mas_top).offset(20);
    }];

}

#pragma mark - 初始化播放器
-(void)setPlayer{

    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.video_url]];
    
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    
    self.playerLayer = (AVPlayerLayer *)self.layer;
    
    [self.playerLayer setPlayer:self.player];
}

+(Class)layerClass{
    
    return [AVPlayerLayer class];
}

-(void)play{
    
    [self.player play];
}

#pragma mark - 单击手势
-(void)handleSingleTap{

    [UIView animateWithDuration:0.5 animations:^{
        
        if (self.fullScreenBtn.alpha ==0.0) {
            
            self.fullScreenBtn.alpha = 1.0;
            self.backbtn.alpha = 1.0;
        }else{
            
            self.fullScreenBtn.alpha = 0;
            self.backbtn.alpha = 0;
        }
        
    }];
}

-(void)dealloc{

    [self.player pause];
    self.player = nil;
    self.playerItem = nil;
    self.playerLayer = nil;
}


@end
