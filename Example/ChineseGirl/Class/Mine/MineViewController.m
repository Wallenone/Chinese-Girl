//
//  MineViewController.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/8.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "MineViewController.h"
#import "CGLoginViewController.h"
#import "EZJFastTableView.h"
#import "MySettingTableViewCell.h"
#import "MineSettingTextViewController.h"
#import "WYGenderPickerView.h"
#import "WYBirthdayPickerView.h"
#import "WYHeightPickerView.h"
#import "WYCityPickerView.h"
#import "UICustomPickImgView.h"
@interface MineViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
}
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIImageView *headerImgView;
@property(nonatomic,strong)UIButton *AvatarImgView;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UIView *bodyView;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,strong)UIButton *addImgs;
@property(nonatomic,assign)NSInteger imgsNum;
@end

@implementation MineViewController
-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _imgsNum=0;
    self.view.backgroundColor=[UIColor getColor:@"F8F8F8"];
    [self addHeaderView];
    [self addBodyView];
}

-(void)addHeaderView{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.headerImgView];
    [self.headerView addSubview:self.AvatarImgView];
    [self.headerView addSubview:self.nickName];
}

-(void)addBodyView{
    [self.view addSubview:self.bodyView];
    [self.view addSubview:self.tbv];
    [self.bodyView addSubview:self.addImgs];
}

-(void)chooseImg{
    __weak typeof(self) weakSelf = self;
    UICustomPickImgView *customVC=[[UICustomPickImgView alloc] init];
    [customVC onGetImg:^(UIImage *ava) {
        [weakSelf.AvatarImgView setImage:ava forState:UIControlStateNormal];
    }];
    [self.view addSubview:customVC];
   
}

-(void)addImgClick{
    __weak typeof(self) weakSelf = self;
    UICustomPickImgView *customVC=[[UICustomPickImgView alloc] init];
    [customVC onGetImg:^(UIImage *ava) {
        [weakSelf setImgsUIView:ava];
        weakSelf.imgsNum++;
    }];
    [self.view addSubview:customVC];
}


-(void)setImgsUIView:(UIImage *)img{
    
    CGFloat _addHeight=5*SCREEN_RADIO;
    CGFloat _addWidth=5*SCREEN_RADIO+84*SCREEN_RADIO*(_imgsNum+1);
    CGFloat _imgHeight=5*SCREEN_RADIO;
    CGFloat _imgWidth=5*SCREEN_RADIO+84*SCREEN_RADIO*_imgsNum;
    
    if (_imgsNum==3) {
        _addHeight=95*SCREEN_RADIO;
        _addWidth=5*SCREEN_RADIO;
    }else if (_imgsNum>3){
        _addHeight=95*SCREEN_RADIO;
        _addWidth=5*SCREEN_RADIO+84*SCREEN_RADIO*(_imgsNum-3);
    }
    
    if (_imgsNum==4) {
        _imgHeight=90*SCREEN_RADIO;
        _imgWidth=5*SCREEN_RADIO;
    }else if (_imgsNum>4){
        _imgHeight=90*SCREEN_RADIO;
        _imgWidth=5*SCREEN_RADIO+84*SCREEN_RADIO*(_imgsNum-4);
    }
    
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(_imgWidth, _imgHeight, 79*SCREEN_RADIO, 79*SCREEN_RADIO)];
    btn.layer.cornerRadius=5*SCREEN_RADIO;
    btn.layer.masksToBounds=YES;
    [btn setImage:img forState:UIControlStateNormal];
    [self.bodyView addSubview:btn];
    
    if (_imgsNum>6) {
        self.addImgs.hidden=YES;
    }else{
        self.addImgs.hidden=NO;
    }
    self.addImgs.frame=CGRectMake(_addWidth, _addHeight, 79*SCREEN_RADIO, 79*SCREEN_RADIO);
}


-(UIView *)headerView{
    if (!_headerView) {
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 269*SCREEN_RADIO)];
        _headerView.backgroundColor=[UIColor getColor:@"2979FF"];
    }
    return _headerView;
}

-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 299*SCREEN_RADIO)];
        _headerImgView.image=[UIImage imageNamed:@"myBar"];
    }
    
    return _headerImgView;
}


-(UIButton *)AvatarImgView{
    if (!_AvatarImgView) {
        _AvatarImgView=[[UIButton alloc] initWithFrame:CGRectMake(screen_width/2-47*SCREEN_RADIO, 31.5*SCREEN_RADIO, 94*SCREEN_RADIO, 94*SCREEN_RADIO)];
        [_AvatarImgView setImage:[UIImage imageNamed:@"Avatar"] forState:UIControlStateNormal];
        _AvatarImgView.layer.cornerRadius=47*SCREEN_RADIO;
        _AvatarImgView.layer.masksToBounds=YES;
        [_AvatarImgView addTarget:self action:@selector(chooseImg) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _AvatarImgView;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.AvatarImgView.frame)+12*SCREEN_RADIO, screen_width, 18*SCREEN_RADIO)];
        _nickName.text=@"Wallen";
        _nickName.textColor=[UIColor getColor:@"ffffff"];
        _nickName.font=[UIFont boldSystemFontOfSize:15*SCREEN_RADIO];
        _nickName.textAlignment=NSTextAlignmentCenter;
    }
    return _nickName;
}

