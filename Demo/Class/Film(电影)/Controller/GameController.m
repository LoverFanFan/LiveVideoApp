//
//  GameController.m
//  Demo
//
//  Created by Mopon on 16/5/10.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "GameController.h"
#import "ZQGameModel.h"
#import "ZQGameCell.h"
#import "GameDetailController.h"

@interface GameController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)UICollectionView *collectionView;

@end

@implementation GameController
{
    BOOL                    _isLive;
    NSInteger               _page;
    CGFloat                 _receiveAlpha;
    UIImageView             *_topImageView;
}

-(NSMutableArray *)dataSource{

    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setViewTitle:@"游戏"];
    
    [self showBlurBar];
    
    [self createScaleHeadView];
    
    [self setUpViews];
    
    [self loadData:@(ReloadDiretionFirst)];
    
}

- (void)initRawData{
    
    _isLive = YES;
}

#pragma mark - 创建缩放头像视图
- (void)createScaleHeadView
{
    UIView * topBkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 78, 44)];
    topBkView.backgroundColor = [UIColor clearColor];
    topBkView.centerX = SCREEN_WIDTH/2;
    topBkView.top     = 20;
    
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 78, 78)];
    _topImageView.backgroundColor = [UIColor whiteColor];
    _topImageView.layer.cornerRadius = _topImageView.bounds.size.width / 2.;
    _topImageView.layer.masksToBounds = YES;
    _topImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _topImageView.image = [UIImage imageNamed:@"head"];
    [topBkView addSubview:_topImageView];
    
//    self.navigationItem.titleView = topBkView;
    [self.navBarBackView addSubview: topBkView];
}

#pragma mark - 初始化各个view
-(void)setUpViews{
    

    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.minimumInteritemSpacing = 0.0;//item 之间的行的距离
    flowLayout.minimumLineSpacing = 10.0;//item 之间竖的距离
    CGFloat cellWidth = (SCREEN_WIDTH - 40)/3;
    
    flowLayout.itemSize = (CGSize){cellWidth,cellWidth+50};
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-44) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.clipsToBounds   = NO;
    [self.collectionView registerClass:[ZQGameCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    [self.view sendSubviewToBack:self.collectionView];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData:@(ReloadDiretionFirst)];
        
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadData:@(ReloadDiretionTop)];
    }];
    
}

#pragma mark - 请求数据
- (void)loadData:(NSNumber *)diretion {
    
    
    switch ([diretion integerValue]) {
        case ReloadDiretionFirst:{      ///重新获取数据
            _page = 1;
            [self.dataSource removeAllObjects];
            [self.collectionView.mj_footer resetNoMoreData];///重置上拉加载
        }
            break;
        case ReloadDiretionDown:
            _page = 1;
            break;
        case ReloadDiretionTop:{///上拉加载如果上次没有获取到数据就不要再加加了
        }
            break;
        default:
            break;
    }
    
    [_ZQHttpTool getGameDataLisetWithPage:_page Successed:^(ZQHttpTool *manager, id responseObject) {
        
        NSMutableArray *arr = responseObject[@"data"][@"games"];
        
        if (arr.count > 0) {
            _page ++;
        }else{
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }

        [arr enumerateObjectsUsingBlock:^(NSDictionary *  obj, NSUInteger idx, BOOL * _Nonnull stop) {

            ZQGameModel *model = [ZQGameModel mj_objectWithKeyValues:obj];

            [self.dataSource addObject:model];
        }];

        [self.collectionView reloadData];

        //关闭刷新界面
        if (self.collectionView.mj_header && [self.collectionView.mj_header isRefreshing]) {
            [self.collectionView.mj_header endRefreshing];
        }
        if (self.collectionView.mj_footer && [self.collectionView.mj_footer isRefreshing]) {
            [self.collectionView.mj_footer endRefreshing];
        }
    } Faile:^(ZQHttpTool *manager, NSError *error) {
        
        NSLog(@"%@",error);
        //关闭刷新界面
        if (self.collectionView.mj_header && [self.collectionView.mj_header isRefreshing]) {
            [self.collectionView.mj_header endRefreshing];
        }
        if (self.collectionView.mj_footer && [self.collectionView.mj_footer isRefreshing]) {
            [self.collectionView.mj_footer endRefreshing];
        }
    }];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZQGameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    [cell fillCellWithZQGameModel:self.dataSource[indexPath.row]];
    cell.contentView.backgroundColor = RandomColor;
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataSource.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(10, 10, 10, 10);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    GameDetailController *detail = [[GameDetailController alloc]init];
    detail.model = self.dataSource[indexPath.row];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    
}

#pragma mark - 滑动代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y + self.collectionView.contentInset.top;//注意
    
    /**
     *  1 - offsetY/num1 = 0.45;
     0.45 为最终缩小倍率
     offsetY 为纵偏移量
     num1=300 为要计算的值
     150/165  就是滑动多少距离后，完成缩放
     */
    
    if (offsetY < 0 && offsetY >= -150) {
        _topImageView.transform = CGAffineTransformMakeScale(1 + offsetY/(-300), 1 + offsetY/(-300));

    }
    else if (offsetY >= 0 && offsetY <= 165) {
        _topImageView.transform = CGAffineTransformMakeScale(1 - offsetY/300, 1 - offsetY/300);
    }
    else if (offsetY > 165) {
        _topImageView.transform = CGAffineTransformMakeScale(0.45, 0.45);
    }
    else if (offsetY < -150) {
        _topImageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    }
    
    CGRect frame = _topImageView.frame;
    frame.origin.y = 5;
    _topImageView.frame = frame;
}

@end


