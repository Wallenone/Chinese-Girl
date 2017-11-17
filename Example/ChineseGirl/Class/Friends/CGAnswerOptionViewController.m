//
//  CGAnswerOptionViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/15.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGAnswerOptionViewController.h"
#import "EZJFastTableView.h"
#import "CGOptionsTableViewCell.h"
#import "CGAnswerModel.h"
#import "CGAnswerResultView.h"
#import "CGVipViewController.h"
@interface CGAnswerOptionViewController (){
    
}
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *answerView1;
@property(nonatomic,strong)UIButton *answerBtn1;
@property(nonatomic,strong)UILabel *answerNum1;
@property(nonatomic,strong)UIView *answerView2;
@property(nonatomic,strong)UIButton *answerBtn2;
@property(nonatomic,strong)UILabel *answerNum2;
@property(nonatomic,strong)UIView *answerView3;
@property(nonatomic,strong)UIButton *answerBtn3;
@property(nonatomic,strong)UILabel *answerNum3;
@property(nonatomic,strong)UIImageView *avater;
@property(nonatomic,strong)UILabel *anwerContent;
@property(nonatomic,strong)UILabel *tipsChooseLabel;
@property(nonatomic,strong)UIButton *leftIcon;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,strong)NSMutableArray *answerArr;
@property(nonatomic,assign)NSInteger answerNum;
@property(nonatomic,strong)CGAnswerResultView *answerResultView;
@end

@implementation CGAnswerOptionViewController

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor getColor:@"FAF1E5"];
    [self setData];
    [self getModelData:0];
    [self addHeaderView];
    [self addSubViews];
}

-(void)setData{
    self.answerNum=0;
    self.answerArr=[CGAnswerModel reloadTable];
}

-(CGAnswerModel *)getModelData:(NSInteger)num{
    CGAnswerModel *model=[self.answerArr objectAtIndex:num];
    return model;
}

-(void)addHeaderView{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.leftIcon];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}


-(void)addSubViews{
    [self.view addSubview:self.answerView1];
    [self.answerView1 addSubview:self.answerNum1];
    [self.view addSubview:self.answerBtn1];
    [self.view addSubview:self.answerView2];
    [self.answerView2 addSubview:self.answerNum2];
    [self.view addSubview:self.answerBtn2];
    [self.view addSubview:self.answerView3];
    [self.answerView3 addSubview:self.answerNum3];
    [self.view addSubview:self.answerBtn3];
    [self.view addSubview:self.avater];
    [self.view addSubview:self.anwerContent];
    [self.view addSubview:self.tipsChooseLabel];
    [self.view addSubview:self.tbv];
}

-(void)setAnswerView{
    
}

-(void)answerClick1{
    [self.tbv updateData:[self getModelData:0].answerArr];
    [self setAnswerContent:[self getModelData:0].title];
    self.answerView1.backgroundColor=[UIColor getColor:@"FF8D00"];
    self.answerNum1.textColor=[UIColor getColor:@"FFD169"];
    self.answerView2.backgroundColor=[UIColor getColor:@"DEE2DD"];
    self.answerNum2.textColor=[UIColor getColor:@"ffffff"];
    self.answerView3.backgroundColor=[UIColor getColor:@"E4E9E5"];
    self.answerNum3.textColor=[UIColor getColor:@"ffffff"];
}

-(void)answerClick2{
    [self.tbv updateData:[self getModelData:1].answerArr];
    [self setAnswerContent:[self getModelData:1].title];
    self.answerView1.backgroundColor=[UIColor getColor:@"E4E9E5"];
    self.answerNum1.textColor=[UIColor getColor:@"ffffff"];
    self.answerView2.backgroundColor=[UIColor getColor:@"FF8D00"];
    self.answerNum2.textColor=[UIColor getColor:@"FFD169"];
    self.answerView3.backgroundColor=[UIColor getColor:@"E4E9E5"];
    self.answerNum3.textColor=[UIColor getColor:@"ffffff"];
}

-(void)answerClick3{
    [self.tbv updateData:[self getModelData:2].answerArr];
    [self setAnswerContent:[self getModelData:2].title];
    self.answerView1.backgroundColor=[UIColor getColor:@"E4E9E5"];
    self.answerNum1.textColor=[UIColor getColor:@"ffffff"];
    self.answerView2.backgroundColor=[UIColor getColor:@"DEE2DD"];
    self.answerNum2.textColor=[UIColor getColor:@"ffffff"];
    self.answerView3.backgroundColor=[UIColor getColor:@"FF8D00"];
    self.answerNum3.textColor=[UIColor getColor:@"FFD169"];
}

