//
//  IndexViewController.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/8.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "IndexViewController.h"
#import "BHInfiniteScrollView.h"
#import "EZJFastTableView.h"
#import "MyIndexViewController.h"
#import "CGFriendsAddViewController.h"
#import "EZJFastTableView.h"
#import "WSCollectionHeaderCell.h"
#import "CGIndexModel.h"
#import "WSCollectionCell.h"
#import "XLVideoCell.h"
#import <AVFoundation/AVFoundation.h>
#import "CGVideoViewController.h"
#import "CGNewSignInViewController.h"
#import "KNMovieViewController.h"
#import "CGShuoShuo.h"
@interface IndexViewController ()<BHInfiniteScrollViewDelegate,HzfNavigationBarDelegate,UIScrollViewDelegate>{
    NSIndexPath *_indexPath;
    
}
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)RkyExtendedHitButton *rightIcon;
@property(nonatomic,strong)UIImageView *titleImg;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *lineView;
@property (nonatomic, strong)UIView* infinitePageView;
@property (nonatomic, strong)UIImageView *infiniteImgView;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,assign)NSInteger currentPage;
@end

@implementation IndexViewController

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    BOOL isFirstUp =  [[NSUserDefaults standardUserDefaults] objectForKey:@"FirstLoad"];
    if (!isFirstUp) {
        [self LaunchVideo];
        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2.0];
    }else{
        [self delayMethod];
    }
}

-(void)delayMethod{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor=[UIColor getColor:@"EEEEEE"];
    [self setData];
    [self setHeaderView];
    [self addSubViews];
}

-(void)setData{
    _currentPage=1;
    [CGIndexModel reloadTableRondom];
}

-(void)setHeaderView{
    [self.view addSubview:self.headerView];
   // [self.headerView addSubview:self.titleImg];
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.rightIcon];
    [self.view addSubview:self.lineView];
}



- (void)addFriend{
    if ([CGSingleCommitData sharedInstance].uid.length<=0) {
        CGNewSignInViewController *loginVC=[[CGNewSignInViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }else{
        CGFriendsAddViewController *addVC=[[CGFriendsAddViewController alloc] init];
        [self.navigationController pushViewController:addVC animated:NO];
    }
}

-(void)addSubViews{
    [self.view addSubview:self.tbv];
}

-(void)LaunchVideo{

    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLoad"];
    KNMovieViewController *KNVC = [[KNMovieViewController alloc]init];
    NSString *path =  [[NSBundle mainBundle] pathForResource:@"movie.mp4" ofType:nil];
    KNVC.movieURL = [NSURL fileURLWithPath:path];
   // UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:KNVC];
    [self.navigationController presentViewController:KNVC animated:NO completion:nil];
}

- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didScrollToIndex:(NSInteger)index {
    //NSLog(@"did scroll to index %ld", index);
}

- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didSelectItemAtIndex:(NSInteger)index {
    //NSLog(@"did select item at index %ld", index);
}
-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 64*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor whiteColor];
    }
    
    return _headerView;
}

-(RkyExtendedHitButton *)rightIcon{
    if (!_rightIcon) {
        _rightIcon=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(screen_width-32*SCREEN_RADIO, 32*SCREEN_RADIO, 22*SCREEN_RADIO, 22*SCREEN_RADIO)];
        [_rightIcon setImage:[UIImage imageNamed:@"addFriends"] forState:UIControlStateNormal];
        [_rightIcon addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
        _rightIcon.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    return _rightIcon;
}

-(UIImageView *)titleImg{
    if (!_titleImg) {
        _titleImg=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width/2-47*SCREEN_RADIO, 32*SCREEN_RADIO, 94*SCREEN_RADIO, 27*SCREEN_RADIO)];
        _titleImg.image=[UIImage imageNamed:@"BitmapIcon"];
    }
    return _titleImg;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 32*SCREEN_RADIO, screen_width, 30*SCREEN_RADIO)];
        _titleLabel.text=@"ChineseGirl";
        _titleLabel.textColor=[UIColor getColor:@"1D1D1B"];
        _titleLabel.font=[UIFont fontWithName:@"Billabong" size:25*SCREEN_RADIO];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame)-1, screen_width, 1)];
        _lineView.backgroundColor=[UIColor getColor:@"FAFAFA"];
    }
    
    return _lineView;
}

