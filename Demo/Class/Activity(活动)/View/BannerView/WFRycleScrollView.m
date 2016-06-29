//
//  WFRycleScrollView.m
//  RecysolScrollView
//
//  Created by keen on 14-11-1.
//  Copyright (c) 2014年 Keen. All rights reserved.
//

#import "WFRycleScrollView.h"
#import "UIImageView+WebCache.h"
@implementation WFRycleScrollView
{
    NSTimer        *_timer;
    NSMutableArray *_imageArray;
    UIPageControl  *_pageControl;
    NSInteger      _currentPage;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate=self;
        _currentPage = 0;
    }
    return self;
}

-(id)init{
    self=[super init];
    if (self!=nil) {
        self.delegate=self;
    }
    return self;
}

- (void)addTimer{
    

    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:2.0 target:self
                                       selector:@selector(moveImage)
                                       userInfo:nil
                                        repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

-(void)removeTimer{
    
    [_timer invalidate];
    _timer=nil;
}


-(void)setScrollViewWithUrlArray:(NSMutableArray *)array{
    
    _imageArray = array;
    NSMutableArray *newArray=[NSMutableArray array];
    [newArray addObjectsFromArray:array];
    //从旧数组中取出最后一个插入到新数组中得第一个
    [newArray insertObject:[array lastObject] atIndex:0];
    //从旧数组中取出第一个添加到新数组的末尾
    [newArray addObject:[array firstObject]];
    _array=newArray;
    for (int i=0; i<newArray.count; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height)];
        imageView.backgroundColor = [UIColor lightGrayColor];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[newArray objectAtIndex:i]]];
        [self addSubview:imageView];

    }
    //刚进来偏移一下,出现第一张图片
    [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:YES];
    //内容大小
    self.contentSize=CGSizeMake(self.frame.size.width*newArray.count, self.frame.size.height);
    //分页
    self.pagingEnabled=YES;
    [self preparePageControll];
}

- (void)preparePageControll{
    
    if (_imageArray.count >= 2) {
        if (!_pageControl) {
            _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
            _pageControl.bottom = self.height;
            _pageControl.enabled = NO;
            _pageControl.backgroundColor = [UIColor orangeColor];
            _pageControl.numberOfPages = _imageArray.count;
            _pageControl.pageIndicatorTintColor = [UIColor redColor];
            _pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
            [self addSubview:_pageControl];
            [self bringSubviewToFront:_pageControl];
            
        }
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page=self.contentOffset.x/self.frame.size.width;
    //偏移到最后一个视图时,设置一个视图宽度的偏移量强制回到页面刚进来后偏移后的视图(第一张图片)
    if (page==_array.count-1) {
        self.contentOffset=CGPointMake(self.frame.size.width, 0);
    }
    //当偏移量为0时强制偏移回到倒数第二个视图(最后一个图片,加小于0为了防止第一张图片向右拖没结束导致下一张拖不出来)
    if (self.contentOffset.x<=0) {
        self.contentOffset=CGPointMake(self.frame.size.width*(_array.count-2), 0);
    }

//    //        DLog(@"page = %d", page);
//    _currentPage = page;
//    
//    if (_currentPage >= _imageArray.count) {
//        _currentPage = 0;
//    }
//    [_pageControl setCurrentPage:_currentPage];
}

- (void)moveImage{
    
    if (_imageArray && _imageArray.count != 0) {
        
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
