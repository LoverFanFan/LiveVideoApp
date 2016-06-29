//
//  LSCommonBannerView.m
//  lemonshow
//
//  Created by Emma on 15/7/30.
//  Copyright (c) 2015年 lemonshow. All rights reserved.
//

#import "LSCommonBannerView.h"
#import "LSCommonBannerItemModel.h"
#import "LSCommonBannerItemView.h"

@interface LSCommonBannerView ()

@property (nonatomic, strong) NSArray                   *itemsArr;
@property (nonatomic, copy) NSString                    *defaultImage;
@property (nonatomic, strong) UIScrollView              *myScrollView;
@property (nonatomic, strong) UIPageControl             *pageControl;
@property (nonatomic, assign) NSInteger                 curPageNum;
@property (nonatomic, strong) NSTimer                   *timer;
@property (nonatomic, assign) NSInteger                 pageCountForPageContr;// 实际广告个数
@property (nonatomic, assign) NSInteger                 curPageIndexForScroll;// 滚动条上的当前页数
@property (nonatomic) LS_ENUM_Banner_Type               thebannerType;
@property (nonatomic, strong) UINavigationController    *bannerNavigator;



- (void)configBannerViewWithData:(NSArray*)items;

- (void)prepareScrollView;

- (void)assemblyItemArr;

- (void)createImageItems;

- (void)preparePageControll;

- (void)setPageControlCurPageNum:(NSInteger)curPageNum;

- (void)autoSetNextPageNum;

- (void)startTimer;

- (void)cancelTimer;

- (void)createCloseButton;

- (void)closeAction:(id)sender;

@end


@implementation LSCommonBannerView
@synthesize delegate = _delegate;
@synthesize itemsArr = _itemsArr;
@synthesize defaultImage = _defaultImage;
@synthesize myScrollView = _myScrollView;
@synthesize pageControl = _pageControl;
@synthesize curPageNum = _curPageNum;
@synthesize timer = _timer;
@synthesize pageCountForPageContr = _pageCountForPageContr;
@synthesize curPageIndexForScroll = _curPageIndexForScroll;
@synthesize thebannerType;
@synthesize bannerNavigator;

/**
 *  初始化Banner view
 *
 *  @param frame            view大小
 *  @param items            banner数据
 *  @param defaultImageName 广告图片数据下载中时，默认显示的图片
 *  @param closeButFlag     是否需要显示右侧关闭按钮
 *
 *  @return 对象
 */
- (id)initWithFrame:(CGRect)frame BannerData:(NSArray*)items DefaultImageName:(NSString*)defaultImageName ShowCloseButton:(BOOL)closeButFlag Type:(LS_ENUM_Banner_Type)bannerType bannerDelegate:(id)bannerDelegate navigator:(UINavigationController *)navigator{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = frame;
        self.delegate = bannerDelegate;
        self.curPageNum = 0;
        self.backgroundColor = [UIColor clearColor];
        self.thebannerType = bannerType;
        self.bannerNavigator = navigator;
        
        self.defaultImage = defaultImageName;
        [self configBannerViewWithData:items];
        
        // 创建关闭按钮
        if (closeButFlag) {
            [self createCloseButton];
        }
    }
    return self;
}

/**
 *  更新banner数据
 *
 *  @param items banner数据
 */
- (void)configBannerViewWithData:(NSArray*)items{
    self.itemsArr = items;
    
    self.pageCountForPageContr = [items count];
    if (_curPageNum >= _pageCountForPageContr) _curPageNum = 0;
    
    
    // 为了循环，组装数组
    [self assemblyItemArr];
    if ([_itemsArr count] == [items count]) {// 只有一个广告，不需要循环滚动
        self.curPageIndexForScroll = _curPageNum;
    }else{
        self.curPageIndexForScroll = _curPageNum + 1;
    }
    
    [self prepareScrollView];
    [self createImageItems];
    [self preparePageControll];
    // TODO：添加右侧关闭按钮
    
    [self startTimer];
}

/**
 *  创建滚动条
 */
- (void)prepareScrollView{
    if (nil == _myScrollView) {
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake( 0, 0, self.frame.size.width, self.frame.size.height)];
        _myScrollView.delegate = (id)self;
        [_myScrollView setContentSize:CGSizeMake(self.frame.size.width * ([_itemsArr count]), 0)];
        _myScrollView.contentOffset = CGPointMake(self.frame.size.width * _curPageIndexForScroll, 0);
        [_myScrollView setShowsHorizontalScrollIndicator:NO];
        [_myScrollView setShowsVerticalScrollIndicator:NO];
        [_myScrollView setBounces:NO];
        [_myScrollView setPagingEnabled:YES];
        _myScrollView.scrollsToTop = NO;
        
        [self addSubview:_myScrollView];
    }
}