-(void)getCollectionData{
    NSMutableArray *array = [CGIndexModel reloadTableWithRangeFrom:_currentPage*10 rangeTLenth:10];
    if (array.count>0) {
        [self.tbv addContentData:array];
        _currentPage++;
    }else{
        [self.tbv noMoreData];
    }
}

-(void)updateData{
    NSMutableArray *array = [CGIndexModel reloadTableWithRangeFrom:_currentPage*10 rangeTLenth:10];
    if (array.count>0) {
        [self.tbv updateData:array];
        _currentPage++;
    }else{
        [self.tbv noMoreData];
    }
}

-(CGFloat)getCellHeightWithModel:(CGIndexModel*)model{
    if([model.type integerValue]==1){
        CGFloat _height=56*SCREEN_RADIO;
        if (model.pictureBigs.count==1 || model.pictureBigs.count==2) {
            _height+=284*SCREEN_RADIO;
        }else if(model.pictureBigs.count==4){
            _height+=284*SCREEN_RADIO-6*SCREEN_RADIO;
        }else if(model.pictureBigs.count==3){
            _height+=(screen_width-42*SCREEN_RADIO)/3;
        }else if (model.pictureBigs.count==5 || model.pictureBigs.count==6){
            _height+=((screen_width-42*SCREEN_RADIO)/3)*2+6*SCREEN_RADIO;
        }else{
            _height+=((screen_width-42*SCREEN_RADIO)/3)*3+12*SCREEN_RADIO;
        }
        return _height;
    }
    
    return 340*SCREEN_RADIO;
}

-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        __weak typeof(self) weakSelf = self;
        CGRect tbvFrame = CGRectMake(0, 64*SCREEN_RADIO, self.view.frame.size.width, screen_height-104*SCREEN_RADIO);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.backgroundColor=[UIColor getColor:@"EEEEEE"];
        //给tableview赋值
        NSMutableArray *newArr=[CGIndexModel reloadTableWithRangeFrom:0 rangeTLenth:10];
        [newArr insertObject:@"headerView" atIndex:0];
        [_tbv setDataArray:newArr];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            UITableViewCell *inCell;
            if (index.row==0) {
                WSCollectionHeaderCell *cell = [[WSCollectionHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                
                return (UITableViewCell *)cell;
            }else{
                CGShuoShuo *indexModel=(CGShuoShuo *)cellData;
                if ([indexModel.type integerValue]==1) {
                    WSCollectionCell *cell = [[WSCollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:indexModel];
                    return (UITableViewCell *)cell;
                }else if ([indexModel.type integerValue]==2){
                    XLVideoCell *cell = [[XLVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withModel:indexModel withImg:indexModel.videoPicUrl];
                    return (UITableViewCell *)cell;
                }
            }
            
            
            return (UITableViewCell *)inCell;
            
            
            
        }];
        
        //动态改变
        
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            
            if (indexPath.row==0) {
                 return 104*SCREEN_RADIO;
            }
            
            CGFloat _height=[weakSelf getCellHeightWithModel:cellData];
            return _height;
        }];
        
        
        
            //允许上行滑动
            [_tbv onDragUp:^(int page) {
                [weakSelf getCollectionData];
            }];
        
            //允许下行滑动刷新
            [_tbv onDragDown:^{
                weakSelf.currentPage=0;
                [CGIndexModel reloadTableRondom];
                [weakSelf updateData];
            }];
        
        
        //设置选中事件 block设置方式
        //indexPath  是当前行对象 indexPath.row(获取行数)
        //cellData 是当前行的数据
        
        [_tbv onCellSelected:^(NSIndexPath *indexPath, id cellData) {
            NSLog(@"click");
            if (indexPath.row!=0) {
                CGShuoShuo *indexModel=(CGShuoShuo *)cellData;
                if ([indexModel.type integerValue]==2) {
                    CGVideoViewController *videoVC=[[CGVideoViewController alloc] init];
                    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:videoVC];
                    videoVC.videoIcon=indexModel.videoPicUrl;
                    videoVC.videoStr=indexModel.videoUrl;
                    videoVC.uid=indexModel.uid;
                    [weakSelf.navigationController presentViewController:nav animated:NO completion:nil];
                }
            }
        }];
        
        
    }
    
    return _tbv;
}





@end
