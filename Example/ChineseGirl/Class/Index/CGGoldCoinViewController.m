//
//  CGGoldCoinViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/12/18.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//


#import "CGGoldCoinViewController.h"

@interface CGGoldCoinViewController (){
    OnBuyBack onBuyBack;
}
@property(nonatomic,strong)UIView *diView;
@property(nonatomic,strong)UIButton *leftIcon;
@property(nonatomic,strong)UIView *item1;
@property(nonatomic,strong)UIView *item2;
@property(nonatomic,strong)UIView *item3;
@property(nonatomic,strong)UIView *item4;
@property(nonatomic,strong)UIView *item5;
@property(nonatomic,strong)UIImageView *mineMoneyIcon;
@property(nonatomic,strong)UILabel *mineMoneyLabel;
@end

@implementation CGGoldCoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
}

-(void)onBuyBack:(OnBuyBack)block{
    onBuyBack=block;
}

-(void)addSubViews{
    [self.view addSubview:self.diView];
    [self.diView addSubview:self.leftIcon];
    [self.diView addSubview:self.item1];
    [self.diView addSubview:self.item2];
    [self.diView addSubview:self.item3];
    [self.diView addSubview:self.item4];
    [self.diView addSubview:self.item5];
    [self.diView addSubview:self.mineMoneyIcon];
    [self.diView addSubview:self.mineMoneyLabel];
}

-(void)back{
    if (onBuyBack) {
        onBuyBack();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)btnClick:(UIButton *)sender{
    if (sender.tag==1001) {  //$0.99
        [CGSingleCommitData sharedInstance].goldNum+=79;
    }else if (sender.tag==1002){ //$9.99
        [CGSingleCommitData sharedInstance].goldNum+=819;
    }else if (sender.tag==1003){ //$99.99
        [CGSingleCommitData sharedInstance].goldNum+=8499;
    }else if (sender.tag==1004){ //$4.99
        [CGSingleCommitData sharedInstance].goldNum+=399;
    }else if (sender.tag==1005){  //$49.99
        [CGSingleCommitData sharedInstance].goldNum+=4199;
    }
    self.mineMoneyLabel.text=[NSString stringWithFormat:@"%ld",(long)[CGSingleCommitData sharedInstance].goldNum];
    [self.mineMoneyLabel sizeToFit];
}

-(UIView *)diView{
    if (!_diView) {
        _diView=[[UIView alloc] initWithFrame:CGRectMake(0, screen_height-250*SCREEN_RADIO, screen_width, 250*SCREEN_RADIO)];
        _diView.backgroundColor=[UIColor whiteColor];
    }
    
    return _diView;
}

-(UIButton *)leftIcon{
    if (!_leftIcon) {
        _leftIcon=[[UIButton alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 15*SCREEN_RADIO, 10*SCREEN_RADIO, 16*SCREEN_RADIO)];
        [_leftIcon setImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_leftIcon addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftIcon;
}

-(UIView *)item1{
    if (!_item1) {
        _item1=[[UIView alloc] initWithFrame:CGRectMake(20*SCREEN_RADIO, CGRectGetMaxY(self.leftIcon.frame)+15*SCREEN_RADIO, (screen_width-60*SCREEN_RADIO)/3, (screen_width-60*SCREEN_RADIO)/4)];
        _item1.layer.borderColor=[UIColor getColor:@"dcdcdc"].CGColor;
        _item1.layer.borderWidth=1;
        _item1.layer.cornerRadius=10*SCREEN_RADIO;
        UIImageView * icon=[[UIImageView alloc]initWithFrame:CGRectMake(20*SCREEN_RADIO, 25*SCREEN_RADIO, 12*SCREEN_RADIO, 12*SCREEN_RADIO)];
        icon.image=[UIImage imageNamed:@"leaderboard_coin"];
        [_item1 addSubview:icon];
        
        UILabel *goldNum=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame)+5*SCREEN_RADIO, 24*SCREEN_RADIO, 0, 12*SCREEN_RADIO)];
        goldNum.text=@"69";
        goldNum.textColor=[UIColor getColor:@"666666"];
        goldNum.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        [goldNum sizeToFit];
        [_item1 addSubview:goldNum];
        
        UILabel *addNum=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(goldNum.frame)+6*SCREEN_RADIO, 26*SCREEN_RADIO, 0, 10*SCREEN_RADIO)];
        addNum.text=@"+ 10";
        addNum.textColor=[UIColor getColor:@"f3b80c"];
        addNum.font=[UIFont systemFontOfSize:10*SCREEN_RADIO];
        [addNum sizeToFit];
        [_item1 addSubview:addNum];
        
        UILabel *addNum1=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(addNum.frame)+6*SCREEN_RADIO, (screen_width-60*SCREEN_RADIO)/3, 12*SCREEN_RADIO)];
        addNum1.text=@"$0.99";
        addNum1.textColor=[UIColor getColor:@"666666"];
        addNum1.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        addNum1.textAlignment=NSTextAlignmentCenter;
        [_item1 addSubview:addNum1];
        
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,(screen_width-60*SCREEN_RADIO)/3, (screen_width-60*SCREEN_RADIO)/4)];
        btn.tag=1001;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_item1 addSubview:btn];
        
    }
    
    return _item1;
}

