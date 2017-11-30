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
@property(nonatomic,strong)UIButton *following;
@property(nonatomic,strong)UIButton *like;
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
    if ([UIImagePNGRepresentation(sender.currentImage) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"Thumb"])]) {
        [sender setImage:[UIImage imageNamed:@"Thumbed"] forState:UIControlStateNormal];
        [self.like setImage:[UIImage imageNamed:@"Card"] forState:UIControlStateNormal];
        _currentIndex=1;
        [self updateTable];
    }
}

-(void)likeClick:(UIButton *)sender{
    if ([UIImagePNGRepresentation(sender.currentImage) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"Card"])]) {
        [self.following setImage:[UIImage imageNamed:@"Thumb"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"Carded"] forState:UIControlStateNormal];
        _currentIndex=2;
        [self updateTable];
    }
}

-(void)updateTable{
    [self getData];
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

-(UIButton *)following{
    if (!_following) {
        _following=[[UIButton alloc] initWithFrame:CGRectMake(screen_width/4-8*SCREEN_RADIO, 26.5*SCREEN_RADIO-8*SCREEN_RADIO, 16*SCREEN_RADIO, 16*SCREEN_RADIO)];
        [_following setImage:[UIImage imageNamed:@"Thumbed"] forState:UIControlStateNormal];
        [_following addTarget:self action:@selector(followClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _following;
}

-(UIButton *)like{
    if (!_like) {
        _like=[[UIButton alloc] initWithFrame:CGRectMake(screen_width/2+screen_width/4-8*SCREEN_RADIO, 26.5*SCREEN_RADIO-8*SCREEN_RADIO, 16*SCREEN_RADIO, 16*SCREEN_RADIO)];
        [_like setImage:[UIImage imageNamed:@"Card"] forState:UIControlStateNormal];
        [_like addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchUpInside];
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
//        __weak __typeof(self)weakSelf = self;
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
            [[CGSingleCommitData sharedInstance] deletefollow:model.ids];
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
