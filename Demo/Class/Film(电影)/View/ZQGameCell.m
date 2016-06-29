//
//  ZQGameCell.m
//  Demo
//
//  Created by Mopon on 16/5/10.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "ZQGameCell.h"

@interface ZQGameCell ()

@property (nonatomic ,strong)UIImageView *imageView;

@property (nonatomic ,strong)UILabel *textlabel;

@end

@implementation ZQGameCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self setUpSubviews];
    }

    return self;
}

-(void)setUpSubviews{
    
    self.imageView = [[UIImageView alloc]init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self.contentView addSubview:self.imageView];
    
    
    self.textlabel = [[UILabel alloc]init];
    self.textlabel.textAlignment = NSTextAlignmentCenter;
    self.textlabel.textColor = [UIColor blackColor];
    self.textlabel.font = DEFAULT_FONT(14);
    self.textlabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.textlabel];

    [self layoutSubview];
}

-(void)layoutSubview{
    
    self.contentView.layer.borderWidth = 0.5;
    self.contentView.layer.borderColor = [[UIColor grayColor]CGColor];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.and.left.and.right.mas_equalTo(self.contentView);
        
        make.height.equalTo(@((SCREEN_WIDTH - 40)/3+20));
        
    }];
    
    [self.textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.imageView.mas_bottom);
        make.left.and.right.mas_equalTo(self.contentView);
        make.height.equalTo(@30);
        
    }];
}

-(void)fillCellWithZQGameModel:(ZQGameModel *)model{

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.spic]];
    
    self.textlabel.text = model.name;
}

@end