-(void)answerResult{
    
}

-(void)setAnswerContent:(NSString *)text{
    self.anwerContent.frame=CGRectMake(CGRectGetMaxX(self.avater.frame)+6*SCREEN_RADIO, CGRectGetMaxY(self.answerView1.frame)+40*SCREEN_RADIO, screen_width-70*SCREEN_RADIO, 42*SCREEN_RADIO);
    self.anwerContent.text=text;
    self.anwerContent.numberOfLines=2;
    self.anwerContent.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.anwerContent setContentMode:UIViewContentModeTop];
    [self.anwerContent sizeToFit];
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
        _titleLabel.text=@"新朋友";
        _titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLabel.textColor=[UIColor getColor:@"232627"];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIView *)answerView1{
    if (!_answerView1) {
        _answerView1=[[UIView alloc] initWithFrame:CGRectMake(0, 60*SCREEN_RADIO, screen_width/3, 50*SCREEN_RADIO)];
        _answerView1.backgroundColor=[UIColor getColor:@"FF8D00"];
    }
    
    return _answerView1;
}

-(UILabel *)answerNum1{
    if (!_answerNum1) {
        _answerNum1=[[UILabel alloc] initWithFrame:CGRectMake(20*SCREEN_RADIO, 30*SCREEN_RADIO, 0, 15*SCREEN_RADIO)];
        _answerNum1.text=@"问题1";
        _answerNum1.textColor=[UIColor getColor:@"FFD169"];
        _answerNum1.font=[UIFont systemFontOfSize:15*SCREEN_RADIO];
        [_answerNum1 sizeToFit];
    }
    
    return _answerNum1;
}

-(UIButton *)answerBtn1{
    if (!_answerBtn1) {
        _answerBtn1=[[UIButton alloc] initWithFrame:CGRectMake(0, 60*SCREEN_RADIO, screen_width/3, 50*SCREEN_RADIO)];
        [_answerBtn1 addTarget:self action:@selector(answerClick1) forControlEvents:UIControlEventTouchUpInside];
        _answerBtn1.userInteractionEnabled=NO;
    }
    return _answerBtn1;
}

-(UIView *)answerView2{
    if (!_answerView2) {
        _answerView2=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.answerView1.frame), 60*SCREEN_RADIO, screen_width/3, 50*SCREEN_RADIO)];
        _answerView2.backgroundColor=[UIColor getColor:@"DEE2DD"];
    }
    
    return _answerView2;
}

-(UILabel *)answerNum2{
    if (!_answerNum2) {
        _answerNum2=[[UILabel alloc] initWithFrame:CGRectMake(20*SCREEN_RADIO, 30*SCREEN_RADIO, 0, 15*SCREEN_RADIO)];
        _answerNum2.text=@"问题2";
        _answerNum2.textColor=[UIColor getColor:@"ffffff"];
        _answerNum2.font=[UIFont systemFontOfSize:15*SCREEN_RADIO];
        [_answerNum2 sizeToFit];
    }
    
    return _answerNum2;
}

-(UIButton *)answerBtn2{
    if (!_answerBtn2) {
        _answerBtn2=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.answerView1.frame), 60*SCREEN_RADIO, screen_width/3, 50*SCREEN_RADIO)];
        [_answerBtn2 addTarget:self action:@selector(answerClick2) forControlEvents:UIControlEventTouchUpInside];
        _answerBtn2.userInteractionEnabled=NO;
    }
    return _answerBtn2;
}

-(UIView *)answerView3{
    if (!_answerView3) {
        _answerView3=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.answerView2.frame), 60*SCREEN_RADIO, screen_width/3, 50*SCREEN_RADIO)];
        _answerView3.backgroundColor=[UIColor getColor:@"E4E9E5"];
    }
    
    return _answerView3;
}

-(UILabel *)answerNum3{
    if (!_answerNum3) {
        _answerNum3=[[UILabel alloc] initWithFrame:CGRectMake(20*SCREEN_RADIO, 30*SCREEN_RADIO, 0, 15*SCREEN_RADIO)];
        _answerNum3.text=@"问题3";
        _answerNum3.textColor=[UIColor getColor:@"ffffff"];
        _answerNum3.font=[UIFont systemFontOfSize:15*SCREEN_RADIO];
        [_answerNum3 sizeToFit];
    }
    
    return _answerNum3;
}


