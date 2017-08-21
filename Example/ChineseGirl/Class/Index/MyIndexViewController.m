//
//  MyIndexViewController.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/20.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "MyIndexViewController.h"
#import "EZJFastTableView.h"
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

@interface MyIndexViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIButton *leftIcon;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UIScrollView *contentScrollView;
@property(nonatomic,strong)UIView *infoView;
@property(nonatomic,strong)UIImageView *AvatarImgView;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *address;
@property(nonatomic,strong)UIImageView *addressIcon;
@property(nonatomic,strong)UIButton *talkBtn;
@property(nonatomic,strong)UIButton *followingBtn;
@property(nonatomic,strong)UIView *infoLinView;
@property(nonatomic,strong)EZJFastTableView *tbv;
@end

@implementation MyIndexViewController
- (void)viewWillAppear:(BOOL)animated{
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
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addSubViews];
}


-(void)addSubViews{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.leftIcon];
    [self.headerView addSubview:self.leftBtn];
    [self.headerView addSubview:self.rightBtn];
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView addSubview:self.infoView];
    [self.infoView addSubview:self.AvatarImgView];
    [self.infoView addSubview:self.nickName];
    [self.infoView addSubview:self.addressIcon];
    [self.infoView addSubview:self.address];
    [self.infoView addSubview:self.talkBtn];
    [self.infoView addSubview:self.followingBtn];
    [self.infoView addSubview:self.infoLinView];
    [self.contentScrollView addSubview:self.tbv];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)editClick{
    
}

-(void)loveClick{

}

-(void)followingClick{

}

-(void)talkClick{
    
}

-(void)EditClick{

}

-(void)setTableView{

}


-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 53*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor clearColor];
    }
    
    return _headerView;
}

-(UIImageView *)AvatarImgView{
    if (!_AvatarImgView) {
        _AvatarImgView=[[UIImageView alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, 21*SCREEN_RADIO, 115*SCREEN_RADIO, 115*SCREEN_RADIO)];
        _AvatarImgView.image=[UIImage imageNamed:@"Avatar"];
    }
    
    return _AvatarImgView;
}


-(UIButton *)leftIcon{
    if (!_leftIcon) {
        _leftIcon=[[UIButton alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, 33*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_leftIcon setImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_leftIcon addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftIcon;
}

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftIcon.frame)+8*SCREEN_RADIO, 29*SCREEN_RADIO, 45*SCREEN_RADIO, 29*SCREEN_RADIO)];
        [_leftBtn setTitle:@"Back" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor getColor:@"232627"] forState:UIControlStateNormal];
        _leftBtn.titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        [_leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _leftBtn;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 29*SCREEN_RADIO, screen_width, 24*SCREEN_RADIO)];
        _titleLabel.text=@"Profile";
        _titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLabel.textColor=[UIColor getColor:@"232627"];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width-150*SCREEN_RADIO, 29*SCREEN_RADIO, 135*SCREEN_RADIO, 24*SCREEN_RADIO)];
        [_rightBtn setTitle:@"Edit" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor getColor:@"232627"] forState:UIControlStateNormal];
        _rightBtn.titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _rightBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        [_rightBtn addTarget:self action:@selector(EditClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _rightBtn;
}

-(UIScrollView *)contentScrollView{
    if(!_contentScrollView){
        _contentScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), screen_width, screen_height)];
        _contentScrollView.contentSize=CGSizeMake(screen_width, screen_height*2);
    }
    
    return _contentScrollView;
}

-(UIView *)infoView{
    if(!_infoView){
        _infoView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 164.5*SCREEN_RADIO)];
        _infoView.backgroundColor=[UIColor clearColor];
    }
    
    return _infoView;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AvatarImgView.frame)+24*SCREEN_RADIO, 31*SCREEN_RADIO, 0, 27*SCREEN_RADIO)];
        _nickName.font=[UIFont systemFontOfSize:22*SCREEN_RADIO];
        _nickName.text=@"Victoria Phillips";
        _nickName.textColor=[UIColor getColor:@"232627"];
        [_nickName sizeToFit];
    }
    return _nickName;
}

-(UILabel *)address{
    if (!_address) {
        _address=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.addressIcon.frame)+7.5*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+6.5*SCREEN_RADIO, 0, 14*SCREEN_RADIO)];
        _address.font=[UIFont systemFontOfSize:11*SCREEN_RADIO];
        _address.textColor=[UIColor getColor:@"575E62"];
        _address.text=@"MOSCOW, RUSSIA";
        [_address sizeToFit];
    }
    
    return _address;
}

-(UIImageView *)addressIcon{
    if (!_addressIcon) {
        _addressIcon=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AvatarImgView.frame)+52*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+7*SCREEN_RADIO, 9*SCREEN_RADIO, 12.5*SCREEN_RADIO)];
        _addressIcon.image=[UIImage imageNamed:@"myindex_pin"];
    }
    return _addressIcon;
}

-(UIButton *)talkBtn{
    if (!_talkBtn) {
        _talkBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.AvatarImgView.frame)+63*SCREEN_RADIO, CGRectGetMinY(self.AvatarImgView.frame)+76.5*SCREEN_RADIO, 52*SCREEN_RADIO, 52*SCREEN_RADIO)];
        [_talkBtn setBackgroundImage:[UIImage imageNamed:@"Writemessage"] forState:UIControlStateNormal];
        [_talkBtn addTarget:self action:@selector(talkClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _talkBtn;
}



-(UIButton *)followingBtn{
    if (!_followingBtn) {
        _followingBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.talkBtn.frame)+19*SCREEN_RADIO, CGRectGetMaxY(self.address.frame)+19*SCREEN_RADIO, 180*SCREEN_RADIO, 52*SCREEN_RADIO)];
        [_followingBtn setBackgroundImage:[UIImage imageNamed:@"FlatBlue"] forState:UIControlStateNormal];
        [_followingBtn addTarget:self action:@selector(followingClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _followingBtn;
}

-(UIView *)infoLinView{
    if(!_infoLinView){
        _infoLinView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.infoView.frame)-0.5, screen_width, 0.5)];
        _infoLinView.backgroundColor=[UIColor getColor:@"CED7DB"];
    }
    
    return _infoLinView;
}

-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        
        CGRect tbvFrame = CGRectMake(0, CGRectGetMaxY(self.infoView.frame)+19*SCREEN_RADIO, self.view.frame.size.width, self.view.frame.size.height);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        
        NSMutableArray *arrays =[[NSMutableArray alloc] init];
        for (int i = 0; i<6; i++) {
            [arrays insertObject:MJRandomData atIndex:0];
        }
        
        //给tableview赋值
         [_tbv setDataArray:arrays];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.userInteractionEnabled = true;
            cell.textLabel.text = cellData;
            return cell;
        }];
        
        //动态改变
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            
            if (indexPath.row==1) {
                return 100.0;
            }
            if (indexPath.row==4) {
                return 80.0;
            }
            return _tbv.rowHeight;
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
