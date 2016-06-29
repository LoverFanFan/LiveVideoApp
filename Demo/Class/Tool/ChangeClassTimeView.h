//
//  ChangeClassTimeView.h
//  InchTime
//
//  Created by 吴启凡 on 16/6/20.
//
//

#import <UIKit/UIKit.h>

@protocol ChangeClassTimeViewDelegate <NSObject>
@optional

- (void)promptCancleAction:(NSString *)time andTag:(NSString *)tag;

@end

@interface ChangeClassTimeView : UIView

- (id)initWithFrame:(CGRect)frame WithBtn:(UIButton *)btn;

@property (nonatomic, copy) NSString  *titleStr;
@property (nonatomic, copy) NSString  *noticeStr;
@property (nonatomic, assign) id<ChangeClassTimeViewDelegate> delegate;
@end