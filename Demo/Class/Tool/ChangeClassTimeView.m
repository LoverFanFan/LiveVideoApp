//
//  ChangeClassTimeView.m
//  InchTime
//
//  Created by 吴启凡 on 16/6/20.
//
//

#import "ChangeClassTimeView.h"
#import "UIView+ViewFrameGeometry.h"

@implementation ChangeClassTimeView
{
    UILabel     *_noticeLab;
    UITextField *_tf;
    UIButton    *_btn;
    UIView      *_view;
    UILabel     *_topLab;
    UILabel     *_linelab;
    UIButton    *_cancleBtn;
}

- (id)initWithFrame:(CGRect)frame WithBtn:(UIButton *)btn{
    
    self = [super initWithFrame:frame];
    if (self) {
        _btn = btn;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UIControl *control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    control.backgroundColor = [UIColor blackColor];
    control.alpha = 0.3;
    [control addTarget:self action:@selector(controlCancleAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:control];

    _view = [[UIView alloc]init];
    _view.backgroundColor = [UIColor whiteColor];
    _view.layer.cornerRadius = 10;
    [self addSubview:_view];
    
    _topLab = [[UILabel alloc]init];
    _topLab.font     = [UIFont systemFontOfSize:15.0];
    _topLab.text     = @"请输入课程时间";
    _topLab.textColor= [UIColor blackColor];
    _topLab.textAlignment = NSTextAlignmentCenter;
    [_view addSubview:_topLab];
    
    _tf = [[UITextField alloc]init];
    _tf.placeholder  = @"请输入课程时间";
    _tf.font = [UIFont systemFontOfSize:15.0];
    _tf.borderStyle = UITextBorderStyleRoundedRect;
    [_view addSubview:_tf];

    _linelab = [[UILabel alloc]init];
    _linelab.backgroundColor = [UIColor lightGrayColor];
    [_view addSubview:_linelab];
    
    _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancleBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_cancleBtn setTitleColor:[UIColor blueColor]
                     forState:UIControlStateNormal];
    _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_cancleBtn addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    [_view addSubview:_cancleBtn];
    [self autoLayout];
    
}

- (void)autoLayout{
    
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self).centerOffset(CGPointMake(0, -100));///距离中心Y的偏移量
        make.size.mas_equalTo(CGSizeMake(SCREEN_HEIGHT-40, 130));
    }];
    
    [_topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(_view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(150, 17));
    }];
    
    [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLab.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(_view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_HEIGHT-60, 30));
        
    }];
    
    [_linelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tf.mas_bottom).with.offset(20);
        make.centerX.mas_equalTo(_view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_HEIGHT-40, 0.5));
    }];
    
    [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(_linelab.mas_bottom);
        make.left.and.right.mas_equalTo(_view);
        make.height.equalTo(@40);
        
    }];
    
    
}

- (void)setNoticeStr:(NSString *)noticeStr{
    
    _noticeLab.text = noticeStr;
}

- (void)controlCancleAction{
    
    [self removeFromSuperview];
}

- (void)cancleAction{
    
    if (_tf.text && _tf.text.length > 0) {
        
        [_btn setTitle:_tf.text forState:UIControlStateNormal];
        if (self.delegate && [self.delegate respondsToSelector:@selector(promptCancleAction:andTag:)]) {
            [self.delegate promptCancleAction:_tf.text andTag:[NSString stringWithFormat:@"%ld",(long)_btn.tag]];
        }
    }
    
    [self removeFromSuperview];
    
    
}

- (void)dealloc{
    
    NSLog(@"promptView 狗带");
}


@end
