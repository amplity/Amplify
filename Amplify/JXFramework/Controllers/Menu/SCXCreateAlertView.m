//
//  SCXCreateAlertView.m
//  自定义弹出视图
//
//  Created by 孙承秀 on 15/12/31.
//  Copyright © 2015年 孙先森丶. All rights reserved.
//

#import "SCXCreateAlertView.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define ALERTWIDTH 150
#define ALERTHEIGHT 50
#define BUTTONALERTVIEWWIDTH 280
#define BUTTONALERTVIEWHEIGHT (180)
#define CRACKWIDTH 50
#define COLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define HEIGHT [UIScreen mainScreen].bounds.size.height
static SCXCreateAlertView *singCreateAlertView =nil;
@implementation SCXCreateAlertView
#pragma mark--单例
+(SCXCreateAlertView *)shareSingleCreateAlertView{

    static dispatch_once_t once;
    dispatch_once(&once, ^{
        singCreateAlertView=[[SCXCreateAlertView allocWithZone:NULL]init];
    });
    return singCreateAlertView;
}
#pragma mark--自定义下拉菜单
-(instancetype)initWithNameArray:(NSArray *)nameArray withFirstGroudImage:(NSMutableArray*)firstGroudImages andMenuOrigin:(CGPoint)orign andMenuWidth:(CGFloat)width andHeight:(CGFloat)rowHeight andLayer:(CGFloat)layer andTableViewBackGroundColor:(UIColor *)color andIsSharp:(BOOL)sharp andType:(popType)poptype{
    self=[super initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) ];
    if (self) {
        
        _popViewType=poptype;
        _isSharp=sharp;
        _layerSize=layer;
        _width=width;
        _orign=orign;
        _nameArray=nameArray;
        _groudImages = firstGroudImages;
        _color=color;
        self.backgroundColor=[UIColor clearColor];
        self.menuTableView=[[UITableView alloc]initWithFrame:CGRectMake(orign.x, orign.y, width, rowHeight*nameArray.count) style:UITableViewStylePlain];
        [self.menuTableView setBackgroundColor:color];
        [self.menuTableView setDelegate:self];
        [self.menuTableView setDataSource:self];
        self.menuTableView.rowHeight=rowHeight;
        [self.menuTableView.layer setMasksToBounds:YES];
        [self.menuTableView.layer setCornerRadius:layer];
        [self.menuTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"downMenuCell"];
        self.menuTableView.separatorColor=[UIColor whiteColor];
        //self.menuTableView.separatorColor = [UIColor redColor];
        self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //设置下拉菜单边框颜色，如果不需要可以注掉 。
        [self.menuTableView.layer setMasksToBounds:YES];
        [self.menuTableView.layer setBorderWidth:1];
        [self.menuTableView.layer setBorderColor:color.CGColor];
        
        for (NSInteger i=0; i<nameArray.count; i++) {
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake(10, (i+1)*rowHeight, self.menuTableView.frame.size.width-20, 1)];
            [view setBackgroundColor:[UIColor whiteColor]];
            [self.menuTableView addSubview:view];
        }

        [self addSubview:_menuTableView];
    }
    return self;
}
#pragma mark--tableView代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"downMenuCell"];
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.textColor=COLOR(109, 109, 109);
    cell.textLabel.text=_nameArray[indexPath.row];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    cell.imageView.image = [_groudImages objectAtIndex:indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    return cell;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _nameArray.count;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    if ([self.tableViewDelegate respondsToSelector:@selector(tableViewDidSelectRowAtIndexPath: andPopType:)]) {
        [self.tableViewDelegate tableViewDidSelectRowAtIndexPath:indexPath andPopType:_popViewType];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];

}
#pragma mark--自定义文字提示框
-(UIView *)createNoButtonAlertViewWithTitle:(NSString *)title{
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH-ALERTWIDTH)/2, (SCREENHEIGHT-50)/2+100, ALERTWIDTH, ALERTHEIGHT)];
    [_titleLabel setText:title];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setBackgroundColor:[UIColor lightGrayColor]];
    [_titleLabel.layer setMasksToBounds:YES];
    [_titleLabel.layer setCornerRadius:15];
    return _titleLabel;
}
#pragma mark--自定义背景虚拟效果,读者根据自己的喜好自定义。
-(UIView *)createBackGroundView{
    self.frame=[UIScreen mainScreen].bounds ;
    self.backgroundColor=[UIColor blackColor];
    //self.backgroundColor=COLOR(121, 121, 121);
    self.alpha=0.7;
    _view=self;
    return _view;

}
#pragma mark--自定义有Button或者有textField的alertVIew
-(UIView *)createAlertWithTitle:(NSString *)title andOkButtonTitle:(NSString *)okButtonTitle andCancelButtonTitle:(NSString *)cancelButtonTitle andAimTitle:(NSString *)aimTitle andAlertBody:(NSString *)body andIsTextField:(BOOL)isHas andViewLayer:(CGFloat)layer{
    _aimTitle=aimTitle;
     
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake((SCREENWIDTH-BUTTONALERTVIEWWIDTH)/2,( self.view.frame.size.height-BUTTONALERTVIEWHEIGHT)/2-64, BUTTONALERTVIEWWIDTH, BUTTONALERTVIEWHEIGHT)];
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:layer];
    _backViewFrame=view.frame;
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, 40)];
    //此处读者自定义标题颜色
    [titleLabel setBackgroundColor:COLOR(16, 108, 254)];
    [titleLabel setText:title];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor
                        ]];
     [view addSubview:titleLabel];
    UIButton *forkButton=[[UIButton alloc]initWithFrame:CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width-50, 5, 50, 30)];
    [forkButton setTitle:@"X" forState:UIControlStateNormal];
    [forkButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [forkButton.titleLabel setTextColor:[UIColor whiteColor]];
    [forkButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:forkButton];
    
    UILabel *label=[[UILabel alloc]init];
   label.frame=CGRectMake(titleLabel.bounds.origin.x+titleLabel.frame.size.height , view.bounds.origin.y+30, view.bounds.size.height, 100);
    if (!isHas) {
        
        //label.lineBreakMode=NSLineBreakByWordWrapping;
        label.numberOfLines=0;
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor blackColor]];
        [label setText:body];
        [view addSubview:label];
    }
    else{
        UITextField *textfiled=[[UITextField alloc]initWithFrame:CGRectMake(view.bounds.origin.x+30, view.bounds.origin.y+70, view.bounds.size.width-60, 30)];
        [textfiled.layer setCornerRadius:4];
        [textfiled setBackgroundColor:COLOR(239, 239, 239)];
        [SCXCreateAlertView shareSingleCreateAlertView].textField=textfiled;;
        textfiled.keyboardType=UIKeyboardTypeDefault;
        textfiled.clearButtonMode=UITextFieldViewModeAlways;
        textfiled.delegate=self;
        textfiled.placeholder=@"请输入名称";
        _textField=textfiled;
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0,0, 10, textfiled.frame.size.height)];
        [view1 setBackgroundColor:[UIColor clearColor]];
        [textfiled setLeftViewMode:UITextFieldViewModeAlways];
        [textfiled setLeftView:view1];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDismiss:) name:UIKeyboardWillHideNotification object:nil];
        [view addSubview:textfiled];
    }
    
    //[label setBackgroundColor:[UIColor redColor]];
    UIButton *cancelButton=[[UIButton alloc]initWithFrame:CGRectMake(view.bounds.origin.x+CRACKWIDTH-20, label.bounds.origin.y+label.frame.size.height+CRACKWIDTH-20, (view.frame.size.width-CRACKWIDTH*3)/2+10, (view.bounds.origin.y+view.frame.size.height-label.frame.size.height-view.bounds.origin.x)/2-10)];
    
    cancelButton.frame=CGRectMake(view.bounds.origin.x, view.bounds.origin.y+view.bounds.size.height-40, view.bounds.size.width/2, 40   );
    UIButton *OkBUtton=[[UIButton alloc]initWithFrame:CGRectMake(cancelButton.bounds.origin.x+cancelButton.bounds.size.width, cancelButton.frame.origin.y, view.frame.size.width/2, 40)];
    [OkBUtton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [OkBUtton addTarget:self action:@selector(OKButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    //此处读者自定义确定按钮颜色
    [OkBUtton setBackgroundColor:COLOR(19, 110, 254)];
    
    [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    //此处读者自定义取消按钮颜色
    [cancelButton setBackgroundColor:COLOR(226, 226, 226)];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [OkBUtton setTitle:okButtonTitle forState:UIControlStateNormal];
    //[OkBUtton setBackgroundColor:COLOR(158, 158, 158)];
    [view addSubview:OkBUtton];
    [view addSubview:cancelButton];
    view.alpha=1;
    [view setBackgroundColor:[UIColor whiteColor]];
    _backView=view;
    return view;
}
#pragma mark--消失事件
-(void)dismissWithCompletion:(void (^)(SCXCreateAlertView *))completion{
    __weak typeof(self)weakSelf=self;
    [UIView animateWithDuration:0.1 animations:^{
        weakSelf.menuTableView.frame=CGRectMake(_orign.x, _orign.y, _width, 0);
            } completion:^(BOOL finished) {
                
        if (weakSelf.dismiss) {
            weakSelf.dismiss();
        }
    }];
    

}
-(void)animation{
    if (self.dismiss) {
        self.dismiss();
    }
}
#pragma mark--touch取消事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textField resignFirstResponder];
    [self dismissWithCompletion:nil];

}
#pragma mark--单击按钮代理方法
-(void)OKButtonClicked{
    NSLog(@"您点击确定按钮了");
    if ([self.delegate respondsToSelector:@selector(OKButtonClick:)]) {
        [self.delegate OKButtonClick:_aimTitle];
    }

}
-(void)cancelButtonClicked{
    NSLog(@"您点击取消按钮了");
    if ([self.delegate respondsToSelector:@selector(cancelButtonClick:)]) {
        [self.delegate cancelButtonClick:_aimTitle];
    }

}
#pragma mark--键盘弹出监听
-(void)keyboardShow:(NSNotification *)object{
    CGRect rect=[[[object userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"%f",rect.origin.y);
    [UIView animateWithDuration:1 animations:^{
        [_backView setFrame:CGRectMake(_backView.frame.origin.x,HEIGHT-rect.size.height-70-_backView.frame.size.height,BUTTONALERTVIEWWIDTH, BUTTONALERTVIEWHEIGHT)];
    }];
}
-(void)keyboardDismiss:(NSNotification *)object{
    [UIView animateWithDuration:1 animations:^{
        [_backView setFrame:_backViewFrame];
    }];
}
#pragma mark--画三角形
-(void)drawRect:(CGRect)rect{
    if (_isSharp) {
        CGContextRef context=UIGraphicsGetCurrentContext();
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, _orign.x+20+_width/2, _orign.y-10);
        CGContextAddLineToPoint(context, _orign.x+20+_width/2-8, _orign.y);
        CGContextAddLineToPoint(context, _orign.x+_width/2+8+20, _orign.y);
        CGContextClosePath(context);
        [self.menuTableView.backgroundColor setFill];
        [_color setStroke];
        CGContextDrawPath(context, kCGPathFillStroke);
    }

   
}

@end
