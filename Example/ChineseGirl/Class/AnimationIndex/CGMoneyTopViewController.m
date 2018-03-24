//
//  CGMoneyTopViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/12/30.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGMoneyTopViewController.h"
#import "EZJFastTableView.h"
#import "CGTopOneTableViewCell.h"
#import "CGTopFullTableViewCell.h"
#import "CGMoneyTopModel.h"
#import "MyIndexViewController.h"
@interface CGMoneyTopViewController ()
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)RkyExtendedHitButton *leftBtn;
@property(nonatomic,strong)RkyExtendedHitButton *moneyTop;
@property(nonatomic,strong)RkyExtendedHitButton *hotTop;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,assign)NSInteger modelType;
@end

@implementation CGMoneyTopViewController

- (void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [MobClick event:RichPage_beginLog];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick event:RichPage_endLog];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modelType=1;
    self.view.backgroundColor=[UIColor getColor:@"171616"];
    [self setNavView];
    [self addSubViews];
}

-(void)setNavView{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.leftBtn];
    [self.headerView addSubview:self.moneyTop];
    [self.headerView addSubview:self.hotTop];
    [self.headerView addSubview:self.lineView];
}

-(void)addSubViews{
    [self.view addSubview:self.tbv];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)moneyTopClick:(UIButton *)sender{
    if (!CGColorEqualToColor(sender.currentTitleColor.CGColor, [UIColor getColor:@"00ffff"].CGColor)) {
        [sender setTitleColor:[UIColor getColor:@"00ffff"] forState:UIControlStateNormal];
        [self.hotTop setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        self.modelType=1;
        [self.tbv updateData:[CGMoneyTopModel reloadTable]];
    }
}

-(void)hotTopClick:(UIButton *)sender{
    if (!CGColorEqualToColor(sender.currentTitleColor.CGColor, [UIColor getColor:@"00ffff"].CGColor)) {
        [sender setTitleColor:[UIColor getColor:@"00ffff"] forState:UIControlStateNormal];
        [self.moneyTop setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        self.modelType=2;
        [self.tbv updateData:[CGMoneyTopModel reloadTable]];
    }
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor getColor:@"171616"];
    }
    
    return _headerView;
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

-(RkyExtendedHitButton *)moneyTop{
    if (!_moneyTop) {
        CGSize constraint = CGSizeMake(screen_width-20*SCREEN_RADIO, 99999.0f);
        CGSize size = [NSLocalizedString(@"fuhaobang", nil) sizeWithFont:[UIFont systemFontOfSize:16.0f*SCREEN_RADIO] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
        _moneyTop=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(100*SCREEN_RADIO, 31.5*SCREEN_RADIO, size.width, 18*SCREEN_RADIO)];
        [_moneyTop setTitle:NSLocalizedString(@"fuhaobang", nil) forState:UIControlStateNormal];
        [_moneyTop setTitleColor:[UIColor getColor:@"00ffff"] forState:UIControlStateNormal];
        _moneyTop.titleLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        [_moneyTop addTarget:self action:@selector(moneyTopClick:) forControlEvents:UIControlEventTouchUpInside];
        _moneyTop.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _moneyTop;
}

-(RkyExtendedHitButton *)hotTop{
    if (!_hotTop) {
        _hotTop=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(screen_width/2, 31.5*SCREEN_RADIO, screen_width/2-100*SCREEN_RADIO, 18*SCREEN_RADIO)];
        [_hotTop setTitle:NSLocalizedString(@"remenbang", nil) forState:UIControlStateNormal];
        [_hotTop setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        _hotTop.titleLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        [_hotTop addTarget:self action:@selector(hotTopClick:) forControlEvents:UIControlEventTouchUpInside];
        [_hotTop setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        _hotTop.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _hotTop;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 64*SCREEN_RADIO-0.5, screen_width, 0.5)];
        _lineView.backgroundColor=[UIColor getColor:@"493D83"];
    }
    
    return _lineView;
}

-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        __weak typeof(self) weakSelf = self;
        CGRect tbvFrame = CGRectMake(0, 64*SCREEN_RADIO, screen_width, screen_height-64*SCREEN_RADIO);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.backgroundColor=[UIColor getColor:@"171616"];
    
        //给tableview赋值
        [_tbv setDataArray:[CGMoneyTopModel reloadTable]];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
        
            UITableViewCell *inCell;
            if (index.row ==0) {
                CGTopOneTableViewCell *cell=[[CGTopOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withModel:cellData withType:self.modelType];
                
                return (UITableViewCell *)cell;
            }else{
                CGTopFullTableViewCell *cell=[[CGTopFullTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withModel:cellData withType:self.modelType];
                return (UITableViewCell *)cell;
            }
            
            return (UITableViewCell *)inCell;
            
        }];
        
        //动态改变
        
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            if (indexPath.row==0) {
                return 294*SCREEN_RADIO;
            }
            
            return 73*SCREEN_RADIO;
        }];
        
        
        
        //设置选中事件 block设置方式
        //indexPath  是当前行对象 indexPath.row(获取行数)
        //cellData 是当前行的数据
        
        [_tbv onCellSelected:^(NSIndexPath *indexPath, id cellData) {
            CGMoneyTopModel *model=(CGMoneyTopModel *)cellData;
            MyIndexViewController *indexVC=[[MyIndexViewController alloc] init];
            NSString *userid;
            if (weakSelf.modelType==1) {
                userid=model.moneyuserid;
            }else{
                userid=model.hotuserid;
            }
            indexVC.ids=[userid integerValue];
            [weakSelf.navigationController pushViewController:indexVC animated:NO];
            
        }];
        
    }
    
    return _tbv;
}
@end
