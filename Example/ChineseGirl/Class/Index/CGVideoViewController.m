//
//  CGVideoViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/21.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGVideoViewController.h"
#import "ZFPlayer.h"
#import "MyIndexViewController.h"
#import "CGGiftView.h"
#import "SVProgressHUD.h"
#import "CGVipViewController.h"
#import "NewsMessageController.h"
#import "MyIndexViewController.h"
#import "CGGoldCoinViewController.h"
#import "CGNewSignInViewController.h"
#import "PresentView.h"
#import "GiftModel.h"
#import "AnimOperation.h"
#import "AnimOperationManager.h"
#import "GSPChatMessage.h"
#import "EZJFastTableView.h"
#import "CGGiftGetTableViewCell.h"
@interface CGVideoViewController ()<ZFPlayerDelegate>
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIImageView *headerIconView;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *numLook;
@property(nonatomic,strong)UIButton *closeBtn;
@property(nonatomic,strong)UIButton *menuBtn1;
@property(nonatomic,strong)UIButton *menuBtn2;
@property(nonatomic,strong)UIButton *menuBtn3;
@property(nonatomic,strong)UIButton *menuBtn4;
@property(nonatomic,strong)ZFPlayerView *playerView;
@property(nonatomic,strong)CGGiftView *giftView;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,strong)UIView *giftFriendView;
@property(nonatomic,strong)UIButton *tbvBtnClose;
@end

@implementation CGVideoViewController
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewAction:)];
    [self.view addGestureRecognizer:tapGesturRecognizer];
    [self showVideoPlayer];
    [self addSubViews];
}

