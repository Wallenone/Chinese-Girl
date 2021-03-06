//
//  MyIndexViewController.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/20.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "MyIndexViewController.h"
#import "EZJFastTableView.h"
#import "MyIndexModel.h"
#import "MyIndexCell.h"
#import "myHeaderViewCell.h"
#import "MyCommitSViewController.h"
#import "NewsMessageController.h"
#import "CGShuoShuo.h"
#import "CGUserInfo.h"
#import "CGVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CGVipViewController.h"
#import "CGNetworkData.h"
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

@interface MyIndexViewController (){
    NSIndexPath *_indexPath;
}
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)RkyExtendedHitButton *leftBtn;
@property(nonatomic,strong)UIView *infoView;
@property(nonatomic,strong)UIView *bottomLine;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,assign)NSInteger currentPage;
@end

@implementation MyIndexViewController
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
    _currentPage=1;
    self.view.backgroundColor=[UIColor getColor:@"EEEEEE"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addSubViews];
    [CGNetworkData postData:@{@"page":@"1",@"pagenum":@"10"} withUrl:@"https://www.llstudy.com/zxt/cg/v-list.aspx"];
}


-(void)addSubViews{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.leftBtn];
    [self.view addSubview:self.tbv];
    //[self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.3];
    
}

-(void)back{
   // [self.navigationController popViewControllerAnimated:YES];
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    
    if (viewcontrollers.count > 1)
    {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self)
        {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        //present方式
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


-(void)loveClick{

}


-(void)setTableView{

}



-(CGFloat)getCellHeightWithModel:(CGShuoShuo*)model{
    if([model.type integerValue]==1){
        CGFloat _height=194*SCREEN_RADIO;
        if(model.shuoshuoContent.length>0){
            CGSize constraint = CGSizeMake(screen_width-20*SCREEN_RADIO, 99999.0f);
            CGSize size = [model.shuoshuoContent sizeWithFont:[UIFont systemFontOfSize:13.0f*SCREEN_RADIO] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
            _height+=size.height;
        }
        
        if (model.pictures.count==1 || model.pictures.count==2) {
            _height+=284*SCREEN_RADIO;
        }else if(model.pictures.count==4){
            _height+=284*SCREEN_RADIO-6*SCREEN_RADIO;
        }else if(model.pictures.count==3){
            _height+=(screen_width-42*SCREEN_RADIO)/3;
        }else if (model.pictures.count==5 || model.pictures.count==6){
            _height+=((screen_width-42*SCREEN_RADIO)/3)*2+6*SCREEN_RADIO;
        }else if (model.pictures.count==7 || model.pictures.count==8 || model.pictures.count==9){
            _height+=(screen_width-42*SCREEN_RADIO)+12*SCREEN_RADIO;
        }
        
        
        return _height;
    }else if ([model.type integerValue]==2){
        CGFloat _height=194*SCREEN_RADIO;
        if(model.shuoshuoContent.length>0){
            CGSize constraint = CGSizeMake(screen_width-20*SCREEN_RADIO, 99999.0f);
            CGSize size = [model.shuoshuoContent sizeWithFont:[UIFont systemFontOfSize:13.0f*SCREEN_RADIO] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
            _height+=size.height;
        }
        
        _height+=284*SCREEN_RADIO;
        
        return _height;
    }
    
    return 0;
}

-(void)getCollectionData{
    NSMutableArray *array = [CGShuoShuo reloadTableWithUid:(int)self.ids WithRangeFrom:(int)_currentPage*10 rangeTLenth:10];
    if (array.count>0) {
        [self.tbv addContentData:array];
        _currentPage++;
    }else{
        [self.tbv noMoreData];
    }
    
    [CGNetworkData postData:@{@"page":@(_currentPage),@"pagenum":@"10"} withUrl:@"https://www.llstudy.com/zxt/cg/v-list.aspx"];
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor getColor:@"171616"];
    }
    
    return _headerView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        CGUserInfo *model=[CGUserInfo getitemWithID:[NSString stringWithFormat:@"%ld",(long)self.ids]];
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 28.5*SCREEN_RADIO, screen_width, 24*SCREEN_RADIO)];
        _titleLabel.text=model.nickname;
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



-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        __weak typeof(self) weakSelf = self;
        CGRect tbvFrame = CGRectMake(0, 64*SCREEN_RADIO, self.view.frame.size.width, screen_height-64*SCREEN_RADIO);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.backgroundColor=[UIColor getColor:@"171616"];
        NSMutableArray *newarr=[CGShuoShuo reloadTableWithUid:(int)self.ids WithRangeFrom:0 rangeTLenth:10];
        [newarr insertObject:[CGUserInfo getitemWithID:[NSString stringWithFormat:@"%ld",(long)self.ids]] atIndex:0];
        //给tableview赋值
         [_tbv setDataArray:newarr];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            UITableViewCell *inCell;
            if (index.row ==0) {
                myHeaderViewCell *myHeaderCell=[[myHeaderViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:cellData withTalkCallBack:^(CGUserInfo *info){
                    if ([CGSingleCommitData sharedInstance].isDebug) {
                        NewsMessageController *newsMessageVC=[[NewsMessageController alloc] init];
                        newsMessageVC.userid=info.ids;
                        newsMessageVC.myIndexModel=[[CGSingleCommitData sharedInstance] getNewSubListWithUserid:info.ids];
                        [weakSelf.navigationController pushViewController:newsMessageVC animated:NO];
                    }else{
                        if ([CGSingleCommitData sharedInstance].vipLevel.length>0) {
                            NewsMessageController *newsMessageVC=[[NewsMessageController alloc] init];
                            newsMessageVC.userid=info.ids;
                            newsMessageVC.myIndexModel=[[CGSingleCommitData sharedInstance] getNewSubListWithUserid:info.ids];
                            [weakSelf.navigationController pushViewController:newsMessageVC animated:NO];
                        }else{
                            CGVipViewController *vipVC=[[CGVipViewController alloc] init];
                            vipVC.definesPresentationContext = YES;
                            vipVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                            vipVC.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
                            [self presentViewController:vipVC animated:NO completion:nil];
                        }
                    }
                    
                    
                }];
                
                return (UITableViewCell *)myHeaderCell;
            }else{
                    MyIndexCell *myIndexCell = [[MyIndexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:cellData withCommitClick:^{
                        MyCommitSViewController *myCommitVC=[[MyCommitSViewController alloc] init];
                        myCommitVC.commitModel=cellData;
                        [strongSelf.navigationController pushViewController:myCommitVC animated:NO];
                    }];
                    return (UITableViewCell *)myIndexCell;
             
            }
            
            return (UITableViewCell *)inCell;
            
        }];
        
        //动态改变
        
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            if (indexPath.row==0) {
                return 141*SCREEN_RADIO;
            }
            CGFloat _height=[weakSelf getCellHeightWithModel:cellData];
            return _height;
        }];
        
        
        
        //允许上行滑动
        [_tbv onDragUp:^(int page) {
            [weakSelf getCollectionData];
        }];
        
        
        //设置选中事件 block设置方式
        //indexPath  是当前行对象 indexPath.row(获取行数)
        //cellData 是当前行的数据
        
        [_tbv onCellSelected:^(NSIndexPath *indexPath, id cellData) {
            NSLog(@"click");
            if (indexPath.row!=0) {
                CGShuoShuo *indexModel=(CGShuoShuo *)cellData;
                if ([indexModel.type integerValue]==2) {
                    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
                    for (UIViewController *vc in marr) {
                        if ([vc isKindOfClass:[CGVideoViewController class]]) {
                            [marr removeObject:vc];
                            break;
                        }
                    }
                    self.navigationController.viewControllers = marr;
                    CGVideoViewController *videoVC=[[CGVideoViewController alloc] init];
                    videoVC.videoStr=indexModel.videoUrl;
                    videoVC.videoIcon=indexModel.videoPicUrl;
                    videoVC.uid=indexModel.uid;
                    [weakSelf.navigationController presentViewController:videoVC animated:NO completion:nil];
                    
                }
            }
            
        }];
        
    }
    
    return _tbv;
}



@end
