//
//  YQBannerController.m
//  Demo
//
//  Created by Mopon on 16/5/11.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "YQBannerController.h"

@interface YQBannerController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic ,strong)UIView *bottomView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic ,strong)UILabel *titleLabel;

@property (nonatomic, assign) CGRect frame;

@property (nonatomic ,strong)NSArray *networkImages;

@property (nonatomic ,strong)NSArray *titles;

@property (nonatomic ,assign)NSInteger imageCount;

@property (nonatomic ,assign)BOOL isNetWorkImage;

@property (nonatomic ,strong)NSTimer *timer;

/**
 *  记录当前indexPath
 */
@property (nonatomic ,strong)NSIndexPath *indexPath;

@end

@implementation YQBannerController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 初始化
-(instancetype)initWithNetWorkImages:(NSArray *)images titles:(NSArray *)titles frame:(CGRect)frame{

    self = [super init];
    if (self) {
        _networkImages = images;
        _titles = titles;
        _imageCount = images.count;
        _isNetWorkImage = YES;
        self.frame = frame;
        self.view.frame = frame;
        
        [self setupViews];
    }
    return self;
}
#pragma mark - 初始化子控件
-(void)setupViews{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    _bottomView = [UIView new];
    _bottomView.backgroundColor = [UIColor blackColor];
    _bottomView.alpha = 0.7;
    _bottomView.frame = CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 30);
    
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.numberOfPages = self.imageCount;
    _pageControl.currentPage = 0;
    [_pageControl sizeToFit];
    _pageControl.frame = CGRectMake(_bottomView.frame.size.width - _pageControl.frame.size.width-10, 0, _pageControl.frame.size.width, 30);
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.frame = CGRectMake(10, 0, _bottomView.frame.size.width - _pageControl.frame.size.width-20, 30);
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.text = [self.titles firstObject];
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.pageControl];
    [self.bottomView addSubview:_titleLabel];
    
    
    if (self.imageCount>0){
        self.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
    
}

#pragma mark - 显示
-(void)showInViewController:(UIViewController *)viewcontroller{
    [self.collectionView reloadData];
    [viewcontroller.view addSubview:self.view];
    [viewcontroller addChildViewController:self];
    
}

#pragma mark - 视图已经显示完了。添加Timer
-(void)viewDidAppear:(BOOL)animated{

    if (!_timer) {
        
        [self addTimer];
    }
}
#pragma mark - 视图已经消失 释放Timer
-(void)viewDidDisappear:(BOOL)animated{

    [self removeTimer];
}

#pragma mark 添加定时器
-(void)addTimer{
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
#pragma 删除定时器
-(void)removeTimer{
    [self.timer invalidate];
    self.timer=nil;
}

#pragma mark - 下一页
-(void)nextPage{

    if (self.imageCount) {
        
        NSIndexPath *currentIndexPath=[[_collectionView indexPathsForVisibleItems]lastObject];
        NSInteger nextItem=currentIndexPath.item+1;
        
        if (nextItem > self.imageCount -1) nextItem =0;
        
        NSIndexPath *nextIndexPath=[NSIndexPath indexPathForItem:nextItem inSection:currentIndexPath.section];
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
    
}

#pragma mark -<UICollectionViewDataSource>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.frame.size.width,self.frame.size.height);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageCount;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.networkImages[indexPath.row]]];
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.and.left.and.right.and.bottom.mas_equalTo(cell.contentView);
    }];
    cell.contentView.backgroundColor =RandomColor;
    return cell;
}
#pragma mark -<UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
}


#pragma mark - 设置页码与文字
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int page = (int)(scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.imageCount;
    
//    //偏移到最后一个视图时,设置一个视图宽度的偏移量强制回到页面刚进来后偏移后的视图(第一张图片)
//    if (page==_array.count-1) {
//        self.contentOffset=CGPointMake(self.frame.size.width, 0);
//    }
//    //当偏移量为0时强制偏移回到倒数第二个视图(最后一个图片,加小于0为了防止第一张图片向右拖没结束导致下一张拖不出来)
//    if (self.contentOffset.x<=0) {
//        self.contentOffset=CGPointMake(self.frame.size.width*(_array.count-2), 0);
//    }
    self.pageControl.currentPage=page;
    self.titleLabel.text = self.titles[page];
}

#pragma mark - 开始拖拽，移除定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self removeTimer];
}

#pragma mark - 当用户停止时 添加定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

-(NSArray *)networkImages{
    
    if (!_networkImages) {
        _networkImages = [NSMutableArray array];
    }
    return _networkImages;
}

@end