-(void)tapAction {
    if ([CGSingleCommitData sharedInstance].uid.length<=0) {
        CGNewSignInViewController *loginVC=[[CGNewSignInViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }else{
        MyIndexViewController *indexVC=[[MyIndexViewController alloc] init];
        indexVC.ids=[self.userInfo.ids integerValue];
        [self.navigationController pushViewController:indexVC animated:NO];
    }
}

-(void)tapViewAction:(UITapGestureRecognizer *)tap{
    CGPoint currentPoint = [tap locationInView:self.view];
    if(!CGRectContainsPoint(CGRectMake(0, screen_height-200*SCREEN_RADIO, ScreenWidth, 200*SCREEN_RADIO), currentPoint)){
        if (!self.giftView.hidden) {
            self.giftView.hidden=YES;
        }
    }
}

-(void)closeClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)menuClick1{
    if ([CGSingleCommitData sharedInstance].uid.length<=0) {
        CGNewSignInViewController *loginVC=[[CGNewSignInViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }else{
        if (self.giftView.hidden) {
            self.giftView.hidden=NO;
        }else{
            self.giftView.hidden=YES;
        }
    }
}

-(void)menuClick2{
    if ([CGSingleCommitData sharedInstance].uid.length<=0) {
        CGNewSignInViewController *loginVC=[[CGNewSignInViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }else{
        if ([CGSingleCommitData sharedInstance].vipLevel.length>0) {
            NewsMessageController *newMessage=[[NewsMessageController alloc] init];
            newMessage.userid=self.userInfo.ids;
            newMessage.myIndexModel=[[CGSingleCommitData sharedInstance] getNewSubListWithUserid:self.userInfo.ids];
            [self.navigationController pushViewController:newMessage animated:NO];
        }else{
            CGVipViewController *vipVC=[[CGVipViewController alloc] init];
            vipVC.definesPresentationContext = YES;
            vipVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            vipVC.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            [self presentViewController:vipVC animated:NO completion:nil];
        }
    }
}

-(void)menuClick3{
    if ([CGSingleCommitData sharedInstance].uid.length<=0) {
        CGNewSignInViewController *loginVC=[[CGNewSignInViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }else{
        if ([CGSingleCommitData sharedInstance].vipLevel.length>0) {
            NSURL *url = [NSURL URLWithString:self.videoStr];
            NSString *path = url.path;
            [SVProgressHUD show];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //判断能不能保存到相簿
                if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path)) {
                    //保存视频到相簿
                    UISaveVideoAtPathToSavedPhotosAlbum(path, self,
                                                        @selector(video:didFinishSavingWithError:contextInfo:), nil);
                }else{
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showWithStatus:@"保存失败"];
                }
            });
        }else{
            CGVipViewController *vipVC=[[CGVipViewController alloc] init];
            vipVC.definesPresentationContext = YES;
            vipVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            vipVC.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            [self presentViewController:vipVC animated:NO completion:nil];
        }
        
    }
    
}

-(void)menuClick4{
    if ([CGSingleCommitData sharedInstance].uid.length<=0) {
        CGNewSignInViewController *loginVC=[[CGNewSignInViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }else{
        if ([CGSingleCommitData sharedInstance].vipLevel.length>0) {
            NSData *data1 = UIImagePNGRepresentation(self.menuBtn4.currentBackgroundImage);
            NSData *data = UIImagePNGRepresentation([UIImage imageNamed:@"leaderboard_discover_following_ico"]);
            if (![data isEqual:data1]) {
                [[CGSingleCommitData sharedInstance] addFriendArr:self.userInfo.ids];
                [self.menuBtn4 setBackgroundImage:[UIImage imageNamed:@"leaderboard_discover_following_ico"] forState:UIControlStateNormal];
            }
        }else{
            CGVipViewController *vipVC=[[CGVipViewController alloc] init];
            vipVC.definesPresentationContext = YES;
            vipVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            vipVC.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            [self presentViewController:vipVC animated:NO completion:nil];
        }
    }
}

-(void)getGlodView{
    CGGoldCoinViewController *goldVC=[[CGGoldCoinViewController alloc] init];
    __weak __typeof(self)weakSelf = self;
    [goldVC onBuyBack:^{
        [weakSelf.giftView setData];
    }];
    goldVC.definesPresentationContext = YES;
    goldVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    goldVC.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    [self presentViewController:goldVC animated:NO completion:nil];
}

-(void)videoAddClick{
    
}

-(void)backBtnClick{
    self.tbv.hidden=YES;
    self.tbvBtnClose.hidden=YES;
}

-(void)friendTotalClick{
    if (self.tbv.hidden) {
        self.tbv.hidden=NO;
    }else{
        self.tbv.hidden=YES;
    }
    
    if(self.tbvBtnClose.hidden){
        self.tbvBtnClose.hidden=NO;
    }else{
        self.tbvBtnClose.hidden=YES;
    }
}

-(void)addSubViews{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.headerIconView];
    [self.headerView addSubview:self.nickName];
    [self.headerView addSubview:self.numLook];
    [self.view addSubview:self.giftFriendView];
   // [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.menuBtn1];
    [self.view addSubview:self.menuBtn2];
    [self.view addSubview:self.menuBtn3];
    [self.view addSubview:self.menuBtn4];
    [self.view addSubview:self.giftView];
    [self.view addSubview:self.tbv];
    [self.view addSubview:self.tbvBtnClose];

}

- (void)showVideoPlayer{
    self.playerView = [[ZFPlayerView alloc] init];
    [self.view addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        // Here a 16:9 aspect ratio, can customize the video aspect ratio
        make.height.equalTo(self.playerView.mas_width).multipliedBy(9.0f/16.0f);
    }];
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    // model
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
    playerModel.fatherView=self.view;
    playerModel.videoURL = [NSURL URLWithString:self.videoStr];
    [self.playerView playerControlView:controlView playerModel:playerModel];
    self.playerView.delegate=self;
    // delegate
    [self.playerView.screenImgView sd_setImageWithURL:[NSURL URLWithString:self.videoIcon]];
    self.playerView.playerLayerGravity=ZFPlayerLayerGravityResize;
    [self.playerView autoPlayTheVideo];
    
}


-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(6*SCREEN_RADIO, 20*SCREEN_RADIO, 130*SCREEN_RADIO, 35*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _headerView.layer.cornerRadius=17.5*SCREEN_RADIO;
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [_headerView addGestureRecognizer:tapGesturRecognizer];
    }
    
    return _headerView;
}


-(UIImageView *)headerIconView{
    if (!_headerIconView) {
        _headerIconView=[[UIImageView alloc] initWithFrame:CGRectMake(2*SCREEN_RADIO, 2*SCREEN_RADIO, 31*SCREEN_RADIO, 31*SCREEN_RADIO)];
        [_headerIconView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.avater]];
        _headerIconView.layer.cornerRadius=31/2*SCREEN_RADIO;
        _headerIconView.clipsToBounds=YES;
    }
    
    return _headerIconView;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headerIconView.frame)+5*SCREEN_RADIO, 4*SCREEN_RADIO, 70*SCREEN_RADIO, 12*SCREEN_RADIO)];
        _nickName.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        _nickName.textColor=[UIColor getColor:@"ffffff"];
        _nickName.text=self.userInfo.nickname;
    }
    
    return _nickName;
}

