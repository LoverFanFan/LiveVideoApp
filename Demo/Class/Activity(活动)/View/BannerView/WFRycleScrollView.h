//
//  WFRycleScrollView.h
//  RecysolScrollView
//
//  Created by keen on 14-11-1.
//  Copyright (c) 2014年 Keen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFRycleScrollView : UIScrollView<UIScrollViewDelegate>
@property(nonatomic,strong) NSMutableArray *array;
-(void)setScrollViewWithUrlArray:(NSMutableArray *)array;
@end
