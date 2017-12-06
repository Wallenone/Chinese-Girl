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
#import "UITextView+ZWPlaceHolder.h"
#import "MyIndexViewController.h"
@interface NewsMessageController ()<UITextViewDelegate>
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIImageView *AvatarImgView;
@property(nonatomic,strong)UIButton *avatarbtn;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *address;
@property(nonatomic,strong)UIImageView *addressIcon;
@property(nonatomic,strong)UIButton *talkBtn;
@property(nonatomic,strong)UIButton *followingBtn;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIButton *sendBtn;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UIView *toolBarView;
@end

@implementation NewsMessageController

- (void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeaderView];
    [self addSubViews];
}

-(void)back{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(void)talkClick{
    
}

-(void)avatarClick{
    NSArray*arrController =self.navigationController.viewControllers;
    
    NSInteger VcCount = arrController.count;
    
    //最后一个vc是自己，(-2)是倒数第二个是上一个控制器。
    
    UIViewController*lastVC = arrController[VcCount - 2];
    
    // 返回到倒数第三个控制器
    
    if([lastVC isKindOfClass:[MyIndexViewController class]]) {
        [self.navigationController popViewControllerAnimated:NO];
    }else{
        MyIndexViewController *myIndexVC=[[MyIndexViewController alloc] init];
        myIndexVC.ids=[self.myIndexModel.ids integerValue];
        [self.navigationController pushViewController:myIndexVC animated:NO];
    }
}

-(void)sendClick{
    if (self.textView.text.length>0) {
        NSArray*arrs=@[@{@"type":@"1",
                         @"message":self.textView.text,
                         @"avater":@"",
                         @"bigPicture":@"",
                         @"videoUrl":@"",
                         @"videoIcon":@"",
                         @"radiosecond":@"",
                         @"radiourl":@"",
                         @"turnFront":@"FrontRight"}];
        [self.tbv addContentData:arrs];
        [self.tbv scrollToBottom:YES];
        self.textView.text=@"";
    }
    
    [self.textView resignFirstResponder];
}

-(void)followingClick:(UIButton *)button{//C5D4D2  //320AFD
    if ([button.currentTitle isEqual:@"Follow"]) {
        // [button setBackgroundColor:[UIColor getColor:@"320AFD"]];
        [button setTitle:@"Followed" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"myindexfollowed"] forState:UIControlStateNormal];
        [[CGSingleCommitData sharedInstance] addFollows:[NSString stringWithFormat:@"%@",self.myIndexModel.ids]];
    }
    else {
        // [button setBackgroundColor:[UIColor getColor:@"C5D4D2"]];
        [button setTitle:@"Follow" forState:UIControlStateNormal];
        [[CGSingleCommitData sharedInstance] deletefollow:[NSString stringWithFormat:@"%@",self.myIndexModel.ids]];
        [button setImage:[UIImage imageNamed:@"myindexplus"] forState:UIControlStateNormal];
    }
}

-(void)setHeaderView{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.leftBtn];
    [self.headerView addSubview:self.AvatarImgView];
    [self.headerView addSubview:self.avatarbtn];
    [self.headerView addSubview:self.nickName];
    [self.headerView addSubview:self.addressIcon];
    [self.headerView addSubview:self.address];
    [self.headerView addSubview:self.followingBtn];
    //[self.headerView addSubview:self.talkBtn];
}

-(void)addSubViews{
    [self.view addSubview:self.tbv];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.textView];
    [self.bottomView addSubview:self.sendBtn];
    [self.bottomView addSubview:self.lineView];
}

-(CGFloat)getCurrentItemHeight:(NSString *)message{
    CGFloat maxWidth =screen_width-144*SCREEN_RADIO;
    CGSize constraint = CGSizeMake(maxWidth, 99999.0f);
    CGSize size = [message sizeWithFont:[UIFont systemFontOfSize:16*SCREEN_RADIO] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    return ceil(size.height+70*SCREEN_RADIO);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    return YES;
    
}

- (void)textViewDidChange:(UITextView *)textView{
    
}

-(void)videoBar{
    
}

-(void)radioBar{
    
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 205*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor getColor:@"171616"];
    }
    
    return _headerView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 28.5*SCREEN_RADIO, screen_width, 24*SCREEN_RADIO)];
        _titleLabel.text=self.myIndexModel.userModel.nickname;
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn=[[UIButton alloc] initWithFrame:CGRectMake(20*SCREEN_RADIO, 33*SCREEN_RADIO, 10.5*SCREEN_RADIO, 17.5*SCREEN_RADIO)];
        [_leftBtn setImage:[UIImage imageNamed:@"myIndexLeft"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _leftBtn;
}



-(UIImageView *)AvatarImgView{
    if (!_AvatarImgView) {
        _AvatarImgView=[[UIImageView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 64*SCREEN_RADIO+15*SCREEN_RADIO, 100*SCREEN_RADIO, 100*SCREEN_RADIO)];
        [_AvatarImgView sd_setImageWithURL:[NSURL URLWithString:self.myIndexModel.userModel.avater]];
        _AvatarImgView.layer.cornerRadius=50*SCREEN_RADIO;
        _AvatarImgView.clipsToBounds=YES;
    }
    
    return _AvatarImgView;
}

-(UIButton *)avatarbtn{
    if (!_avatarbtn) {
        _avatarbtn=[[UIButton alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 64*SCREEN_RADIO+15*SCREEN_RADIO, 115*SCREEN_RADIO, 115*SCREEN_RADIO)];
        [_avatarbtn addTarget:self action:@selector(avatarClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _avatarbtn;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AvatarImgView.frame)+24*SCREEN_RADIO, 64*SCREEN_RADIO+20*SCREEN_RADIO, 180*SCREEN_RADIO, 16*SCREEN_RADIO)];
        _nickName.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _nickName.text=self.myIndexModel.userModel.nickname;
        _nickName.textColor=[UIColor getColor:@"ffffff"];
    }
    return _nickName;
}



