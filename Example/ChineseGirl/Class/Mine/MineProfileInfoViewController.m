//
//  MineProfileInfoViewController.m
//  ChineseGirl
//
//  Created by Wallen on 2017/10/23.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "MineProfileInfoViewController.h"
#import "EZJFastTableView.h"
#import "MySettingTableViewCell.h"
#import "MineSettingTextViewController.h"
#import "WYGenderPickerView.h"
#import "WYBirthdayPickerView.h"
#import "UICustomPickImgView.h"
@interface MineProfileInfoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIView *bodyView;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,strong)UIButton *addImgs;
@property(nonatomic,assign)NSInteger imgsNum;
@end

@implementation MineProfileInfoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHeaderView];
    [self addBodyView];
    [self setData];
}

-(void)addHeaderView{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.titleLable];
    [self.headerView addSubview:self.leftBtn];
}

-(void)addBodyView{
    [self.view addSubview:self.bodyView];
    [self.view addSubview:self.tbv];
    [self.bodyView addSubview:self.addImgs];
}


-(void)setData{
    _imgsNum=0;
    self.view.backgroundColor=[UIColor getColor:@"F8F8F8"];
//    for (int i=0; i<5; i++) {
//        MySettingTableViewCell *cell = [self.tbv cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//        if (i==0) {   //nickName
//            [cell updateCellContent:[CGSingleCommitData sharedInstance].nickName];
//        }
//    }
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:NO];
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
        _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
        _headerView.backgroundColor=[UIColor whiteColor];
    }
    return _headerView;
}

-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable=[[UILabel alloc] initWithFrame:CGRectMake(0, 29*SCREEN_RADIO, screen_width, 24*SCREEN_RADIO)];
        _titleLable.text=@"个人中心";
        _titleLable.textColor=[UIColor getColor:@"232627"];
        _titleLable.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _titleLable.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLable;
}

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn=[[UIButton alloc] initWithFrame:CGRectMake(18.5*SCREEN_RADIO, 35*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _leftBtn;
}

-(UIView *)bodyView{
    if (!_bodyView) {
        _bodyView=[[UIView alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, 80*SCREEN_RADIO, screen_width-32*SCREEN_RADIO, 173*SCREEN_RADIO)];
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
        CGRect tbvFrame = CGRectMake(0, CGRectGetMaxY(self.bodyView.frame)+15*SCREEN_RADIO, screen_width, 49.5*5*SCREEN_RADIO);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        _tbv.scrollEnabled=NO;
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbv.backgroundColor=[UIColor getColor:@"ffffff"];
        NSMutableArray *arrays =[[NSMutableArray alloc] initWithObjects:@"昵称",@"性别",@"城市",@"生日",@"关于我",nil];
        
        //给tableview赋值
        [_tbv setDataArray:arrays];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            BOOL state=NO;
            if (index.row==arrays.count-1) {
                state=YES;
            }
            MySettingTableViewCell *cell=[[MySettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withModel:cellData withLineHidden:state];
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
                MineSettingTextViewController *citykVC=[[MineSettingTextViewController alloc] init];
                citykVC.titleText=@"城市";
                citykVC.textStr=[cell getContent];
                [citykVC onTextBlock:^(NSString *text) {
                    [cell updateCellContent:text];
                }];
                
                [strongSelf.navigationController pushViewController:citykVC animated:NO];
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
