//
//  NewsViewController.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/8.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "NewsMessageController.h"
#import "NewsBottomMessage.h"
#import "EZJFastTableView.h"
#import "NewsContentModel.h"
#import "NewsContentTableViewCell.h"
@interface NewsMessageController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIImageView *newsContentbg;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,strong)NewsBottomMessage *messageView;
@end

@implementation NewsMessageController

-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addSubViews];
    [self setHeaderView];
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)setHeaderView{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.titleLable];
    [self.headerView addSubview:self.leftBtn];
}

-(void)addSubViews{
    
    [self.view addSubview:self.newsContentbg];
    [self.view addSubview:self.tbv];
    [self.view addSubview:self.messageView];
}

-(CGFloat)getCellHeight:(NewsContentModel*)model{
    CGFloat _cellHeight=0;
    if (model.text.length>0) {
        
        CGFloat maxWidth =screen_width-164*SCREEN_RADIO;
        
        CGSize constraint = CGSizeMake(maxWidth, 99999.0f);
        CGSize size = [model.text sizeWithFont:[UIFont systemFontOfSize:22*SCREEN_RADIO] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
        
        
        _cellHeight=size.height+54*SCREEN_RADIO;
    }
    
    return _cellHeight;
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
        _headerView.backgroundColor=[UIColor whiteColor];
    }
    return _headerView;
}

-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable=[[UILabel alloc] initWithFrame:CGRectMake(0, 29*SCREEN_RADIO, screen_width, 24*SCREEN_RADIO)];
        _titleLable.text=@"Wallen";
        _titleLable.textColor=[UIColor getColor:@"232627"];
        _titleLable.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLable.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLable;
}

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn=[[UIButton alloc] initWithFrame:CGRectMake(18.5*SCREEN_RADIO, 35*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _leftBtn;
}

-(UIImageView *)newsContentbg{
    if (!_newsContentbg) {
        _newsContentbg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
        _newsContentbg.image=[UIImage imageNamed:@"newsContentbg"];
    }
    
    return _newsContentbg;
}

-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        __weak __typeof(self)weakSelf = self;

        CGRect tbvFrame = CGRectMake(0, 64, self.view.frame.size.width, screen_height-120*SCREEN_RADIO);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.backgroundColor=[UIColor clearColor];
        NSMutableArray *arrays =[[NSMutableArray alloc] init];

        [_tbv setDataArray:arrays];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            NewsContentTableViewCell *cell =[[NewsContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:cellData];
            
            return cell;
            
        }];
        
        
        //是否启用删除功能
        [_tbv onCellediting:^{
            
        }];
        
        
        //动态改变
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            
            return [weakSelf getCellHeight:cellData];
        }];
        
        
        
        //设置选中事件 block设置方式
        //indexPath  是当前行对象 indexPath.row(获取行数)
        //cellData 是当前行的数据
        
        [_tbv onCellSelected:^(NSIndexPath *indexPath, id cellData) {
            NSLog(@"click");
        
        }];
        
    }
    
    return _tbv;
}




-(NewsBottomMessage *)messageView{
    if (!_messageView) {
        __weak __typeof(self)weakSelf = self;
        _messageView=[[NewsBottomMessage alloc] initWithFrame:CGRectMake(0, screen_height-60*SCREEN_RADIO, screen_width, 60*SCREEN_RADIO) withDidBeginEditing:^(UITextView *textView) {
            //CGRect frame = textView.frame;
            int offset = (59*SCREEN_RADIO+216.0);//键盘高度216
            
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            
            [UIView setAnimationDuration:0.30f];//动画持续时间
            
            if (offset>0) {
                //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
                weakSelf.messageView.frame = CGRectMake(0.0f, screen_height-offset, screen_width, 59*SCREEN_RADIO);
            }
            [UIView commitAnimations];
        } withDidSubmitEdit:^(NSString *text) {
            
            NewsContentModel *model = [[NewsContentModel alloc] init];
            model.icon=@"Avatar";
            model.text=text;
            model.timeDate=@"08:11";
            [weakSelf.tbv insertData:model];
            [weakSelf.tbv scrollToBottom:YES];
            weakSelf.messageView.frame = CGRectMake(0, screen_height-59*SCREEN_RADIO, screen_width, 59*SCREEN_RADIO);
        }];
    }
    
    return _messageView;
}



@end
