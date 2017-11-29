//
//  CGFavoriteView.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/29.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGFavoriteView.h"
#import "EZJFastTableView.h"
#import "CGUserInfo.h"
#import "CGFollowTableViewCell.h"
#import "CGIndexModel.h"
#import "XLVideoCell.h"
#import "WSCollectionCell.h"
#import "XLVideoPlayer.h"
@interface CGFavoriteView(){
    CellClickBlock cellClickBlock;
    NSIndexPath *_indexPath;
    NSInteger _currentIndex;  //当前选择tab
}
@property(nonatomic,strong)UIView *menuView;
@property(nonatomic,strong)UIView *topLineView;
@property(nonatomic,strong)UIButton *following;
@property(nonatomic,strong)UIButton *like;
@property(nonatomic,strong)UIView *bottomLineView;
@property(nonatomic,strong)EZJFastTableView *followTableView;
@property(nonatomic,strong)EZJFastTableView *likesTableView;
@property(nonatomic,strong)NSMutableArray *followsArr;
@property(nonatomic,strong)NSMutableArray *likesArr;
@property(nonatomic,strong)XLVideoPlayer *player;
@end
@implementation CGFavoriteView

- (instancetype)initWithFrame:(CGRect)frame withCellBlock:(CellClickBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor getColor:@"F6F6F6"];
        cellClickBlock=block;
        [self setData];
        [self addSubViews];
    }
    return self;
}

-(void)setData{
    _currentIndex=1;
    [self getData];
    [self.followTableView updateData:self.followsArr];
}

-(void)addSubViews{
    [self addSubview:self.menuView];
    [self.menuView addSubview:self.topLineView];
    [self.menuView addSubview:self.following];
    [self.menuView addSubview:self.like];
    [self.menuView addSubview:self.bottomLineView];
    [self addSubview:self.followTableView];
    [self addSubview:self.likesTableView];
    
}

-(void)getData{
    if (_currentIndex==1) {
        [self.followsArr removeAllObjects];
        for (NSString *ids in [CGSingleCommitData sharedInstance].follows) {
            if (ids.length>0) {
                CGUserInfo *userInfo= [CGUserInfo getitemWithID:ids];
                [self.followsArr addObject:userInfo];
            }
        }
    }else if(_currentIndex==2){
        [self.likesArr removeAllObjects];
        for (NSString *ids in [CGSingleCommitData sharedInstance].favourites) {
            if (ids.length>0) {
                CGIndexModel *indexModel= [CGIndexModel reloadTableWithId:[ids integerValue]];
                [self.likesArr addObject:indexModel];
            }
        }
    }
    
}

-(void)followClick:(UIButton *)sender{
    if (!CGColorEqualToColor(sender.currentTitleColor.CGColor, [UIColor getColor:@"157CF8"].CGColor)) {
        [sender setTitleColor:[UIColor getColor:@"157CF8"] forState:UIControlStateNormal];
        [self.like setTitleColor:[UIColor getColor:@"111111"] forState:UIControlStateNormal];
        self.likesTableView.hidden=YES;
        self.followTableView.hidden=NO;
        _currentIndex=1;
        [self updateTable];
    }
}

-(void)likeClick:(UIButton *)sender{
    if (!CGColorEqualToColor(sender.currentTitleColor.CGColor, [UIColor getColor:@"157CF8"].CGColor)) {
        [sender setTitleColor:[UIColor getColor:@"157CF8"] forState:UIControlStateNormal];
        [self.following setTitleColor:[UIColor getColor:@"111111"] forState:UIControlStateNormal];
        self.likesTableView.hidden=NO;
        self.followTableView.hidden=YES;
        _currentIndex=2;
        [self updateTable];
    }
}

-(void)updateTable{
    if (_currentIndex==1) {
        [self getData];
        [self.followTableView updateData:self.followsArr];
    }else if (_currentIndex==2){
        [self getData];
        [self.likesTableView updateData:self.likesArr];
    }
    
}

-(UIView *)menuView{
    if (!_menuView) {
        _menuView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 53*SCREEN_RADIO)];
    }
    
    return _menuView;
}

-(UIView *)topLineView{
    if (!_topLineView) {
        _topLineView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 0.5)];
        _topLineView.backgroundColor=[UIColor getColor:@"111111"];
    }
    
    return _topLineView;
}

