//
//  MyCommitSViewController.m
//  ChineseGirl
//
//  Created by Wallen on 2017/9/2.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "MyCommitSViewController.h"
#import "MyCommitHeaderView.h"
#import "MycommitModel.h"
#import "EZJFastTableView.h"
#import "myCommitCell.h"
#import "NewsBottomMessage.h"
#import "CGPinglun.h"
#import "CGVipViewController.h"
@interface MyCommitSViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)RkyExtendedHitButton *leftIcon;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *bottomLine;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,strong)NewsBottomMessage *messageView;
@property(nonatomic,copy)NSString *selectNickName;
@end

@implementation MyCommitSViewController



-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}


-(void)setHeaderView{
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.leftIcon];
    [self.view addSubview:self.bottomLine];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setHeaderView];
    [self addSubViews];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)addSubViews{
    [self.view addSubview:self.tbv];
    [self.view addSubview:self.messageView];
}

-(CGFloat)getCellHeightWithModel:(NSDictionary *)dict withIndex:(NSInteger)index{
    
    NSString *contentStr=@"";
    CGFloat _height=50*SCREEN_RADIO;
    
    if (index==0) {
        _height=97;
        CGShuoShuo *shuoshuo=(CGShuoShuo *)dict;
        contentStr=shuoshuo.content;
    }else{
        contentStr=[dict objectForKey:@"content"];
    }

    CGSize constraint = CGSizeMake(screen_width-30*SCREEN_RADIO, 99999.0f);
    CGSize size = [contentStr sizeWithFont:[UIFont systemFontOfSize:14*SCREEN_RADIO] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    _height+=size.height;
 
    
    return _height;
}

-(void)keyboardHide{
//    if ([self.messageView getIsFirstResponder]) {
//        self.messageView.hidden=YES;
//        [self.messageView setFirstResponderAction];
//    }else{
//        self.messageView.hidden=NO;
//        [self.messageView setBeResponderAction];
//    }
}



-(EZJFastTableView *)tbv{
    if (!_tbv) {
        _tbv = [[EZJFastTableView alloc]initWithFrame:CGRectMake(0, 64*SCREEN_RADIO, screen_width, screen_height-64*2*SCREEN_RADIO)];
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        NSMutableArray *pingluns=[[CGPinglun reloadCommits:self.commitModel.pinglunid] mutableCopy];
        [pingluns insertObject:self.commitModel atIndex:0];
        [_tbv setDataArray:pingluns];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            if (index.row==0) {
                MyCommitHeaderView *headerView=[[MyCommitHeaderView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:cellData];
                headerView.userInteractionEnabled = true;
                return (UITableViewCell *)headerView;

            }else{
                myCommitCell *cell=[[myCommitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:cellData];
                cell.userInteractionEnabled = true;
                return (UITableViewCell *)cell;
            }
            
        }];
        
        //动态改变
        __weak typeof(self) weakSelf = self;
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            
            if (indexPath.row==0) {
                return [weakSelf getCellHeightWithModel:cellData withIndex:indexPath.row];
            }else{
                return [weakSelf getCellHeightWithModel:cellData withIndex:indexPath.row];
            }
            
        }];
        

        
        //设置选中事件 block设置方式
        //indexPath  是当前行对象 indexPath.row(获取行数)
        //cellData 是当前行的数据
        
        [_tbv onCellSelected:^(NSIndexPath *indexPath, id cellData) {
            NSLog(@"click");
            weakSelf.selectNickName=[cellData objectForKey:@"nickName"];
            [weakSelf.messageView setMessageContent:[NSString stringWithFormat:@"@%@",[cellData objectForKey:@"nickName"]]];
            
        }];
        

    }
    
    return _tbv;
}


-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 64*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor clearColor];
    }
    
    return _headerView;
}



-(RkyExtendedHitButton *)leftIcon{
    if (!_leftIcon) {
        _leftIcon=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, 35*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_leftIcon setImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_leftIcon addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _leftIcon.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    return _leftIcon;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 29*SCREEN_RADIO, screen_width, 24*SCREEN_RADIO)];
        _titleLabel.text=NSLocalizedString(@"activity", nil);
        _titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLabel.textColor=[UIColor getColor:@"232627"];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine=[[UIView alloc] initWithFrame:CGRectMake(0, 64*SCREEN_RADIO-0.5, screen_width, 0.5)];
        _bottomLine.backgroundColor=[UIColor getColor:@"CED7DB"];
    }
    
    return _bottomLine;
}

-(NewsBottomMessage *)messageView{
    if (!_messageView) {
        __weak __typeof(self)weakSelf = self;
        _messageView=[[NewsBottomMessage alloc] initWithFrame:CGRectMake(0, screen_height-64*SCREEN_RADIO, screen_width, 64*SCREEN_RADIO) withDidBeginEditing:^(UITextView *textView) {

        } withDidSubmitEdit:^(NSString *text) {
            if ([CGSingleCommitData sharedInstance].vipLevel.length>0) {
                NSMutableArray *arr=[[NSMutableArray alloc] init];
                [arr addObject:@{@"nickName":[CGSingleCommitData sharedInstance].nickName,@"Avatar":@"Avatar",@"date":@"2017.9.1 14:30:21",@"content":text}];
                [weakSelf.tbv addContentData:arr];
            }else{
                CGVipViewController *vipVC=[[CGVipViewController alloc] init];
                vipVC.definesPresentationContext = YES;
                vipVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                vipVC.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
                [self presentViewController:vipVC animated:NO completion:nil];
            }
        }];
       
    }
    
    return _messageView;
}



@end
