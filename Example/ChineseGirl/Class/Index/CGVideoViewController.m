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
#import <AssetsLibrary/AssetsLibrary.h>
#import "CGPinglunren.h"
@interface CGVideoViewController ()<ZFPlayerDelegate>
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIImageView *headerIconView;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *numLook;
@property(nonatomic,strong)RkyExtendedHitButton *closeBtn;
@property(nonatomic,strong)RkyExtendedHitButton *menuBtn1;
@property(nonatomic,strong)RkyExtendedHitButton *menuBtn2;
@property(nonatomic,strong)RkyExtendedHitButton *menuBtn3;
@property(nonatomic,strong)RkyExtendedHitButton *menuBtn4;
@property(nonatomic,strong)UIImageView *goldImgView;
@property(nonatomic,strong)UILabel *goldNumText;
@property(nonatomic,strong)UIImageView *goldhandbigView;
@property(nonatomic,strong)ZFPlayerView *playerView;
@property(nonatomic,strong)CGGiftView *giftView;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,strong)UIView *giftFriendView;
@property(nonatomic,strong)RkyExtendedHitButton *tbvBtnClose;
@property(nonatomic,strong)NSArray *pinglunrenArr;
@end

@implementation CGVideoViewController
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewAction:)];
    [self.view addGestureRecognizer:tapGesturRecognizer];
    [self setData];
    [self delayMethod];
}

-(void)setData{
    self.pinglunrenArr= [CGPinglunren reloadRandom];
}

- (void)delayMethod{
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
        indexVC.ids=[self.uid integerValue];
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
            newMessage.userid=self.uid;
            newMessage.myIndexModel=[[CGSingleCommitData sharedInstance] getNewSubListWithUserid:self.uid];
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
            if ([CGSingleCommitData sharedInstance].goldNum>=30) {
                [CGSingleCommitData sharedInstance].goldNum-=30;
                self.goldhandbigView.layer.opacity=1;
                [UIView animateWithDuration:0.5 delay:2.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    self.goldhandbigView.layer.opacity=0;
                } completion:^(BOOL finished) {
                    
                }];
            }else{
                [self getGlodView];
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

-(void)menuClick4{
    if ([CGSingleCommitData sharedInstance].uid.length<=0) {
        CGNewSignInViewController *loginVC=[[CGNewSignInViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }else{
        if ([CGSingleCommitData sharedInstance].vipLevel.length>0) {
            [[CGSingleCommitData sharedInstance] addFriendArr:self.uid];
            [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"tianjiachenggong", nil)];
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
    [self.view addSubview:self.goldhandbigView];
   // [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.menuBtn1];
    [self.view addSubview:self.menuBtn2];
    [self.view addSubview:self.menuBtn3];
    [self.view addSubview:self.menuBtn4];
    [self.view addSubview:self.goldImgView];
    [self.view addSubview:self.goldNumText];
    [self.view addSubview:self.giftView];
    [self.view addSubview:self.tbv];
    [self.view addSubview:self.tbvBtnClose];

}

- (void)showVideoPlayer{
        //回调或者说是通知主线程刷新，
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
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(6*SCREEN_RADIO, 20*SCREEN_RADIO, 150*SCREEN_RADIO, 35*SCREEN_RADIO)];
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
        [_headerIconView sd_setImageWithURL:[NSURL URLWithString:[CGUserInfo getitemWithID:self.uid].avater] placeholderImage:[UIImage imageNamed:@"default_nor_avatar"]];
        _headerIconView.layer.cornerRadius=31/2*SCREEN_RADIO;
        _headerIconView.clipsToBounds=YES;
    }
    
    return _headerIconView;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headerIconView.frame)+5*SCREEN_RADIO, 4*SCREEN_RADIO, 70*SCREEN_RADIO, 14*SCREEN_RADIO)];
        _nickName.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        _nickName.textColor=[UIColor getColor:@"ffffff"];
        _nickName.text=[CGUserInfo getitemWithID:self.uid].nickname;
    }
    
    return _nickName;
}