-(UIButton *)following{
    if (!_following) {
        _following=[[UIButton alloc] initWithFrame:CGRectMake(0, 26.5*SCREEN_RADIO-7*SCREEN_RADIO, screen_width/2, 14*SCREEN_RADIO)];
        [_following setTitle:@"Following" forState:UIControlStateNormal];
        [_following setTitleColor:[UIColor getColor:@"157CF8"] forState:UIControlStateNormal];
        _following.titleLabel.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        [_following addTarget:self action:@selector(followClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _following;
}

-(UIButton *)like{
    if (!_like) {
        _like=[[UIButton alloc] initWithFrame:CGRectMake(screen_width/2, 26.5*SCREEN_RADIO-7*SCREEN_RADIO, screen_width/2, 14*SCREEN_RADIO)];
        [_like setTitle:@"Likes" forState:UIControlStateNormal];
        [_like setTitleColor:[UIColor getColor:@"111111"] forState:UIControlStateNormal];
        _like.titleLabel.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        [_like addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _like;
}

-(UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView=[[UIView alloc] initWithFrame:CGRectMake(0, 53*SCREEN_RADIO-0.5, screen_width, 0.5)];
        _bottomLineView.backgroundColor=[UIColor getColor:@"111111"];
    }
    
    return _bottomLineView;
}

-(EZJFastTableView *)followTableView{
    if (!_followTableView) {
        
        CGRect tbvFrame = CGRectMake(0, CGRectGetMaxY(self.menuView.frame), screen_width, self.frame.size.height-53*SCREEN_RADIO);
        //初始化
        
        _followTableView = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _followTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _followTableView.scrollEnabled=NO;
        _followTableView.backgroundColor=[UIColor getColor:@"F6F6F6"];
        [_followTableView setDataArray:self.followsArr];
        __weak __typeof(self)weakSelf = self;
        [_followTableView onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            BOOL lineState=NO;
            if (index.row== self.followsArr.count-1) {
                lineState=YES;
            }
            CGFollowTableViewCell *cell=[[CGFollowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withModel:cellData withHidden:lineState];
            
            return cell;
        }];
        
        //动态改变
        
        [_followTableView onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            return 62*SCREEN_RADIO;
        }];
        
        [_followTableView onCellediting:^(NSIndexPath *index, id cellData) {
            CGUserInfo *model=cellData;
            [[CGSingleCommitData sharedInstance] deletefollow:model.ids];
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
        
        [_followTableView onCellSelected:^(NSIndexPath *indexPath, id cellData) {
            NSLog(@"click");
            CGUserInfo *model=cellData;
            if (cellClickBlock) {
                cellClickBlock([model.ids integerValue]);
            }
            
        }];
        
    }
    
    return _followTableView;
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
        }
        return _height;
    }
    
    return 340*SCREEN_RADIO;
}

-(EZJFastTableView *)likesTableView{
    if (!_likesTableView) {
        
        __weak typeof(self) weakSelf = self;
        CGRect tbvFrame = CGRectMake(0, CGRectGetMaxY(self.menuView.frame), screen_width, self.frame.size.height-53*SCREEN_RADIO);
        //初始化
        
        _likesTableView = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _likesTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _likesTableView.backgroundColor=[UIColor getColor:@"F6F6F6"];
        _likesTableView.hidden=YES;
        //给tableview赋值
        [_likesTableView setDataArray:self.likesArr];
        
        [_likesTableView onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            UITableViewCell *inCell;
            CGIndexModel *indexModel=(CGIndexModel *)cellData;
            if ([indexModel.type integerValue]==1) {
                WSCollectionCell *cell = [[WSCollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:indexModel];
                return (UITableViewCell *)cell;
            }else if ([indexModel.type integerValue]==2){
                XLVideoCell *cell = [[XLVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withModel:indexModel withImg:indexModel.videoPic];
                return (UITableViewCell *)cell;
            }
            
            return (UITableViewCell *)inCell;
        }];
        
        //动态改变
        
        [_likesTableView onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            
            if (indexPath.row==0) {
                return 0;
            }
            
            CGFloat _height=[weakSelf getCellHeightWithModel:cellData];
            return _height;
        }];
        
    

        //设置选中事件 block设置方式
        //indexPath  是当前行对象 indexPath.row(获取行数)
        //cellData 是当前行的数据
        
        [_likesTableView onCellSelected:^(NSIndexPath *indexPath, id cellData) {
            NSLog(@"click");
            if (indexPath.row!=0) {
                CGIndexModel *indexModel=(CGIndexModel *)cellData;
                if ([indexModel.type integerValue]==2) {
                    [self showVideoPlayer:indexPath withcellData:cellData];
                }
            }
        }];
        
        [_likesTableView onScrollDid:^(UIScrollView *scrollView) {
            if ([scrollView isEqual:self.likesTableView]) {
                [weakSelf.player playerScrollIsSupportSmallWindowPlay:NO];
            }
        }];
        
    }
    
    return _likesTableView;
}

- (void)showVideoPlayer:(NSIndexPath *)index withcellData:(CGIndexModel *)cellData{
    [_player destroyPlayer];
    _player = nil;
    
    _indexPath = index;
    XLVideoCell *cell = [self.likesTableView cellForRowAtIndexPath:_indexPath];
    // [cell hiddenPlayView:YES];
    
    
    //    //2.将indexPath添加到数组
    //    NSArray <NSIndexPath *> *indexPathArray = @[index];
    //    //3.传入数组，对当前cell进行刷新
    //    [self.tbv reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    __weak typeof(self) weakSelf = self;
    _player = [[XLVideoPlayer alloc] initWithFrame:CGRectMake(0, 56*SCREEN_RADIO, screen_width, 284*SCREEN_RADIO) withVideoPauseBlock:^{
//        CGVideoViewController *videoVC=[[CGVideoViewController alloc] init];
//        videoVC.videoStr=cellData.bigIcon;
//        [weakSelf.navigationController presentViewController:videoVC animated:NO completion:nil];
    } withPlayBlock:^{
        
    }];
    _player.videoUrl = cellData.bigIcon;
    [_player playerBindTableView:self.likesTableView currentIndexPath:_indexPath];
    
    [cell.contentView addSubview:_player];
    
    _player.completedPlayingBlock = ^(XLVideoPlayer *player) {
        [cell hiddenPlayView:NO];
        [player destroyPlayer];
        _player = nil;
    };
    
}


-(NSMutableArray *)followsArr{
    if (!_followsArr) {
        _followsArr=[[NSMutableArray alloc] init];
    }
    
    return _followsArr;
}

-(NSMutableArray *)likesArr{
    if (!_likesArr) {
        _likesArr=[[NSMutableArray alloc] init];
    }
    
    return _likesArr;
}
@end