-(UIButton *)answerBtn3{
    if (!_answerBtn3) {
        _answerBtn3=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.answerView2.frame), 60*SCREEN_RADIO, screen_width/3, 50*SCREEN_RADIO)];
        [_answerBtn3 addTarget:self action:@selector(answerClick3) forControlEvents:UIControlEventTouchUpInside];
        _answerBtn3.userInteractionEnabled=NO;
    }
    return _answerBtn3;
}

-(UIImageView *)avater{
    if (!_avater) {
        _avater=[[UIImageView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, CGRectGetMaxY(self.answerView1.frame)+40*SCREEN_RADIO, 42*SCREEN_RADIO, 42*SCREEN_RADIO)];
        [_avater sd_setImageWithURL:[NSURL URLWithString:self.avaterUrl]];
    }
    return _avater;
}

-(UILabel *)anwerContent{
    if (!_anwerContent) {
        _anwerContent=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avater.frame)+6*SCREEN_RADIO, CGRectGetMaxY(self.answerView1.frame)+40*SCREEN_RADIO, screen_width-70*SCREEN_RADIO, 42*SCREEN_RADIO)];
        _anwerContent.text= [self getModelData:0].title;
        _anwerContent.textColor=[UIColor blackColor];
        _anwerContent.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        _anwerContent.numberOfLines=2;
        _anwerContent.lineBreakMode = NSLineBreakByTruncatingTail;
        [_anwerContent setContentMode:UIViewContentModeTop];
        [_anwerContent sizeToFit];
    }
    
    return _anwerContent;
}

-(UILabel *)tipsChooseLabel{
    if (!_tipsChooseLabel) {
        _tipsChooseLabel=[[UILabel alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, CGRectGetMaxY(self.avater.frame)+40*SCREEN_RADIO, 0, 14*SCREEN_RADIO)];
        _tipsChooseLabel.text=@"请选出一个正确答案";
        _tipsChooseLabel.textColor=[UIColor getColor:@"8e8e8e"];
        _tipsChooseLabel.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        [_tipsChooseLabel sizeToFit];
    }
    
    return _tipsChooseLabel;
}

-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        CGRect tbvFrame = CGRectMake(15*SCREEN_RADIO, CGRectGetMaxY(self.tipsChooseLabel.frame)+15*SCREEN_RADIO, self.view.frame.size.width-30*SCREEN_RADIO, 248*SCREEN_RADIO);
        //初始化
        
        _tbv.backgroundColor=[UIColor getColor:@"FAF1E5"];
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.scrollEnabled=NO;
        _tbv.layer.cornerRadius=5*SCREEN_RADIO;
        [_tbv setDataArray:[self getModelData:0].answerArr];
        __weak __typeof(self)weakSelf = self;
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            CGOptionsTableViewCell *cell=[[CGOptionsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier WithModel:cellData withPage:index.row];
            
            return cell;
        }];
        
        //动态改变
        
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            return 62*SCREEN_RADIO;
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
            if (weakSelf.answerNum==0) {
                [self answerClick2];
                weakSelf.answerNum=1;
            }else if (weakSelf.answerNum==1){
                [self answerClick3];
                weakSelf.answerNum=2;
            }else if (weakSelf.answerNum==2){
                weakSelf.answerNum=3;
                weakSelf.titleLabel.text=@"匹配结果";
                [weakSelf.view addSubview:weakSelf.answerResultView];
            }
            
        }];
        
    }
    
    return _tbv;
}

-(CGAnswerResultView *)answerResultView{
    if (!_answerResultView) {
        __weak __typeof(self)weakSelf = self;
        _answerResultView=[[CGAnswerResultView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), screen_width, SCREEN_HEIGHT-60*SCREEN_RADIO) withleftAvater:self.avaterUrl withNickName:self.nickNameStr withTalkBlock:^{
            
        } withVipBlock:^{
            CGVipViewController *vipVC=[[CGVipViewController alloc] init];
            [weakSelf.navigationController pushViewController:vipVC animated:NO];
        }];
        _answerResultView.backgroundColor=[UIColor whiteColor];
    }
    
    return _answerResultView;
}


@end
