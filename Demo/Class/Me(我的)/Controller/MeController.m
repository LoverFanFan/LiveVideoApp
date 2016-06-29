//
//  MeController.m
//  Demo
//
//  Created by Mopon on 16/4/29.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "MeController.h"
#import "ClassViewController.h"
#import "CoolNavi.h"


static CGFloat const kHeaderHeight = 205.0f;


@interface MeController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton       *_headBtn;
    UIImageView    *_bgImageView;
}


@end

@implementation MeController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self createTableView];
    [self initNav];
    [self initBgImageView];
}

- (void)initBgImageView{
    
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _bgImageView.image = [UIImage imageNamed:@"bg.jpeg"];
    [self.view addSubview:_bgImageView];
    [self.view sendSubviewToBack:_bgImageView];
}

- (void)initNav{
    
    self.navBar.backgroundColor      = [UIColor clearColor];
    self.statusLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.statusView.backgroundColor  = [UIColor clearColor];
    
    
}

- (void)createTableView{
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
//    
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
//    self.tableView.tableHeaderView = headerView;
//    headerView.backgroundColor = [UIColor clearColor];
//    
//    _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _headBtn.frame = CGRectMake(0, 0, 80, 80);
//    _headBtn.layer.cornerRadius = 40;
//    _headBtn.centerX = headerView.width/2;
//    _headBtn.centerY = headerView.height/2;
//    _headBtn.backgroundColor = [UIColor cyanColor];
//    [headerView addSubview:_headBtn];
    
    CoolNavi *headerView = [[CoolNavi alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeaderHeight)
                                           backGroudImage:@"background"
                                           headerImageURL:@"http://d.hiphotos.baidu.com/image/pic/item/0ff41bd5ad6eddc4f263b0fc3adbb6fd52663334.jpg"
                                                    title:@"幺妹"
                                                 subTitle:@"谁的青春不迷茫!"];
    headerView.scrollView = self.tableView;
    headerView.imgActionBlock = ^(){
        NSLog(@"headerImageAction");
    };
    [self.view addSubview:headerView];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [self.view addSubview:_tableView];
        [self.view sendSubviewToBack:_tableView];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"test %ld",(long)indexPath.row];
    return cell;
}

- (void)createClassTable{

    ClassViewController *classVC = [[ClassViewController alloc]init];
    [self.navigationController pushViewController:classVC animated:YES];

}

#pragma mark - 

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
////    NSLog(@"tableView 滑动");
//    
//    CGFloat offSetY = scrollView.contentOffset.y;
//    
//    if (offSetY >= 136.0) {
//        self.navBar.backgroundColor      = [UIColor orangeColor];
//        self.statusLayer.backgroundColor = [UIColor orangeColor].CGColor;
//        self.statusView.backgroundColor  = [UIColor orangeColor];
//        [self showBlurBar];
//    }
//    else if (offSetY < 136.0){
//        
//        self.navBar.backgroundColor      = [UIColor clearColor];
//        self.statusLayer.backgroundColor = [UIColor clearColor].CGColor;
//        self.statusView.backgroundColor  = [UIColor clearColor];
//        [self hiddenBlurBar];
//    }
//    
//    if (offSetY < 0 ) {
//        _headBtn.transform = CGAffineTransformMakeScale(1 + offSetY/(-400), 1 + offSetY/(-400));
//        _bgImageView.transform = CGAffineTransformMakeScale(1 + offSetY/(-300), 1 + offSetY/(-300));
//    }
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