/**
 *  为了实现循环滚动效果，需要在数据第0位置插入最后一个数据，在最后一个位置插入第0个数据
 */
- (void)assemblyItemArr{
    if ([_itemsArr count] <= 1) return;
    
    NSMutableArray *tempArray=[NSMutableArray arrayWithArray:_itemsArr];
    [tempArray insertObject:[_itemsArr objectAtIndex:([_itemsArr count]-1)] atIndex:0];
    [tempArray addObject:[_itemsArr objectAtIndex:0]];
    self.itemsArr = tempArray;
}

/**
 *  创建图片广告运营位
 */
- (void)createImageItems{
    for(int i = 0; i<[_itemsArr count]; i++){
        
        
        NSArray *data = [_itemsArr objectAtIndex:i];
        LSCommonBannerItemModel *model = [LSCommonBannerItemModel mj_objectWithKeyValues:data];
        LSCommonBannerItemView *item = [[LSCommonBannerItemView alloc] initWithFrame:CGRectMake(0 + i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        item.thebannerType = thebannerType;
        item.delegate = self.delegate;
        item.bannernavigator = self.bannerNavigator;
        [item configItemWithData:model placeholderImage:self.defaultImage];
        [_myScrollView addSubview:item];
    }
}


/**
 *  创建page controll
 */
- (void)preparePageControll{
    if ([_itemsArr count] < 2) return;
    
    if (nil == _pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 12, self.frame.size.width, 10)];
        _pageControl.enabled = NO;
        _pageControl.numberOfPages = _pageCountForPageContr;
        
        [_pageControl setPageIndicatorTintColor:[UIColor redColor]];
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
        
        [_pageControl setCurrentPage:_curPageNum];
        
        [self addSubview:_pageControl];
    }
}

/**
 *  手动设置page controll的当前页面
 *
 *  @param curPageNum 当前页面
 */
- (void)setPageControlCurPageNum:(NSInteger)curPageNum{

    [_pageControl setCurrentPage:curPageNum];
}

/**
 *  自动设置下一页
 */
- (void)autoSetNextPageNum{
    
    // scrollview正在滚动中时，不自动换页
    if (_myScrollView.dragging || _myScrollView.decelerating) return;
    
    if (_curPageNum + 1 < _pageCountForPageContr) {
        _curPageNum += 1;
    }else {
        _curPageNum = 0;
    }
    [self setPageControlCurPageNum:_curPageNum];
    
    
    
    if (_curPageIndexForScroll + 1 < [_itemsArr count]) {
        [_myScrollView setContentOffset:CGPointMake(self.frame.size.width * (_curPageIndexForScroll + 1), 0) animated:YES];
    }else{
        [_myScrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    }
    
}

/**
 *  开启timer
 */
- (void)startTimer{
    if ([_itemsArr count] < 2 || _timer) return;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoSetNextPageNum) userInfo:nil repeats:YES];
}

/**
 *  取消timer
 */
- (void)cancelTimer{
    if(_timer){
        [_timer invalidate];
        _timer = nil;
    }
}

/**
 *  创建关闭按钮
 */
- (void)createCloseButton{
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-35, self.frame.size.height/2-40, 30, 30)];
    // TODO：替换图片
    [closeBtn setImage:[UIImage imageNamed:@"closeBtnIcon.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.showsTouchWhenHighlighted = YES;

    [self addSubview:closeBtn];
}
/**
 *  关闭按钮被点击
 *
 *  @param sender 按钮
 */
- (void)closeAction:(id)sender{
    // 取消timer
    [self cancelTimer];
    
    // 通知调用方
    if (_delegate && [_delegate respondsToSelector:@selector(closeBannerView)]){
        [_delegate closeBannerView];
    }
}

///////////////////////////////////////////////////////////////////////////////////////
#pragma mark - scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (_myScrollView == scrollView) {
        
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        //        DLog(@"page = %d", page);
        self.curPageIndexForScroll = page;
        
        _curPageNum = (page-1);
        if (_curPageNum >= _pageCountForPageContr) {
            _curPageNum = 0;
        }
        [self setPageControlCurPageNum:_curPageNum];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (_curPageIndexForScroll == 0) [scrollView setContentOffset:CGPointMake(([_itemsArr count]-2)*self.frame.size.width, 0)];
    if (_curPageIndexForScroll == ([_itemsArr count]-1)) [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (_curPageIndexForScroll == 0) [scrollView setContentOffset:CGPointMake(([_itemsArr count]-2)*self.frame.size.width, 0)];
    if (_curPageIndexForScroll == ([_itemsArr count]-1)) [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 用户手动滑动时，停止计时器
    [self cancelTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    // 用户手动滑动停止时，打开计时器
    [self startTimer];
}



@end