-(UILabel *)numLook{    
    if (!_numLook) {
        _numLook=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headerIconView.frame)+5*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+3*SCREEN_RADIO, 0, 8*SCREEN_RADIO)];
        _numLook.text=[NSString stringWithFormat:@"%d %@",[CGCommonToolsNode getRandomNumber:2000 to:10000],NSLocalizedString(@"guankanrenshu", nil)];
        _numLook.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.85];
        _numLook.font=[UIFont systemFontOfSize:8*SCREEN_RADIO];
        [_numLook sizeToFit];
    }
    
    return _numLook;
}

-(RkyExtendedHitButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(screen_width-30*SCREEN_RADIO, 30*SCREEN_RADIO, 14*SCREEN_RADIO, 14*SCREEN_RADIO)];
        [_closeBtn setImage:[UIImage imageNamed:@"closeShape"] forState:UIControlStateNormal];
       // [_closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _closeBtn;
}

-(RkyExtendedHitButton *)menuBtn1{
    if (!_menuBtn1) {
        _menuBtn1=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(screen_width-60*SCREEN_RADIO, screen_height/2+85*SCREEN_RADIO, 50*SCREEN_RADIO, 50*SCREEN_RADIO)];
        [_menuBtn1 setImage:[UIImage imageNamed:@"level_exclusive_gift_enable"] forState:UIControlStateNormal];
        [_menuBtn1 addTarget:self action:@selector(menuClick1) forControlEvents:UIControlEventTouchUpInside];
        _menuBtn1.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _menuBtn1;
}

-(RkyExtendedHitButton *)menuBtn2{
    if (!_menuBtn2) {
        _menuBtn2=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(screen_width-60*SCREEN_RADIO, CGRectGetMaxY(self.menuBtn1.frame)+15*SCREEN_RADIO, 50*SCREEN_RADIO, 50*SCREEN_RADIO)];
        [_menuBtn2 setImage:[UIImage imageNamed:@"level_privilege_message_enable"] forState:UIControlStateNormal];
        [_menuBtn2 addTarget:self action:@selector(menuClick2) forControlEvents:UIControlEventTouchUpInside];
        _menuBtn2.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _menuBtn2;
}

-(RkyExtendedHitButton *)menuBtn3{
    if (!_menuBtn3) {
        _menuBtn3=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(screen_width-70*SCREEN_RADIO, screen_height/2, 70*SCREEN_RADIO, 70*SCREEN_RADIO)];
        [_menuBtn3 setImage:[UIImage imageNamed:@"gold_hand_19yeah"] forState:UIControlStateNormal];
        [_menuBtn3 addTarget:self action:@selector(menuClick3) forControlEvents:UIControlEventTouchUpInside];
        _menuBtn3.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _menuBtn3;
}

-(UIImageView *)goldImgView{
    if (!_goldImgView) {
        _goldImgView=[[UIImageView alloc]initWithFrame:CGRectMake(screen_width-50*SCREEN_RADIO, CGRectGetMaxY(self.menuBtn3.frame)-10*SCREEN_RADIO, 12*SCREEN_RADIO, 12*SCREEN_RADIO)];
        _goldImgView.image=[UIImage imageNamed:@"leaderboard_coin"];
    }
    
    return _goldImgView;
}

-(UILabel *)goldNumText{
    if(!_goldNumText){
        _goldNumText=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.goldImgView.frame)+5*SCREEN_RADIO, CGRectGetMaxY(self.menuBtn3.frame)-10*SCREEN_RADIO, 0, 12*SCREEN_RADIO)];
        _goldNumText.text=@"30";
        _goldNumText.textColor=[UIColor getColor:@"ffffff"];
        _goldNumText.font=[UIFont boldSystemFontOfSize:12*SCREEN_RADIO];
        [_goldNumText sizeToFit];
    }
    
    return _goldNumText;
}



