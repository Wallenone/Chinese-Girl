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
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

@interface MyIndexViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIButton *leftIcon;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *infoView;
@property(nonatomic,strong)UIView *bottomLine;
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
    self.view.backgroundColor=[UIColor getColor:@"f0f1f2"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addSubViews];
}


-(void)addSubViews{
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.bottomLine];
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.leftIcon];
    [self.view addSubview:self.tbv];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)loveClick{

}


-(void)setTableView{

}


-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 60*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor whiteColor];
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
        _titleLabel.text=NSLocalizedString(@"profile", nil);
        _titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLabel.textColor=[UIColor getColor:@"232627"];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLabel;
}


-(UIView *)infoView{
    if(!_infoView){
        _infoView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 164.5*SCREEN_RADIO)];
        _infoView.backgroundColor=[UIColor clearColor];
    }
    
    return _infoView;
}


-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine=[[UIView alloc] initWithFrame:CGRectMake(0, 63.5, screen_width, 0.5)];
        _bottomLine.backgroundColor=[UIColor getColor:@"CED7DB"];
    }
    
    return _bottomLine;
}



-(CGFloat)getCellHeightWithModel:(MyIndexModel*)model{
    CGFloat _height=215*SCREEN_RADIO;
    if(model.content.length>0){
        CGSize constraint = CGSizeMake(screen_width-30*SCREEN_RADIO, 99999.0f);
        CGSize size = [model.content sizeWithFont:[UIFont systemFontOfSize:17.0f*SCREEN_RADIO] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
        _height+=size.height;
    }
    
    if (model.pictures.count>0) {
        NSUInteger row = model.pictures.count/3;
        CGFloat picHeight= (screen_width-42*SCREEN_RADIO)/3;
        _height+=row*(picHeight+6*SCREEN_RADIO);
        if (model.pictures.count%3>0) {
            _height+=picHeight;
        }
        
    }
    
    
    return _height;
}

-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        __weak typeof(self) weakSelf = self;
        CGRect tbvFrame = CGRectMake(0, 64, self.view.frame.size.width, screen_height-64);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        NSMutableArray *newarr=[CGShuoShuo reloadTableWithId:self.ids];
        [newarr insertObject:[CGUserInfo getitemWithID:[NSString stringWithFormat:@"%ld",(long)self.ids]] atIndex:0];
        //给tableview赋值
         [_tbv setDataArray:newarr];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            NSLog(@"row:=%ld",(long)index.row);
            NSLog(@"section:=%ld",(long)index.section);
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if (index.row ==0) {
                myHeaderViewCell *myHeaderCell=[[myHeaderViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:cellData withTalkCallBack:^{
                    NewsMessageController *newsMessageVC=[[NewsMessageController alloc] init];
                    [weakSelf.navigationController pushViewController:newsMessageVC animated:NO];
                }];
                
                return (UITableViewCell *)myHeaderCell;
            }else{
                MyIndexCell *myIndexCell = [[MyIndexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:cellData withCommitClick:^{
                    MyCommitSViewController *myCommitVC=[[MyCommitSViewController alloc] init];
                    myCommitVC.commitModel=cellData;
                    [strongSelf.navigationController pushViewController:myCommitVC animated:NO];
                }];
                myIndexCell.userInteractionEnabled = true;
               // myIndexCell.backgroundColor=[UIColor purpleColor];
                return (UITableViewCell *)myIndexCell;
            }
            
            
            
        }];
        
        //动态改变
        
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            if (indexPath.row==0) {
                return 164.5*SCREEN_RADIO;
            }
            CGFloat _height=[weakSelf getCellHeightWithModel:cellData];
            return _height;
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