-(UILabel *)numLook{    
    if (!_numLook) {
        _numLook=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headerIconView.frame)+5*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+3*SCREEN_RADIO, 70*SCREEN_RADIO, 8*SCREEN_RADIO)];
        _numLook.text=@"3532 观看人数";
        _numLook.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.85];
        _numLook.font=[UIFont systemFontOfSize:8*SCREEN_RADIO];
    }
    
    return _numLook;
}

-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-30*SCREEN_RADIO, 30*SCREEN_RADIO, 14*SCREEN_RADIO, 14*SCREEN_RADIO)];
        [_closeBtn setImage:[UIImage imageNamed:@"closeShape"] forState:UIControlStateNormal];
       // [_closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeBtn;
}

-(UIButton *)menuBtn1{
    if (!_menuBtn1) {
        _menuBtn1=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-60*SCREEN_RADIO, screen_height/2, 50*SCREEN_RADIO, 50*SCREEN_RADIO)];
        [_menuBtn1 setImage:[UIImage imageNamed:@"level_exclusive_gift_enable"] forState:UIControlStateNormal];
        [_menuBtn1 addTarget:self action:@selector(menuClick1) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _menuBtn1;
}

-(UIButton *)menuBtn2{
    if (!_menuBtn2) {
        _menuBtn2=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-60*SCREEN_RADIO, CGRectGetMaxY(self.menuBtn1.frame)+15*SCREEN_RADIO, 50*SCREEN_RADIO, 50*SCREEN_RADIO)];
        [_menuBtn2 setImage:[UIImage imageNamed:@"level_privilege_message_enable"] forState:UIControlStateNormal];
        [_menuBtn2 addTarget:self action:@selector(menuClick2) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _menuBtn2;
}

-(UIButton *)menuBtn3{
    if (!_menuBtn3) {
        _menuBtn3=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-60*SCREEN_RADIO, CGRectGetMaxY(self.menuBtn2.frame)+15*SCREEN_RADIO, 50*SCREEN_RADIO, 50*SCREEN_RADIO)];
        [_menuBtn3 setImage:[UIImage imageNamed:@"ic_sticker_download"] forState:UIControlStateNormal];
        [_menuBtn3 addTarget:self action:@selector(menuClick3) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _menuBtn3;
}

-(UIButton *)menuBtn4{
    if (!_menuBtn4) {
        _menuBtn4=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-60*SCREEN_RADIO, CGRectGetMaxY(self.menuBtn3.frame)+15*SCREEN_RADIO, 50*SCREEN_RADIO, 31*SCREEN_RADIO)];
        if ([[CGSingleCommitData sharedInstance].addFriendArr containsObject:self.userInfo.ids]) {
            [_menuBtn4 setBackgroundImage:[UIImage imageNamed:@"leaderboard_discover_following_ico"] forState:UIControlStateNormal];
        }else{
            [_menuBtn4 setBackgroundImage:[UIImage imageNamed:@"video_follow"] forState:UIControlStateNormal];
        }
        [_menuBtn4 addTarget:self action:@selector(menuClick4) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _menuBtn4;
}

-(CGGiftView *)giftView{
    if (!_giftView) {
        __weak __typeof(self)weakSelf = self;
        _giftView=[[CGGiftView alloc] initWithFrame:CGRectMake(0, screen_height-200*SCREEN_RADIO, ScreenWidth, 200*SCREEN_RADIO) withBuyBlock:^(NSString *glodNum) {
            [weakSelf getGlodView];
        } withGetGift:^(NSString *giftName, NSString *giftImgName) {
            GSPChatMessage *msg = [[GSPChatMessage alloc] init];
            msg.text = [NSString stringWithFormat:@"1个【%@】",giftName];
            
            msg.senderChatID = [CGSingleCommitData sharedInstance].nickName;
            msg.senderName = msg.senderChatID;
            // 礼物模型
            GiftModel *giftModel = [[GiftModel alloc] init];
            giftModel.headImage = [CGSingleCommitData sharedInstance].avatar;
            giftModel.name = msg.senderName;
            giftModel.giftImage = [UIImage imageNamed:giftImgName];
            giftModel.giftName = msg.text;
            giftModel.giftCount = 1;
            
            
            AnimOperationManager *manager = [AnimOperationManager sharedManager];
            manager.parentView = weakSelf.view;
            // 用用户唯一标识 msg.senderChatID 存礼物信息,model 传入礼物模型
            [manager animWithUserID:[NSString stringWithFormat:@"%@",msg.senderChatID] model:giftModel finishedBlock:^(BOOL result) {
                
            }];
        }];
        _giftView.hidden=YES;
    }
    
    return _giftView;
}

