//
//  GameDetailController.m
//  Demo
//
//  Created by Mopon on 16/5/10.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "GameDetailController.h"
#import "ZQGameDetailModel.h"
#import "ZQGameDetailCell.h"
#import "ZQLiveRoomController.h"

@interface GameDetailController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)UICollectionView *collectionView;

@end

@implementation GameDetailController

static NSString * const reuseIdentifier = @"Cell";

-(NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAuthenNavi:@"游戏列表"];
    
    [self setUpViews];
    
    [self requestGameDetailData];
 
}

-(void)setUpViews{
    
    self.title = self.model.name;
    
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.minimumInteritemSpacing = 0.0;//item 之间的行的距离
    flowLayout.minimumLineSpacing = 10.0;//item 之间竖的距离
    CGFloat cellWidth = (SCREEN_WIDTH - 30)/2;
    
    flowLayout.itemSize = (CGSize){cellWidth,cellWidth/1.5 +30 +13};
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:flowLayout];
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource= self;
    
    [self.collectionView registerClass:[ZQGameDetailCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.view addSubview:self.collectionView];
    
    
}

-(void)requestGameDetailData{
    
    [_ZQHttpTool getGameDetailDataWithGameID:self.model.id Succesed:^(ZQHttpTool *manager, id responseObject) {
        
        NSMutableArray *data = responseObject[@"data"][@"rooms"];
        
        [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            ZQGameDetailModel *model = [ZQGameDetailModel mj_objectWithKeyValues:obj];
            
            [self.dataSource addObject:model];
        }];
        [self.collectionView reloadData];
        
    } faild:^(ZQHttpTool *manager, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZQGameDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell fillCellWithZQGameDetailModel:self.dataSource[indexPath.row]];
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    ZQGameDetailModel *model = self.dataSource[indexPath.row];
    ZQLiveRoomController *live = [[ZQLiveRoomController alloc]init];
    live.vid = model.videoId;
    [self.navigationController pushViewController:live animated:YES];
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

@end
