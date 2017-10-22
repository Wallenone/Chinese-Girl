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
@interface MyCommitSViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIButton *leftIcon;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *bottomLine;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,strong)NewsBottomMessage *messageView;
@property(nonatomic,strong)MycommitModel *TouchModel;   //点击选中的model
@end

@implementation MyCommitSViewController



-(void)viewWillAppear:(BOOL)animated
{
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

-(CGFloat)getCellHeightWithModel:(MycommitModel *)model withIndex:(NSInteger)index{
    CGFloat _height=50*SCREEN_RADIO;
    
    if (index==0) {
        _height=97;
    }

    CGSize constraint = CGSizeMake(screen_width-30*SCREEN_RADIO, 99999.0f);
    CGSize size = [model.content sizeWithFont:[UIFont systemFontOfSize:14*SCREEN_RADIO] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
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
        _tbv = [[EZJFastTableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64)];
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        NSMutableArray *arrays=[[NSMutableArray alloc] init];
        for (int i=0; i<3; i++) {
            MycommitModel *model=[[MycommitModel alloc] init];
            model.icon=@"Avatar";
            model.nickName=[NSString stringWithFormat:@"Wallen%d",i];
            model.date=@"2017.9.1 14:30:21";
            model.content=[NSString stringWithFormat:@"%d-哈哈，说的不错了啊！Lorem ipsum",i];
            [arrays addObject:model];
        }
        
         [_tbv setDataArray:arrays];
        
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
            weakSelf.TouchModel=cellData;
            if ([weakSelf.messageView getIsFirstResponder]) {
                weakSelf.messageView.hidden=YES;
                [weakSelf.messageView setFirstResponderAction];
            }else{
                weakSelf.messageView.hidden=NO;
                [weakSelf.messageView setBeResponderAction];
            }
        
            
        }];
        

    }
    
    return _tbv;
}


-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 53*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor clearColor];
    }
    
    return _headerView;
}



-(UIButton *)leftIcon{
    if (!_leftIcon) {
        _leftIcon=[[UIButton alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, 33*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_leftIcon setImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_leftIcon addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftIcon;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 29*SCREEN_RADIO, screen_width, 24*SCREEN_RADIO)];
        _titleLabel.text=@"Activity";
        _titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLabel.textColor=[UIColor getColor:@"232627"];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine=[[UIView alloc] initWithFrame:CGRectMake(0, 63.5, screen_width, 0.5)];
        _bottomLine.backgroundColor=[UIColor getColor:@"CED7DB"];
    }
    
    return _bottomLine;
}

-(NewsBottomMessage *)messageView{
    if (!_messageView) {
        __weak __typeof(self)weakSelf = self;
        _messageView=[[NewsBottomMessage alloc] initWithFrame:CGRectMake(0, screen_height-60*SCREEN_RADIO, screen_width, 60*SCREEN_RADIO) withDidBeginEditing:^(UITextView *textView) {
            //CGRect frame = textView.frame;
            int offset = (59*SCREEN_RADIO+216.0);//键盘高度216
            
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            
            [UIView setAnimationDuration:0.30f];//动画持续时间
            
            if (offset>0) {
                //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
                weakSelf.messageView.frame = CGRectMake(0.0f, screen_height-offset, screen_width, 59*SCREEN_RADIO);
            }
            [UIView commitAnimations];
        } withDidSubmitEdit:^(NSString *text) {
            weakSelf.messageView.hidden=YES;
            
            NSMutableArray *arr=[[NSMutableArray alloc] init];
            MycommitModel *t_model=[[MycommitModel alloc] init];
            t_model.icon=@"Avatar";
            t_model.nickName=@"Wallen";
            t_model.date=@"2017.9.1 14:30:21";
            t_model.content=[NSString stringWithFormat:@"回复%@:%@",weakSelf.TouchModel.nickName,text];
            [arr addObject:t_model];
            
            
            [weakSelf.tbv addContentData:arr];
            
        }];
        _messageView.hidden=YES;
    }
    
    return _messageView;
}



@end