-(UIView *)bodyView{
    if (!_bodyView) {
        _bodyView=[[UIView alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, CGRectGetMaxY(self.nickName.frame)+10*SCREEN_RADIO, screen_width-32*SCREEN_RADIO, 173*SCREEN_RADIO)];
        _bodyView.backgroundColor=[UIColor getColor:@"ffffff"];
        _bodyView.layer.cornerRadius=6;
    }
    
    return _bodyView;
}

-(UIButton *)addImgs{
    if (!_addImgs) {
        _addImgs=[[UIButton alloc] initWithFrame:CGRectMake(5*SCREEN_RADIO, 5*SCREEN_RADIO, 79*SCREEN_RADIO, 79*SCREEN_RADIO)];
        [_addImgs setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
        [_addImgs addTarget:self action:@selector(addImgClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _addImgs;
}


-(EZJFastTableView *)tbv{
    if (!_tbv) {
        
        __weak typeof(self) weakSelf = self;
        CGRect tbvFrame = CGRectMake(16*SCREEN_RADIO, CGRectGetMaxY(self.bodyView.frame)+15*SCREEN_RADIO, screen_width-32*SCREEN_RADIO, 49.5*5*SCREEN_RADIO);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.scrollEnabled=NO;
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.layer.cornerRadius=6;
        _tbv.backgroundColor=[UIColor getColor:@"ffffff"];
        NSMutableArray *arrays =[[NSMutableArray alloc] initWithObjects:@"昵称",@"性别",@"城市",@"生日",@"关于我",nil];
        
        //给tableview赋值
        [_tbv setDataArray:arrays];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            MySettingTableViewCell *cell=[[MySettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withModel:cellData];
            return cell;
            
        }];
        
        //动态改变
        
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {

            return 49.5*SCREEN_RADIO;
        }];
        
        //设置选中事件 block设置方式
        //indexPath  是当前行对象 indexPath.row(获取行数)
        //cellData 是当前行的数据
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        [_tbv onCellSelected:^(NSIndexPath *indexPath, id cellData) {

            MySettingTableViewCell *cell = [strongSelf.tbv cellForRowAtIndexPath:indexPath];
            
            if ([cellData isEqualToString:@"昵称"]) {
                MineSettingTextViewController *nickVC=[[MineSettingTextViewController alloc] init];
                nickVC.titleText=@"昵称";
                nickVC.textStr=[cell getContent];
                [nickVC onTextBlock:^(NSString *text) {
                    [cell updateCellContent:text];
                }];
              
                [strongSelf.navigationController pushViewController:nickVC animated:NO];
            }else if ([cellData isEqualToString:@"性别"]){
                strongSelf.tabBarController.tabBar.hidden=YES;
                WYGenderPickerView *customPickerSex=[[WYGenderPickerView alloc] initWithInitialGender:@"男"];
                customPickerSex.confirmBlock = ^(NSString *selectedGender){
                    strongSelf.tabBarController.tabBar.hidden=NO;
                    [cell updateCellContent:selectedGender];
                    
                };
                
                [strongSelf.view addSubview:customPickerSex];

                
                
            }else if ([cellData isEqualToString:@"城市"]){
            
            }else if ([cellData isEqualToString:@"生日"]){
                strongSelf.tabBarController.tabBar.hidden=YES;
                WYBirthdayPickerView *birthdayPickerView = [[WYBirthdayPickerView alloc] initWithInitialDate:@"1990-01-01"];
                
                // 选择日期完成之后的回调 : 按自己的要求做相应的处理就可以了
                birthdayPickerView.confirmBlock = ^(NSString *selectedDate) {
                    strongSelf.tabBarController.tabBar.hidden=NO;
                    [cell updateCellContent:selectedDate];
                };
                
                [strongSelf.view addSubview:birthdayPickerView];
                
            
                
            }else if ([cellData isEqualToString:@"关于我"]){
                MineSettingTextViewController *aboutVC=[[MineSettingTextViewController alloc] init];
                aboutVC.titleText=@"关于我";
                aboutVC.textStr=[cell getContent];
                [aboutVC onTextBlock:^(NSString *text) {
                    [cell updateCellContent:text];
                }];
                [strongSelf.navigationController pushViewController:aboutVC animated:NO];
            }
         
        }];
        
    }
    
    return _tbv;
}



-(void)click{
    CGLoginViewController *loginVC=[[CGLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

//代理方法
-(void)didClickAddPhoto
{
    NSLog(@"点击添加图片");
}

-(void)addNewPhoto:(UIImage *)image
{
    NSLog(@"新增图片");
}

@end