-(UIView *)item2{
    if (!_item2) {
        _item2=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.item1.frame)+10*SCREEN_RADIO, CGRectGetMaxY(self.leftIcon.frame)+15*SCREEN_RADIO, (screen_width-60*SCREEN_RADIO)/3, (screen_width-60*SCREEN_RADIO)/4)];
        _item2.layer.borderColor=[UIColor getColor:@"dcdcdc"].CGColor;
        _item2.layer.borderWidth=1;
        _item2.layer.cornerRadius=10*SCREEN_RADIO;
        
        UIImageView * icon=[[UIImageView alloc]initWithFrame:CGRectMake(20*SCREEN_RADIO, 25*SCREEN_RADIO, 12*SCREEN_RADIO, 12*SCREEN_RADIO)];
        icon.image=[UIImage imageNamed:@"leaderboard_coin"];
        [_item2 addSubview:icon];
        
        UILabel *goldNum=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame)+5*SCREEN_RADIO, 24*SCREEN_RADIO, 0, 12*SCREEN_RADIO)];
        goldNum.text=@"699";
        goldNum.textColor=[UIColor getColor:@"666666"];
        goldNum.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        [goldNum sizeToFit];
        [_item2 addSubview:goldNum];
        
        UILabel *addNum=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(goldNum.frame)+6*SCREEN_RADIO, 26*SCREEN_RADIO, 0, 10*SCREEN_RADIO)];
        addNum.text=@"+ 120";
        addNum.textColor=[UIColor getColor:@"f3b80c"];
        addNum.font=[UIFont systemFontOfSize:10*SCREEN_RADIO];
        [addNum sizeToFit];
        [_item2 addSubview:addNum];
        
        UILabel *addNum1=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(addNum.frame)+6*SCREEN_RADIO, (screen_width-60*SCREEN_RADIO)/3, 12*SCREEN_RADIO)];
        addNum1.text=@"$9.99";
        addNum1.textColor=[UIColor getColor:@"666666"];
        addNum1.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        addNum1.textAlignment=NSTextAlignmentCenter;
        [_item2 addSubview:addNum1];
        
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,(screen_width-60*SCREEN_RADIO)/3, (screen_width-60*SCREEN_RADIO)/4)];
        btn.tag=1002;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_item2 addSubview:btn];
    }
    
    return _item2;
}