-(UIView *)giftFriendView{
    if (!_giftFriendView) {
        _giftFriendView=[[UIView alloc] initWithFrame:CGRectMake(6*SCREEN_RADIO, CGRectGetMaxY(self.headerView.frame)+6*SCREEN_RADIO, 200*SCREEN_RADIO, 21*SCREEN_RADIO)];
        _giftFriendView.backgroundColor=[UIColor clearColor];
        UIImageView *friend1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 21*SCREEN_RADIO, 21*SCREEN_RADIO)];
        friend1.image=[UIImage imageNamed:@"Avatar"];
        friend1.layer.cornerRadius=10.5*SCREEN_RADIO;
        friend1.clipsToBounds=YES;
        [_giftFriendView addSubview:friend1];
        
        UIImageView *friend2=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(friend1.frame)+10*SCREEN_RADIO, 0, 21*SCREEN_RADIO, 21*SCREEN_RADIO)];
        friend2.image=[UIImage imageNamed:@"Avatar"];
        friend2.layer.cornerRadius=10.5*SCREEN_RADIO;
        friend2.clipsToBounds=YES;
        [_giftFriendView addSubview:friend2];
        
        UIImageView *friend3=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(friend2.frame)+10*SCREEN_RADIO, 0, 21*SCREEN_RADIO, 21*SCREEN_RADIO)];
        friend3.image=[UIImage imageNamed:@"Avatar"];
        friend3.layer.cornerRadius=10.5*SCREEN_RADIO;
        friend3.clipsToBounds=YES;
        [_giftFriendView addSubview:friend3];
        
        UILabel *friendTotal=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(friend3.frame)+10*SCREEN_RADIO, 3.5*SCREEN_RADIO, 0, 14*SCREEN_RADIO)];
        friendTotal.text=@"19 >";
        friendTotal.textColor=[UIColor whiteColor];
        friendTotal.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        [friendTotal sizeToFit];
        [_giftFriendView addSubview:friendTotal];
        _giftFriendView.frame=CGRectMake(6*SCREEN_RADIO, CGRectGetMaxY(self.headerView.frame)+6*SCREEN_RADIO, CGRectGetMaxX(friendTotal.frame), 21*SCREEN_RADIO);
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(friendTotalClick)];
        [_giftFriendView addGestureRecognizer:tapGesturRecognizer];
    }
    
    return _giftFriendView;
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [SVProgressHUD dismiss];
    [SVProgressHUD showWithStatus:@"保存视频完成"];
    NSLog(@"保存视频完成");
}

- (void)zf_playerBackAction{
    [self closeClick];
}

-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        CGRect tbvFrame = CGRectMake(0, 200*SCREEN_RADIO, self.view.frame.size.width, screen_height-200*SCREEN_RADIO);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.backgroundColor=[UIColor colorWithRed:28/255 green:28/255 blue:28/255 alpha:0.8];
        //给tableview赋值
        
        [_tbv setDataArray:@[@1,@2,@3,@4]];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            CGGiftGetTableViewCell *cell=[[CGGiftGetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            return cell;
        }];
        
        //动态改变
        
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            
            return 65*SCREEN_RADIO;
        }];
        
        
        //设置选中事件 block设置方式
        //indexPath  是当前行对象 indexPath.row(获取行数)
        //cellData 是当前行的数据
        
        [_tbv onCellSelected:^(NSIndexPath *indexPath, id cellData) {
            NSLog(@"click");
           
        }];
        
        _tbv.hidden=YES;
        
    }
    
    return _tbv;
}

-(UIButton *)tbvBtnClose{
    if(!_tbvBtnClose){
        _tbvBtnClose=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-24*SCREEN_RADIO, 215*SCREEN_RADIO, 14*SCREEN_RADIO, 14*SCREEN_RADIO)];
        [_tbvBtnClose setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        [_tbvBtnClose addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _tbvBtnClose.hidden=YES;
    }
    
    return _tbvBtnClose;
}


@end
