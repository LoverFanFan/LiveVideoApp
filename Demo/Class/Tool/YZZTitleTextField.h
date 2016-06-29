

#import <UIKit/UIKit.h>

@class YZZTitleTextField;

@protocol CDoubleTapTextFieldDelegate <NSObject>

-(void) EditFinished: (YZZTitleTextField *)doubleTaps;

@end

@interface YZZTitleTextField : UIView <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *m_TextField;
@property (strong, nonatomic) UIButton    *m_Button;
@property (strong, nonatomic) NSString    *m_title;
@property (nonatomic)         BOOL        bIsDetail;
@property (nonatomic)         BOOL        bIsDouble;

@property (nonatomic, weak) id <CDoubleTapTextFieldDelegate> m_editDelegate;

-(IBAction)singleButtonPressed:(id)sender;
-(IBAction)singleButtonDoubleTaps:(id)sender;

-(BOOL)editEnd:(UITextField *)textField;
-(void)setText:(NSString *)text;

@end