-(UIView *)item3{
    if (!_item3) {
        _item3=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.item2.frame)+10*SCREEN_RADIO, CGRectGetMaxY(self.leftIcon.frame)+15*SCREEN_RADIO, (screen_width-60*SCREEN_RADIO)/3, (screen_width-60*SCREEN_RADIO)/4)];
        _item3.layer.borderColor=[UIColor getColor:@"dcdcdc"].CGColor;
        _item3.layer.borderWidth=1;
        _item3.layer.cornerRadius=10*SCREEN_RADIO;
        
        UIImageView * icon=[[UIImageView alloc]initWithFrame:CGRectMake(15*SCREEN_RADIO, 25*SCREEN_RADIO, 12*SCREEN_RADIO, 12*SCREEN_RADIO)];
        icon.image=[UIImage imageNamed:@"leaderboard_coin"];
        [_item3 addSubview:icon];
        
        UILabel *goldNum=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame)+5*SCREEN_RADIO, 24*SCREEN_RADIO, 0, 12*SCREEN_RADIO)];
        goldNum.text=@"6999";
        goldNum.textColor=[UIColor getColor:@"666666"];
        goldNum.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        [goldNum sizeToFit];
        [_item3 addSubview:goldNum];
        
        UILabel *addNum=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(goldNum.frame)+6*SCREEN_RADIO, 26*SCREEN_RADIO, 0, 10*SCREEN_RADIO)];
        addNum.text=@"+ 1500";
        addNum.textColor=[UIColor getColor:@"f3b80c"];
        addNum.font=[UIFont systemFontOfSize:10*SCREEN_RADIO];
        [addNum sizeToFit];
        [_item3 addSubview:addNum];
        
        UILabel *addNum1=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(addNum.frame)+6*SCREEN_RADIO, (screen_width-60*SCREEN_RADIO)/3, 12*SCREEN_RADIO)];
        addNum1.text=@"$99.99";
        addNum1.textColor=[UIColor getColor:@"666666"];
        addNum1.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        addNum1.textAlignment=NSTextAlignmentCenter;
        [_item3 addSubview:addNum1];
        
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,(screen_width-60*SCREEN_RADIO)/3, (screen_width-60*SCREEN_RADIO)/4)];
        btn.tag=1003;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_item3 addSubview:btn];
    }
    
    return _item3;
}

-(UIView *)item4{
    if (!_item4) {
        _item4=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.item1.frame)-((screen_width-60*SCREEN_RADIO)/3)/2, CGRectGetMaxY(self.item3.frame)+10*SCREEN_RADIO, (screen_width-60*SCREEN_RADIO)/3, (screen_width-60*SCREEN_RADIO)/4)];
        _item4.layer.borderColor=[UIColor getColor:@"dcdcdc"].CGColor;
        _item4.layer.borderWidth=1;
        _item4.layer.cornerRadius=10*SCREEN_RADIO;
        
        UIImageView * icon=[[UIImageView alloc]initWithFrame:CGRectMake(20*SCREEN_RADIO, 25*SCREEN_RADIO, 12*SCREEN_RADIO, 12*SCREEN_RADIO)];
        icon.image=[UIImage imageNamed:@"leaderboard_coin"];
        [_item4 addSubview:icon];
        
        UILabel *goldNum=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame)+5*SCREEN_RADIO, 24*SCREEN_RADIO, 0, 12*SCREEN_RADIO)];
        goldNum.text=@"349";
        goldNum.textColor=[UIColor getColor:@"666666"];
        goldNum.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        [goldNum sizeToFit];
        [_item4 addSubview:goldNum];
        
        UILabel *addNum=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(goldNum.frame)+6*SCREEN_RADIO, 26*SCREEN_RADIO, 0, 10*SCREEN_RADIO)];
        addNum.text=@"+ 50";
        addNum.textColor=[UIColor getColor:@"f3b80c"];
        addNum.font=[UIFont systemFontOfSize:10*SCREEN_RADIO];
        [addNum sizeToFit];
        [_item4 addSubview:addNum];
        
        UILabel *addNum1=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(addNum.frame)+6*SCREEN_RADIO, (screen_width-60*SCREEN_RADIO)/3, 12*SCREEN_RADIO)];
        addNum1.text=@"$4.99";
        addNum1.textColor=[UIColor getColor:@"666666"];
        addNum1.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        addNum1.textAlignment=NSTextAlignmentCenter;
        [_item4 addSubview:addNum1];
        
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,(screen_width-60*SCREEN_RADIO)/3, (screen_width-60*SCREEN_RADIO)/4)];
        btn.tag=1004;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_item4 addSubview:btn];
    }
    
    return _item4;
}

