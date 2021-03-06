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
#import "CGUserInfo.h"
#import "CGMessageModel.h"
@interface NewsMessageController ()<UITextViewDelegate>
@property(nonatomic,strong)NSMutableArray *subListModel;
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)RkyExtendedHitButton *leftBtn;
@property(nonatomic,strong)UIImageView *AvatarImgView;
@property(nonatomic,strong)RkyExtendedHitButton *avatarbtn;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *address;
@property(nonatomic,strong)UIImageView *addressIcon;
@property(nonatomic,strong)RkyExtendedHitButton *talkBtn;
@property(nonatomic,strong)RkyExtendedHitButton *followingBtn;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)RkyExtendedHitButton *sendBtn;
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

-(NSMutableArray *)subListModel{
    if (!_subListModel) {
        _subListModel=[[NSMutableArray alloc] init];
    }
    
    return _subListModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeaderView];
    [self addSubViews];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)talkClick{
    
}

-(void)setMyIndexModel:(NSArray *)myIndexModel{
    for (NSDictionary *model in myIndexModel) {
        if ([[model stringForKey:@"type"] integerValue]==0) {
            for (CGMessageModel *newSubModel in [CGUserInfo getitemWithID:self.userid].messageids) {
                [self.subListModel addObject:newSubModel];
            }
        }else if ([[model stringForKey:@"type"] integerValue]==1){
            CGMessageModel *subModel=[CGMessageModel modelWithDic:@{@"type":@"0",@"message":[model stringForKey:@"message"]}];
            [self.subListModel addObject:subModel];
        }
    }
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
        myIndexVC.ids=self.userid.integerValue;
        [self.navigationController pushViewController:myIndexVC animated:NO];
    }
}

-(void)sendClick{
    if (self.textView.text.length>0) {
        CGMessageModel *subModel=[CGMessageModel modelWithDic:@{@"type":@"0",@"message":self.textView.text}];
        NSMutableArray *arrs=[NSMutableArray arrayWithObject:subModel];
        [self.tbv addContentData:arrs];
        [self.tbv scrollToBottom:YES];
        [[CGSingleCommitData sharedInstance] addNewSubList:@{@"type":@"1",@"message":self.textView.text,@"userid":self.userid}];
        self.textView.text=@"";
        
        NSArray *arr= [[CGSingleCommitData sharedInstance] getNewSubListWithUserid:self.userid];
        bool _state=YES;
        for (NSDictionary *model in arr) {
            if ([[model stringForKey:@"type"] integerValue]==0) {
                _state=NO;
            }
        }
        
        __weak __typeof(self)weakSelf = self;
        if (_state) {
            [[ZXCCycleTimer shareInstance] addCountDownWithTimeInterval:30 endBlock:^() {
                NSLog(@"十秒钟后执行了这个时间，并且添加系统聊天");
                [[CGSingleCommitData sharedInstance] addNewSubList:@{@"type":@"0",@"message":@"",@"userid":self.userid}];
                NSMutableArray *_tarr=[[NSMutableArray alloc] init];
                for (CGMessageModel *newSubModel in [CGUserInfo getitemWithID:self.userid].messageids){
                    [_tarr addObject:newSubModel];
                }
                [weakSelf.tbv addContentData:_tarr];
                [weakSelf.tbv scrollToBottom:YES];
            }];
        }
    }
    
    [self.textView resignFirstResponder];
}

