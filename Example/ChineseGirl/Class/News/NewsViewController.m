//
//  NewsViewController.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/8.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsBottomMessage.h"
@interface NewsViewController ()
@property(nonatomic,strong)NewsBottomMessage *messageView;
@end

@implementation NewsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setHeaderView];
    [self addSubViews];
}

-(void)setHeaderView{
    [self setUpNavWithTitle:@"Chat" leftIcon:@"Newsleft" rightIcon:@"NewsAdd" leftTitle:nil rightTitle:nil delegate:nil];
}

-(void)addSubViews{
    [self.view addSubview:self.messageView];
}


-(NewsBottomMessage *)messageView{
    if (!_messageView) {
        _messageView=[[NewsBottomMessage alloc] initWithFrame:CGRectMake(0, (screen_height-64)-59*SCREEN_RADIO, screen_width, 59*SCREEN_RADIO) withDidBeginEditing:^(UITextView *textView) {
            //CGRect frame = textView.frame;
            int offset = (59*SCREEN_RADIO+216.0+64);//键盘高度216
            
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            
            [UIView setAnimationDuration:0.30f];//动画持续时间
            
            if (offset>0) {
                //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
                self.messageView.frame = CGRectMake(0.0f, screen_height-offset, screen_width, 59*SCREEN_RADIO);
            }
            [UIView commitAnimations];
        }];
    }
    
    return _messageView;
}

@end