-(UIView *)item5{
    if (!_item5) {
        _item5=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.item4.frame)+10*SCREEN_RADIO, CGRectGetMaxY(self.item3.frame)+10*SCREEN_RADIO, (screen_width-60*SCREEN_RADIO)/3, (screen_width-60*SCREEN_RADIO)/4)];
        _item5.layer.borderColor=[UIColor getColor:@"dcdcdc"].CGColor;
        _item5.layer.borderWidth=1;
        _item5.layer.cornerRadius=10*SCREEN_RADIO;
        
        UIImageView * icon=[[UIImageView alloc]initWithFrame:CGRectMake(18*SCREEN_RADIO, 25*SCREEN_RADIO, 12*SCREEN_RADIO, 12*SCREEN_RADIO)];
        icon.image=[UIImage imageNamed:@"leaderboard_coin"];
        [_item5 addSubview:icon];
        
        UILabel *goldNum=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame)+5*SCREEN_RADIO, 24*SCREEN_RADIO, 0, 12*SCREEN_RADIO)];
        goldNum.text=@"3499";
        goldNum.textColor=[UIColor getColor:@"666666"];
        goldNum.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        [goldNum sizeToFit];
        [_item5 addSubview:goldNum];
        
        UILabel *addNum=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(goldNum.frame)+6*SCREEN_RADIO, 26*SCREEN_RADIO, 0, 10*SCREEN_RADIO)];
        addNum.text=@"+ 700";
        addNum.textColor=[UIColor getColor:@"f3b80c"];
        addNum.font=[UIFont systemFontOfSize:10*SCREEN_RADIO];
        [addNum sizeToFit];
        [_item5 addSubview:addNum];
        
        UILabel *addNum1=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(addNum.frame)+6*SCREEN_RADIO, (screen_width-60*SCREEN_RADIO)/3, 12*SCREEN_RADIO)];
        addNum1.text=@"$49.99";
        addNum1.textColor=[UIColor getColor:@"666666"];
        addNum1.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        addNum1.textAlignment=NSTextAlignmentCenter;
        [_item5 addSubview:addNum1];
        
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,(screen_width-60*SCREEN_RADIO)/3, (screen_width-60*SCREEN_RADIO)/4)];
        btn.tag=1005;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_item5 addSubview:btn];
    }
    
    return _item5;
}

-(UIImageView *)mineMoneyIcon{
    if (!_mineMoneyIcon) {
        _mineMoneyIcon=[[UIImageView alloc]initWithFrame:CGRectMake(10*SCREEN_RADIO, 250*SCREEN_RADIO-18*SCREEN_RADIO, 11*SCREEN_RADIO, 11*SCREEN_RADIO)];
        _mineMoneyIcon.image=[UIImage imageNamed:@"leaderboard_coin"];
    }
    
    return _mineMoneyIcon;
}


-(UILabel *)mineMoneyLabel{
    if (!_mineMoneyLabel) {
        _mineMoneyLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.mineMoneyIcon.frame)+5*SCREEN_RADIO, 250*SCREEN_RADIO-19*SCREEN_RADIO, 0, 12*SCREEN_RADIO)];
        _mineMoneyLabel.text=[NSString stringWithFormat:@"%ld",(long)[CGSingleCommitData sharedInstance].goldNum];
        _mineMoneyLabel.textColor=[UIColor getColor:@"666666"];
        _mineMoneyLabel.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        [_mineMoneyLabel sizeToFit];
    }
    
    return _mineMoneyLabel;
}
@end