-(UIImageView *)addressIcon{
    if (!_addressIcon) {
        _addressIcon=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AvatarImgView.frame)+25*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+6*SCREEN_RADIO, 7*SCREEN_RADIO, 12*SCREEN_RADIO)];
        _addressIcon.image=[UIImage imageNamed:@"myindexPin"];
    }
    return _addressIcon;
}

-(UILabel *)address{
    if (!_address) {
        _address=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.addressIcon.frame)+8.5*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+3*SCREEN_RADIO, 0, 14*SCREEN_RADIO)];
        _address.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        _address.textColor=[UIColor getColor:@"777777"];
        _address.text=self.myIndexModel.userModel.address;
        [_address sizeToFit];
    }
    
    return _address;
}


-(UIButton *)followingBtn{
    if (!_followingBtn) {
        _followingBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AvatarImgView.frame)+25.5*SCREEN_RADIO, CGRectGetMaxY(self.address.frame)+20*SCREEN_RADIO, 159.5*SCREEN_RADIO, 45*SCREEN_RADIO)];
        [_followingBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];//C5D4D2  //320AFD
        [_followingBtn setTitle:@"Follow" forState:UIControlStateNormal];
        _followingBtn.imageEdgeInsets = UIEdgeInsetsMake(13.5*SCREEN_RADIO,16.5*SCREEN_RADIO,14*SCREEN_RADIO,125*SCREEN_RADIO);
        _followingBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_followingBtn.imageView.frame.size.width, 0, 0);
        
        if (self.myIndexModel.userModel.followed) {
            [_followingBtn setTitle:@"Followed" forState:UIControlStateNormal];
            [_followingBtn setImage:[UIImage imageNamed:@"myindexfollowed"] forState:UIControlStateNormal];
        }else{
            [_followingBtn setTitle:@"Follow" forState:UIControlStateNormal];
            [_followingBtn setImage:[UIImage imageNamed:@"myindexplus"] forState:UIControlStateNormal];
        }
        _followingBtn.layer.cornerRadius=22.5*SCREEN_RADIO;
        _followingBtn.layer.borderWidth=0.5;
        _followingBtn.layer.borderColor=[UIColor getColor:@"ffffff"].CGColor;
        _followingBtn.titleLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        [_followingBtn addTarget:self action:@selector(followingClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    return _followingBtn;
}

-(UIButton *)talkBtn{
    if (!_talkBtn) {
        _talkBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.followingBtn.frame)+15*SCREEN_RADIO, CGRectGetMaxY(self.address.frame)+20*SCREEN_RADIO, 45*SCREEN_RADIO, 45*SCREEN_RADIO)];
        [_talkBtn setBackgroundImage:[UIImage imageNamed:@"talkButton"] forState:UIControlStateNormal];
        [_talkBtn addTarget:self action:@selector(talkClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _talkBtn;
}
-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        CGRect tbvFrame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), screen_width, screen_height-255*SCREEN_RADIO);
        //初始化
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.backgroundColor=[UIColor getColor:@"ffffff"];
        NSArray*arrs=@[@{@"type":self.myIndexModel.type,
                         @"message":self.myIndexModel.message,
                         @"avater":self.myIndexModel.userModel.avater,
                         @"bigPicture":self.myIndexModel.message_Bigpicture,
                         @"videoUrl":self.myIndexModel.message_videoUrl,
                         @"videoIcon":self.myIndexModel.message_videoIcon,
                         @"radiosecond":self.myIndexModel.message_radioSecond,
                         @"radiourl":self.myIndexModel.message_radioUrl,
                         @"turnFront":@"FrontLeft"}];
        [_tbv setDataArray:arrs];
        
        __weak __typeof(self)weakSelf = self;
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            NewsContentTableViewCell *cell=[[NewsContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:cellData];
            return cell;
        }];
        
        //动态改变
        
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            if ([[cellData stringForKey:@"type"] integerValue]==1) {
                return [weakSelf getCurrentItemHeight:[cellData stringForKey:@"message"]];
            }else if ([[cellData stringForKey:@"type"] integerValue]==2){
                return 72*SCREEN_RADIO;
            }else if ([[cellData stringForKey:@"type"] integerValue]==3){
                return 166*SCREEN_RADIO;
            }else if ([[cellData stringForKey:@"type"] integerValue]==4){
                return 166*SCREEN_RADIO;
            }
            
            return 62*SCREEN_RADIO;
        }];
        
        
        
        //    //允许上行滑动
        //    [_tbv onDragUp:^NSArray * (int page) {
        //        return [self loadNewData:page];
        //    }];
        //
        //    //允许下行滑动刷新
        //    [_tbv onDragDown:^{
        //
        //    }];
        
        
        //设置选中事件 block设置方式
        //indexPath  是当前行对象 indexPath.row(获取行数)
        //cellData 是当前行的数据
        
        [_tbv onCellSelected:^(NSIndexPath *indexPath, id cellData) {
            NSLog(@"click");
            
        }];
        
    }
    
    return _tbv;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, screen_height-100*SCREEN_RADIO, screen_width, 100*SCREEN_RADIO)];
        _bottomView.backgroundColor=[UIColor getColor:@"F9F9F9"];
        
        UIButton *new_videoBar=[[UIButton alloc] initWithFrame:CGRectMake(20*SCREEN_RADIO, 52*SCREEN_RADIO, 23*SCREEN_RADIO, 15*SCREEN_RADIO)];
        new_videoBar.userInteractionEnabled=YES;
        [new_videoBar setImage:[UIImage imageNamed:@"new_videoBar"] forState:UIControlStateNormal];
        [new_videoBar addTarget:self action:@selector(videoBar) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:new_videoBar];
        
        UIButton *news_phoneBar=[[UIButton alloc] initWithFrame:CGRectMake((screen_width-40*SCREEN_RADIO)/4-11*SCREEN_RADIO, 52*SCREEN_RADIO, 23*SCREEN_RADIO, 15*SCREEN_RADIO)];
        [news_phoneBar setImage:[UIImage imageNamed:@"news_phoneBar"] forState:UIControlStateNormal];
        [news_phoneBar addTarget:self action:@selector(radioBar) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:news_phoneBar];
        
        UIButton *news_phoneBar1=[[UIButton alloc] initWithFrame:CGRectMake(((screen_width-40*SCREEN_RADIO)/4-11*SCREEN_RADIO)*2, 52*SCREEN_RADIO, 23*SCREEN_RADIO, 15*SCREEN_RADIO)];
        [news_phoneBar1 setImage:[UIImage imageNamed:@"news_phoneBar"] forState:UIControlStateNormal];
        [news_phoneBar1 addTarget:self action:@selector(radioBar) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:news_phoneBar1];
        
        UIButton *news_phoneBar2=[[UIButton alloc] initWithFrame:CGRectMake(((screen_width-40*SCREEN_RADIO)/4-11*SCREEN_RADIO)*3, 52*SCREEN_RADIO, 23*SCREEN_RADIO, 15*SCREEN_RADIO)];
        [news_phoneBar2 setImage:[UIImage imageNamed:@"news_phoneBar"] forState:UIControlStateNormal];
        [news_phoneBar2 addTarget:self action:@selector(radioBar) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:news_phoneBar2];
        
    }
    
    return _bottomView;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView=[[UITextView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 11.5*SCREEN_RADIO, screen_width-108*SCREEN_RADIO, 24*SCREEN_RADIO)];
        _textView.zw_placeHolder=@"请输入内容";
        _textView.zw_placeHolderColor=[UIColor getColor:@"777777"];
        _textView.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _textView.backgroundColor=[UIColor getColor:@"F9F9F9"];
        _textView.delegate=self;
    }
    
    return _textView;
}

-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.textView.frame)+8*SCREEN_RADIO, 11.5*SCREEN_RADIO, screen_width-CGRectGetMaxX(self.textView.frame)+8*SCREEN_RADIO, 19.5*SCREEN_RADIO)];
        [_sendBtn setTitle:@"Send" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor getColor:@"777777"] forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
        _sendBtn.titleLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
    }
    
    return _sendBtn;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 42*SCREEN_RADIO, screen_width-30*SCREEN_RADIO, 0.5)];
        _lineView.backgroundColor=[UIColor getColor:@"D8D8D8"];
    }
    
    return _lineView;
}
@end