-(void)followingClick:(UIButton *)button{//C5D4D2  //320AFD
    if ([button.currentTitle isEqual:NSLocalizedString(@"guanzhu", nil)]) {
        // [button setBackgroundColor:[UIColor getColor:@"320AFD"]];
        [button setTitle:NSLocalizedString(@"yiguanzhu", nil) forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"myindexfollowed"] forState:UIControlStateNormal];
        [[CGSingleCommitData sharedInstance] addFollows:[NSString stringWithFormat:@"%@",self.userid]];
    }
    else {
        // [button setBackgroundColor:[UIColor getColor:@"C5D4D2"]];
        [button setTitle:NSLocalizedString(@"guanzhu", nil) forState:UIControlStateNormal];
        [[CGSingleCommitData sharedInstance] deletefollow:[NSString stringWithFormat:@"%@",self.userid]];
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
        _titleLabel.text=[CGUserInfo getitemWithID:self.userid].nickname;
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(RkyExtendedHitButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(20*SCREEN_RADIO, 33*SCREEN_RADIO, 10.5*SCREEN_RADIO, 17.5*SCREEN_RADIO)];
        [_leftBtn setImage:[UIImage imageNamed:@"myIndexLeft"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _leftBtn;
}



-(UIImageView *)AvatarImgView{
    if (!_AvatarImgView) {
        _AvatarImgView=[[UIImageView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 64*SCREEN_RADIO+15*SCREEN_RADIO, 100*SCREEN_RADIO, 100*SCREEN_RADIO)];
        [_AvatarImgView sd_setImageWithURL:[NSURL URLWithString:[CGUserInfo getitemWithID:self.userid].avater] placeholderImage:[UIImage imageNamed:@"default_nor_avatar"]];
        _AvatarImgView.layer.cornerRadius=50*SCREEN_RADIO;
        _AvatarImgView.clipsToBounds=YES;
    }
    
    return _AvatarImgView;
}

-(RkyExtendedHitButton *)avatarbtn{
    if (!_avatarbtn) {
        _avatarbtn=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 64*SCREEN_RADIO+15*SCREEN_RADIO, 115*SCREEN_RADIO, 115*SCREEN_RADIO)];
        [_avatarbtn addTarget:self action:@selector(avatarClick) forControlEvents:UIControlEventTouchUpInside];
        _avatarbtn.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    return _avatarbtn;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AvatarImgView.frame)+24*SCREEN_RADIO, 64*SCREEN_RADIO+20*SCREEN_RADIO, 180*SCREEN_RADIO, 16*SCREEN_RADIO)];
        _nickName.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _nickName.text=[CGUserInfo getitemWithID:self.userid].nickname;
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
        _address.text=[CGUserInfo getitemWithID:self.userid].address;
        [_address sizeToFit];
    }
    
    return _address;
}


-(RkyExtendedHitButton *)followingBtn{
    if (!_followingBtn) {
        _followingBtn=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AvatarImgView.frame)+25.5*SCREEN_RADIO, CGRectGetMaxY(self.address.frame)+20*SCREEN_RADIO, 159.5*SCREEN_RADIO, 45*SCREEN_RADIO)];
        [_followingBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];//C5D4D2  //320AFD
        [_followingBtn setTitle:NSLocalizedString(@"guanzhu", nil) forState:UIControlStateNormal];
        _followingBtn.imageEdgeInsets = UIEdgeInsetsMake(13.5*SCREEN_RADIO,16.5*SCREEN_RADIO,14*SCREEN_RADIO,125*SCREEN_RADIO);
        _followingBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_followingBtn.imageView.frame.size.width, 0, 0);
        
        if ([CGUserInfo getitemWithID:self.userid].followed) {
            [_followingBtn setTitle:NSLocalizedString(@"yiguanzhu", nil) forState:UIControlStateNormal];
            [_followingBtn setImage:[UIImage imageNamed:@"myindexfollowed"] forState:UIControlStateNormal];
        }else{
            [_followingBtn setTitle:NSLocalizedString(@"guanzhu", nil) forState:UIControlStateNormal];
            [_followingBtn setImage:[UIImage imageNamed:@"myindexplus"] forState:UIControlStateNormal];
        }
        _followingBtn.layer.cornerRadius=22.5*SCREEN_RADIO;
        _followingBtn.layer.borderWidth=0.5;
        _followingBtn.layer.borderColor=[UIColor getColor:@"ffffff"].CGColor;
        _followingBtn.titleLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        [_followingBtn addTarget:self action:@selector(followingClick:) forControlEvents:UIControlEventTouchUpInside];
        _followingBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
        
    }
    
    return _followingBtn;
}

-(RkyExtendedHitButton *)talkBtn{
    if (!_talkBtn) {
        _talkBtn=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.followingBtn.frame)+15*SCREEN_RADIO, CGRectGetMaxY(self.address.frame)+20*SCREEN_RADIO, 45*SCREEN_RADIO, 45*SCREEN_RADIO)];
        [_talkBtn setBackgroundImage:[UIImage imageNamed:@"talkButton"] forState:UIControlStateNormal];
        [_talkBtn addTarget:self action:@selector(talkClick) forControlEvents:UIControlEventTouchUpInside];
        _talkBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
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
        [_tbv setDataArray:self.subListModel];
        
        __weak __typeof(self)weakSelf = self;
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            NewsContentTableViewCell *cell=[[NewsContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:cellData withUserId:self.userid];
            return cell;
        }];
        
        //动态改变
        
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,CGMessageModel *cellData) {
            if ([cellData.type integerValue]==0) {
                return [weakSelf getCurrentItemHeight:cellData.message];
            }else if ([cellData.type integerValue]==1) {
                return [weakSelf getCurrentItemHeight:cellData.message];
            }else if ([cellData.type integerValue]==2){
                return 72*SCREEN_RADIO;
            }else if ([cellData.type integerValue]==3){
                return 166*SCREEN_RADIO;
            }else if ([cellData.type integerValue]==4){
                return 166*SCREEN_RADIO;
            }
            
            return 62*SCREEN_RADIO;
        }];
        
        //tableView还没刷新完就开始调用滚到到底部的方法，所以可以利用伪延迟来进行处理。
        if (self.subListModel.count>0) {
            double delayInSeconds = 0.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
                if ([self.subListModel count] > 1){
                    // 动画之前先滚动到倒数第二个消息
                    [_tbv scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.subListModel count] - 2 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                }
                //self.chatTableView.hidden = NO;
                NSIndexPath* path = [NSIndexPath indexPathForRow:[self.subListModel count] - 1 inSection:0];
                [_tbv scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            });
        }
       
        
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
        _bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, screen_height-50*SCREEN_RADIO, screen_width, 50*SCREEN_RADIO)];
        _bottomView.backgroundColor=[UIColor getColor:@"eeeeee"];