-(RkyExtendedHitButton *)menuBtn4{
    if (!_menuBtn4) {
        _menuBtn4=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(screen_width-60*SCREEN_RADIO, CGRectGetMaxY(self.menuBtn2.frame)+15*SCREEN_RADIO, 50*SCREEN_RADIO, 54*SCREEN_RADIO)];
        if ([[CGSingleCommitData sharedInstance].addFriendArr containsObject:self.uid]) {
            _menuBtn4.hidden=YES;
        }else{
            [_menuBtn4 setBackgroundImage:[UIImage imageNamed:@"video_addfriend"] forState:UIControlStateNormal];
            _menuBtn4.hidden=NO;
        }
        [_menuBtn4 addTarget:self action:@selector(menuClick4) forControlEvents:UIControlEventTouchUpInside];
        _menuBtn4.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
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
            msg.text = [NSString stringWithFormat:@"1 %@",giftName];
            
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
       // friend1.image= [UIImage imageNamed:@"Avatar"];
        CGPinglunren *model=(CGPinglunren *)self.pinglunrenArr[0];
        [friend1 sd_setImageWithURL:[NSURL URLWithString:model.avater] placeholderImage:[UIImage imageNamed:@"default_nor_avatar"]];
        friend1.layer.cornerRadius=10.5*SCREEN_RADIO;
        friend1.clipsToBounds=YES;
        [_giftFriendView addSubview:friend1];
        
        UIImageView *friend2=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(friend1.frame)+10*SCREEN_RADIO, 0, 21*SCREEN_RADIO, 21*SCREEN_RADIO)];
        CGPinglunren *model1=(CGPinglunren *)self.pinglunrenArr[1];
        [friend2 sd_setImageWithURL:[NSURL URLWithString:model1.avater] placeholderImage:[UIImage imageNamed:@"default_nor_avatar"]];
        friend2.layer.cornerRadius=10.5*SCREEN_RADIO;
        friend2.clipsToBounds=YES;
        [_giftFriendView addSubview:friend2];
        
        UIImageView *friend3=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(friend2.frame)+10*SCREEN_RADIO, 0, 21*SCREEN_RADIO, 21*SCREEN_RADIO)];
        CGPinglunren *model2=(CGPinglunren *)self.pinglunrenArr[2];
        [friend3 sd_setImageWithURL:[NSURL URLWithString:model2.avater] placeholderImage:[UIImage imageNamed:@"default_nor_avatar"]];
        friend3.layer.cornerRadius=10.5*SCREEN_RADIO;
        friend3.clipsToBounds=YES;
        [_giftFriendView addSubview:friend3];
        
        UILabel *friendTotal=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(friend3.frame)+10*SCREEN_RADIO, 3.5*SCREEN_RADIO, 0, 14*SCREEN_RADIO)];
        friendTotal.text=[NSString stringWithFormat:@"%lu >",(unsigned long)self.pinglunrenArr.count];
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
        
        [_tbv setDataArray:self.pinglunrenArr];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            CGGiftGetTableViewCell *cell=[[CGGiftGetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withModel:cellData];
            
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

-(RkyExtendedHitButton *)tbvBtnClose{
    if(!_tbvBtnClose){
        _tbvBtnClose=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(screen_width-24*SCREEN_RADIO, 215*SCREEN_RADIO, 14*SCREEN_RADIO, 14*SCREEN_RADIO)];
        [_tbvBtnClose setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        [_tbvBtnClose addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _tbvBtnClose.hidden=YES;
        _tbvBtnClose.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _tbvBtnClose;
}


-(UIImageView *)goldhandbigView{
    if (!_goldhandbigView) {
        _goldhandbigView=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width/2-(292/2), screen_height/2-(275/2), 292, 275)];
        _goldhandbigView.image=[UIImage imageNamed:@"gold_hand_19big"];
        _goldhandbigView.layer.opacity=0.0;
    }
    
    return _goldhandbigView;
}

-(NSArray *)pinglunrenArr{
    if (!_pinglunrenArr) {
        _pinglunrenArr=[[NSArray alloc] init];
    }
    
    return _pinglunrenArr;
}

@end
