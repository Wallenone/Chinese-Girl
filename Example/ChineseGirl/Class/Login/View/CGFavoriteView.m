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
#import "CGShuoShuo.h"
#import "CGFavoriteSectionHeaderCell.h"
@interface CGFavoriteView(){
    CellClickBlock cellClickBlock;
    NSIndexPath *_indexPath;
    NSInteger _currentIndex;  //当前选择tab
    BOOL _fullScreen;  //是否全屏幕
}
@property(nonatomic,strong)UIView *menuView;
@property(nonatomic,strong)UIView *topLineView;
@property(nonatomic,strong)RkyExtendedHitButton *following;
@property(nonatomic,strong)RkyExtendedHitButton *like;
@property(nonatomic,strong)UIView *bottomLineView;
@property(nonatomic,strong)EZJFastTableView *followTableView;
@property(nonatomic,strong)NSMutableArray *followsArr;
@end
@implementation CGFavoriteView

- (instancetype)initWithFrame:(CGRect)frame withCellBlock:(CellClickBlock)block withType:(BOOL)fullScreen;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor getColor:@"F6F6F6"];
        cellClickBlock=block;
        _fullScreen=fullScreen;
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
    
}

-(void)getData{
    [self.followsArr removeAllObjects];
    for (NSString *ids in [CGSingleCommitData sharedInstance].follows) {
        if (ids.length>0) {
            CGUserInfo *userInfo= [CGUserInfo getitemWithID:ids];
            [self.followsArr addObject:userInfo];
        }
    }
}

-(void)followClick:(UIButton *)sender{
    if (CGColorEqualToColor([UIColor getColor:@"575E62"].CGColor, sender.currentTitleColor.CGColor)){
        [sender setTitleColor:[UIColor getColor:@"2979FF"] forState:UIControlStateNormal];
        [self.like setTitleColor:[UIColor getColor:@"575E62"] forState:UIControlStateNormal];
        _currentIndex=1;
        [self updateTable];
    }
}

-(void)likeClick:(UIButton *)sender{
    if (CGColorEqualToColor([UIColor getColor:@"575E62"].CGColor, sender.currentTitleColor.CGColor)){
        [sender setTitleColor:[UIColor getColor:@"2979FF"] forState:UIControlStateNormal];
        [self.following setTitleColor:[UIColor getColor:@"575E62"] forState:UIControlStateNormal];
        _currentIndex=2;
        [self updateFriend];
    }
}

-(void)updateTable{
    [self getData];
    [self.followTableView updateData:self.followsArr];
}

-(void)updateTableItem{
    if (_currentIndex==1) {
        [self updateTable];
    }else if (_currentIndex==2){
        [self updateFriend];
    }
}

-(void)updateFriend{
    [self.followsArr removeAllObjects];
    for (NSString *ids in [CGSingleCommitData sharedInstance].addFriendArr) {
        if (ids.length>0) {
            CGUserInfo *userInfo= [CGUserInfo getitemWithID:ids];
            [self.followsArr addObject:userInfo];
        }
    }
    [self.followTableView updateData:self.followsArr];
}

-(UIView *)menuView{
    if (!_menuView) {
        _menuView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 53*SCREEN_RADIO)];
        _menuView.backgroundColor=[UIColor whiteColor];
    }
    
    return _menuView;
}

-(UIView *)topLineView{
    if (!_topLineView) {
        _topLineView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 0.5)];
        _topLineView.backgroundColor=[UIColor colorWithRed:17/255 green:17/255 blue:17/255 alpha:0.1];
    }
    
    return _topLineView;
}

-(RkyExtendedHitButton *)following{
    if (!_following) {
        _following=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(0, 26.5*SCREEN_RADIO-12*SCREEN_RADIO, screen_width/2, 24*SCREEN_RADIO)];
        [_following setTitle:NSLocalizedString(@"gensuizhe", nil) forState:UIControlStateNormal];
        [_following setTitleColor:[UIColor getColor:@"2979FF"] forState:UIControlStateNormal];
        _following.titleLabel.font=[UIFont boldSystemFontOfSize:24*SCREEN_RADIO];
//        [_following setImage:[UIImage imageNamed:@"Thumbed"] forState:UIControlStateNormal];
        [_following addTarget:self action:@selector(followClick:) forControlEvents:UIControlEventTouchUpInside];
        _following.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _following;
}

-(RkyExtendedHitButton *)like{
    if (!_like) {
        _like=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(screen_width/2, 26.5*SCREEN_RADIO-12*SCREEN_RADIO, screen_width/2, 24*SCREEN_RADIO)];
        [_like setTitle:NSLocalizedString(@"pengyoumeng", nil) forState:UIControlStateNormal];
        [_like setTitleColor:[UIColor getColor:@"575E62"] forState:UIControlStateNormal];
        _like.titleLabel.font=[UIFont boldSystemFontOfSize:24*SCREEN_RADIO];
//        [_like setImage:[UIImage imageNamed:@"Card"] forState:UIControlStateNormal];
        [_like addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchUpInside];
        _like.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _like;
}

-(UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView=[[UIView alloc] initWithFrame:CGRectMake(0, 53*SCREEN_RADIO-0.5, screen_width, 0.5)];
        _bottomLineView.backgroundColor=[UIColor colorWithRed:17/255 green:17/255 blue:17/255 alpha:0.1];
    }
    
    return _bottomLineView;
}

-(EZJFastTableView *)followTableView{
    if (!_followTableView) {
        CGFloat _height=self.frame.size.height-53*SCREEN_RADIO;
        if (!_fullScreen) {
            _height=360*SCREEN_RADIO;
        }
        CGRect tbvFrame = CGRectMake(0, CGRectGetMaxY(self.menuView.frame), screen_width, _height);
        //初始化
        
        _followTableView = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _followTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _followTableView.scrollEnabled=YES;
        _followTableView.backgroundColor=[UIColor getColor:@"F6F6F6"];
        [_followTableView setDataArray:self.followsArr];
        __weak __typeof(self)weakSelf = self;
        [_followTableView onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            if (_currentIndex==1) {
                BOOL lineState=NO;
                if (index.row== self.followsArr.count-1) {
                    lineState=YES;
                }
                CGFollowTableViewCell *cell=[[CGFollowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withModel:cellData withHidden:lineState];
                
                return (UITableViewCell *)cell;
            }else if (_currentIndex==2){
                CGFavoriteSectionHeaderCell *cell=[[CGFavoriteSectionHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:cellData withtouType:2 withAddFriendBlock:^(NSString *avater, NSString *nickname) {
                    
                }];
                
                return (UITableViewCell *)cell;
            }
            
            UITableViewCell *incell;
            
            return incell;
            
        }];
        
        //动态改变
        
        [_followTableView onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            if (_currentIndex==1) {
                return 62*SCREEN_RADIO;
            }
            return 181*SCREEN_RADIO;
        }];
        
        [_followTableView onCellediting:^(NSIndexPath *index, id cellData) {
            CGUserInfo *model=cellData;
            if (_currentIndex==1) {
                [[CGSingleCommitData sharedInstance] deletefollow:model.ids];
            }else if (_currentIndex==2){
                [[CGSingleCommitData sharedInstance] deleteFriendUserid:model.ids];
            }
            [weakSelf.followTableView reloadData];
        }];
        
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

-(NSMutableArray *)followsArr{
    if (!_followsArr) {
        _followsArr=[[NSMutableArray alloc] init];
    }
    
    return _followsArr;
}
@end