//
//        UIButton *new_videoBar=[[UIButton alloc] initWithFrame:CGRectMake(20*SCREEN_RADIO, 52*SCREEN_RADIO, 23*SCREEN_RADIO, 15*SCREEN_RADIO)];
//        new_videoBar.userInteractionEnabled=YES;
//        [new_videoBar setImage:[UIImage imageNamed:@"new_videoBar"] forState:UIControlStateNormal];
//        [new_videoBar addTarget:self action:@selector(videoBar) forControlEvents:UIControlEventTouchUpInside];
//        [_bottomView addSubview:new_videoBar];
//
//        UIButton *news_phoneBar=[[UIButton alloc] initWithFrame:CGRectMake((screen_width-40*SCREEN_RADIO)/4-11*SCREEN_RADIO, 52*SCREEN_RADIO, 23*SCREEN_RADIO, 15*SCREEN_RADIO)];
//        [news_phoneBar setImage:[UIImage imageNamed:@"news_phoneBar"] forState:UIControlStateNormal];
//        [news_phoneBar addTarget:self action:@selector(radioBar) forControlEvents:UIControlEventTouchUpInside];
//        [_bottomView addSubview:news_phoneBar];
//
//        UIButton *news_phoneBar1=[[UIButton alloc] initWithFrame:CGRectMake(((screen_width-40*SCREEN_RADIO)/4-11*SCREEN_RADIO)*2, 52*SCREEN_RADIO, 23*SCREEN_RADIO, 15*SCREEN_RADIO)];
//        [news_phoneBar1 setImage:[UIImage imageNamed:@"news_phoneBar"] forState:UIControlStateNormal];
//        [news_phoneBar1 addTarget:self action:@selector(radioBar) forControlEvents:UIControlEventTouchUpInside];
//        [_bottomView addSubview:news_phoneBar1];
//
//        UIButton *news_phoneBar2=[[UIButton alloc] initWithFrame:CGRectMake(((screen_width-40*SCREEN_RADIO)/4-11*SCREEN_RADIO)*3, 52*SCREEN_RADIO, 23*SCREEN_RADIO, 15*SCREEN_RADIO)];
//        [news_phoneBar2 setImage:[UIImage imageNamed:@"news_phoneBar"] forState:UIControlStateNormal];
//        [news_phoneBar2 addTarget:self action:@selector(radioBar) forControlEvents:UIControlEventTouchUpInside];
//        [_bottomView addSubview:news_phoneBar2];
        
    }
    
    return _bottomView;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView=[[UITextView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 11.5*SCREEN_RADIO, screen_width-108*SCREEN_RADIO, 24*SCREEN_RADIO)];
        _textView.zw_placeHolder=NSLocalizedString(@"qingshuruneirong", nil);
        _textView.zw_placeHolderColor=[UIColor getColor:@"777777"];
        _textView.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _textView.backgroundColor=[UIColor getColor:@"eeeeee"];
        _textView.delegate=self;
    }
    
    return _textView;
}

-(RkyExtendedHitButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.textView.frame)+8*SCREEN_RADIO, 11.5*SCREEN_RADIO, screen_width-CGRectGetMaxX(self.textView.frame)+8*SCREEN_RADIO, 19.5*SCREEN_RADIO)];
        [_sendBtn setTitle:NSLocalizedString(@"fasong", nil) forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor getColor:@"777777"] forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
        _sendBtn.titleLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _sendBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _sendBtn;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 42*SCREEN_RADIO, screen_width-30*SCREEN_RADIO, 1)];
        _lineView.backgroundColor=[UIColor getColor:@"D8D8D8"];
    }
    
    return _lineView;
}

@end

