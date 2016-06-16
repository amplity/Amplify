//
//  SCXCreateAlertView.h
//  自定义弹出视图
//
//  Created by 孙承秀 on 15/12/31.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^Dismiss)(void);
typedef enum : NSInteger{
    kNavigationPop=1000,
    ksortPop
}popType;
@protocol ButtonClick;
@protocol SCXCreatePopViewDelegate;
@interface SCXCreateAlertView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,assign)id<ButtonClick>delegate;
@property(nonatomic,strong)id<SCXCreatePopViewDelegate>tableViewDelegate;
@property(nonatomic,strong)NSString *aimTitle;
@property(nonatomic,strong)UITableView *menuTableView;
@property(nonatomic,strong)NSArray *nameArray;
@property (nonatomic, strong) NSArray *groudImages;
@property(nonatomic,strong)Dismiss dismiss;
@property(nonatomic,assign)CGPoint orign;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,strong)UIView *view;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,assign)CGRect backViewFrame;
@property(nonatomic,assign)CGFloat layerSize;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,assign)popType popViewType;
@property(nonatomic,strong)UIColor *color;
@property(nonatomic,assign)BOOL isSharp;//下拉菜单是否有上面的三角形符号
+(SCXCreateAlertView *)shareSingleCreateAlertView;
-(UIView *)createNoButtonAlertViewWithTitle:(NSString *)title;
/*
 自定义一个alertView，传入alert的标题，确定按钮文字，取消按钮文字，和这个alert的用途标志aimTitle（比如说不同的情况下弹出alert，对应不同的事件）,可以设置为中间有textfield的alert，和没有textfield，中间为提示文字的alertView，需要设置isHas属性，真为有textfield，否为没有，当设置为有textfield时候，body属性无效，文字不显示，中间位置只显示textfiled,包括您是否想设置此alertView有圆角,都可以根据自己的喜好自定义.
 */
-(UIView *)createAlertWithTitle:(NSString *)title andOkButtonTitle:(NSString *)okButtonTitle andCancelButtonTitle:(NSString *)cancelButtonTitle andAimTitle:(NSString *)aimTitle andAlertBody:(NSString *)body andIsTextField:(BOOL)isHas andViewLayer:(CGFloat)layer;
//自定义背景虚拟效果,读者可以根据自己的喜好在此方法里面设置北京效果，透明或者不透明，包括背景颜色都可以设置
-(UIView *)createBackGroundView;
/*
 自定义一个下拉菜单，传入下拉菜单显示的内容，属性为数组，下拉菜单左上角的位置，下拉菜单的宽度，下拉菜单的高度，每一行的高度，是否将下拉菜单设置为有圆角，传入圆角大小，设置下拉菜单的背景颜色，下拉菜单是否有上访的三角形符号，如果有则设置sharp属性为真，也可传入此下拉菜单的用途，用于复用，不同的情况弹出，对应不用的事件.
 */
-(instancetype)initWithNameArray:(NSArray *)nameArray withFirstGroudImage:(NSMutableArray*)firstGroudImages andMenuOrigin:(CGPoint)orign andMenuWidth:(CGFloat)width andHeight:(CGFloat)rowHeight andLayer:(CGFloat)layer  andTableViewBackGroundColor:(UIColor *)color andIsSharp:(BOOL)sharp andType:(popType)poptype;
//下拉菜单消失事件
-(void)dismissWithCompletion:(void (^)(SCXCreateAlertView *create))completion;

@end
//自定义alertView确定按钮和取消按钮代理方法，每次调用只需继承此协议，在不用的类里面，然后实现相应按钮的对应方法 。
@protocol ButtonClick <NSObject>

-(void)OKButtonClick:(NSString *)aimTitle;
-(void)cancelButtonClick:(NSString *)aimTitle;
@end
//下拉菜单，代理方法，当点击某一行时候，发生的事件 .
@protocol SCXCreatePopViewDelegate <NSObject>

-(void)tableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath andPopType:(popType)popViewType;

@end

