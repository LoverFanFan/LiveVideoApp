//
//  ZQGameDetailCell.m
//  Demo
//
//  Created by Mopon on 16/5/10.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "ZQGameDetailCell.h"

#define ITEM_WIDTH (SCREEN_WIDTH -30)/2
#define IMAGE_HEIGHT (SCREEN_WIDTH -30)/2/1.5

@interface ZQGameDetailCell ()

@property (nonatomic ,strong)UIImageView *imageView;

@property (nonatomic ,strong)UILabel *titleLabel;

@property (nonatomic ,strong)UIImageView *sexImageView;

@property (nonatomic ,strong)UILabel *authorLabel;

@property (nonatomic ,strong)UIImageView *peopleImageView;

@property (nonatomic ,strong)UILabel *peoplesLabel;

@end

@implementation ZQGameDetailCell

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpSubViews];
    }
    return self;
}

-(void)setUpSubViews{

    self.imageView = [[UIImageView alloc]init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self.contentView addSubview:self.imageView];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = DEFAULT_FONT(14);
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.sexImageView = [[UIImageView alloc]init];
    self.sexImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.sexImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.sexImageView];
    
    
    self.authorLabel = [[UILabel alloc]init];
    self.authorLabel.textColor = [UIColor lightGrayColor];
    self.authorLabel.font = DEFAULT_FONT(12);
    self.authorLabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.authorLabel];
    
    self.peoplesLabel = [[UILabel alloc]init];
    self.peoplesLabel.textColor = [UIColor lightGrayColor];
    self.peoplesLabel.font = DEFAULT_FONT(12);
    self.peoplesLabel.backgroundColor = [UIColor whiteColor];
    self.peoplesLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.peoplesLabel];
    
    self.peopleImageView = [[UIImageView alloc]init];
    self.peopleImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.peopleImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.peopleImageView];
    
    [self layoutSubview];
}

-(void)layoutSubview{

    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.and.right.mas_equalTo(self.contentView);
    
        make.height.equalTo(@(IMAGE_HEIGHT));
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.imageView.mas_bottom);
        make.left.and.right.mas_equalTo(self.contentView);
        make.height.equalTo(@30);
        
    }];
    
    UIImage *image = [UIImage imageNamed:@"icon_room_female"];
    [self.sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(image.size);
        
        make.left.mas_equalTo(self.contentView.mas_left);
        
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        
    }];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.sexImageView.mas_right).offset(5);
        make.top.mas_equalTo(self.sexImageView.mas_top);
        make.size.mas_equalTo(CGSizeMake(ITEM_WIDTH - image.size.width*2 -10 -35, image.size.height));
    }];

    [self.peoplesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(35, image.size.height));
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.sexImageView.mas_top);
    }];

    [self.peopleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(image.size);
        make.right.mas_equalTo(self.peoplesLabel.mas_left);
        make.top.mas_equalTo(self.sexImageView.mas_top);
    }];
}

-(void)fillCellWithZQGameDetailModel:(ZQGameDetailModel *)model{

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.spic]];
    
    self.titleLabel.text = model.title;
    
    UIImage *sexImage = [model.gender isEqual:@"1"]?[UIImage imageNamed:@"icon_room_female"]:[UIImage imageNamed:@"icon_room_male"];
    self.sexImageView.image = sexImage;
    
    self.authorLabel.text = model.nickname;
    NSString *online = model.online;
    if (online.length<=4) {
    }else{
        int   w = [online intValue]/10000;
        int   q  = [online intValue]%10000/1000;
        online =  [NSString stringWithFormat:@"%d.%d万", w,q];
    }
    self.peoplesLabel.text = online;
    
    self.peopleImageView.image = [UIImage imageNamed:@"audience"];
}

@end
