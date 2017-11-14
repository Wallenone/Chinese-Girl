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
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "UICountryViewController.h"
@interface MineProfileInfoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIView *bodyView;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,strong)UIButton *addImgs;
@property(nonatomic,assign)NSInteger imgsNum;
@property(nonatomic,strong)NSMutableArray *imgViewArr;
@property(nonatomic,strong)UIView *bodyCellView;
@end

@implementation MineProfileInfoViewController

-(NSMutableArray *)imgViewArr{
    if (!_imgViewArr) {
        _imgViewArr=[NSMutableArray new];
    }
    
    return _imgViewArr;
}

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
    self.view.backgroundColor=[UIColor getColor:@"F5F5F5"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCityName:) name:@"getAreaName" object:nil];
    [self setData];
    [self addHeaderView];
    [self addBodyView];
}

-(void)addHeaderView{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.titleLable];
    [self.headerView addSubview:self.leftBtn];
}

-(void)addBodyView{
    [self.view addSubview:self.bodyView];
    [self.view addSubview:self.tbv];
    [self.bodyView addSubview:self.bodyCellView];
    [self.bodyView addSubview:self.addImgs];
    NSArray *albums=[CGSingleCommitData sharedInstance].albumS;
    for (NSData *imgData in albums) {
        [self setImgsUIView:[UIImage imageWithData:imgData]];
        self.imgsNum++;
    }
}


-(void)setData{
    _imgsNum=0;
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)getCityName:(NSNotification *)obj{
    [CGSingleCommitData sharedInstance].countryName=[obj.object stringForKey:@"countryName"];
    [CGSingleCommitData sharedInstance].cityName=[obj.object stringForKey:@"cityName"];
    
    NSString *cityName=[CGSingleCommitData sharedInstance].cityName.length>0?[CGSingleCommitData sharedInstance].cityName:[CGSingleCommitData sharedInstance].countryName;
    MySettingTableViewCell *cell = [self.tbv cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    [cell updateCellContent:cityName];
}


-(void)addImgClick{
    __weak typeof(self) weakSelf = self;
    UICustomPickImgView *customVC=[[UICustomPickImgView alloc] init];
    [customVC onGetImg:^(UIImage *ava) {
        [[CGSingleCommitData sharedInstance] addAlbumS:ava];
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
    btn.tag=self.imgsNum;
    [btn addTarget:self action:@selector(editPhotosClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.imgViewArr addObject:btn.imageView];
    [self.bodyCellView addSubview:btn];
    
    if (_imgsNum>6) {
        self.addImgs.hidden=YES;
    }else{
        self.addImgs.hidden=NO;
    }
    self.addImgs.frame=CGRectMake(_addWidth, _addHeight, 79*SCREEN_RADIO, 79*SCREEN_RADIO);
}

-(void)editPhotosClick:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    UIAlertController *alterVC=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alterVC addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"full_image", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf setCheckPhotos:sender.tag];
    }]];
    [alterVC addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"replace_photo", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf changePhotowithSener:sender];
    }]];
    [alterVC addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"delete_photo", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf deletePhoto:sender];
    }]];
    [alterVC addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"set_as_profile_photo", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf setAvater:sender];
    }]];
    [alterVC addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alterVC animated:YES completion:nil];
}

-(void)setCheckPhotos:(NSInteger)_tag{
    NSUInteger count = self.imgsNum;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.srcImageView = self.imgViewArr[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = _tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

-(void)changePhotowithSener:(UIButton *)sender{
    UICustomPickImgView *customVC=[[UICustomPickImgView alloc] init];
    [customVC onGetImg:^(UIImage *ava) {
        if (ava) {
            [[CGSingleCommitData sharedInstance] replaceAlbumS:ava withTag:sender.tag];
            [sender setImage:ava forState:UIControlStateNormal];
        }
        
    }];
    [self.view addSubview:customVC];
}

-(void)deletePhoto:(UIButton *)sender{
    self.imgsNum=0;
    for (UIView *objView in [self.bodyCellView subviews]) {
        [objView removeFromSuperview];
    }
    [self.imgViewArr removeObjectAtIndex:sender.tag];
    [[CGSingleCommitData sharedInstance] deleteAlbumwithTag:sender.tag];
    NSArray *albums=[CGSingleCommitData sharedInstance].albumS;
    for (NSData *imgData in albums) {
        [self setImgsUIView:[UIImage imageWithData:imgData]];
        self.imgsNum++;
    }
}

-(void)setAvater:(UIButton *)sender{
    UIImageView *avaImgView=[self.imgViewArr objectAtIndex:sender.tag];
    [CGSingleCommitData sharedInstance].avatar=avaImgView.image;
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
        _titleLable.text=NSLocalizedString(@"profile_info", nil);
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
        
        NSString *cityName=[CGSingleCommitData sharedInstance].cityName.length>0?[CGSingleCommitData sharedInstance].cityName:[CGSingleCommitData sharedInstance].countryName;
        
        NSMutableArray *arrays =[[NSMutableArray alloc] initWithObjects:
                                            @{@"left":NSLocalizedString(@"nickname", nil),@"right":[CGSingleCommitData sharedInstance].nickName},
                                            @{@"left":NSLocalizedString(@"gender", nil),@"right":[CGSingleCommitData sharedInstance].sex},
                                            @{@"left":NSLocalizedString(@"city", nil),@"right":cityName},
                                            @{@"left":NSLocalizedString(@"birthday", nil),@"right":[CGSingleCommitData sharedInstance].birthDay},
                                            @{@"left":NSLocalizedString(@"about", nil),@"right":[CGSingleCommitData sharedInstance].aboutUs},
                                            nil];
        //给tableview赋值
        [_tbv setDataArray:arrays];
        
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            BOOL state=NO;
            if (index.row==arrays.count-1) {
                state=YES;
            }
            MySettingTableViewCell *cell=[[MySettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withModel:cellData withLineHidden:state withAllowHidden:NO];
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
            
            if ([[cellData objectForKey:@"left"] isEqualToString:NSLocalizedString(@"nickname", nil)]) {
                MineSettingTextViewController *nickVC=[[MineSettingTextViewController alloc] init];
                nickVC.titleText=NSLocalizedString(@"nickname", nil);
                nickVC.textStr=[cell getContent];
                [nickVC onTextBlock:^(NSString *text) {
                    [CGSingleCommitData sharedInstance].nickName=text;
                    [cell updateCellContent:text];
                }];
                
                [strongSelf.navigationController pushViewController:nickVC animated:NO];
            }else if ([[cellData objectForKey:@"left"] isEqualToString:NSLocalizedString(@"gender", nil)]){
                strongSelf.tabBarController.tabBar.hidden=YES;
                WYGenderPickerView *customPickerSex=[[WYGenderPickerView alloc] initWithInitialGender:NSLocalizedString(@"sex_man", nil)];
                customPickerSex.confirmBlock = ^(NSString *selectedGender){
                    [CGSingleCommitData sharedInstance].sex=selectedGender;
                    strongSelf.tabBarController.tabBar.hidden=NO;
                    [cell updateCellContent:selectedGender];
                    
                };
                
                [strongSelf.view addSubview:customPickerSex];
            }else if ([[cellData objectForKey:@"left"] isEqualToString:NSLocalizedString(@"city", nil)]){
//                NSString *cityName=[CGSingleCommitData sharedInstance].cityName.length>0?[CGSingleCommitData sharedInstance].cityName:[CGSingleCommitData sharedInstance].countryName;
//                [cell updateCellContent:cityName];
                
                UICountryViewController *countryVC=[[UICountryViewController alloc] init];
                [strongSelf.navigationController pushViewController:countryVC animated:NO];
                
                
            }else if ([[cellData objectForKey:@"left"] isEqualToString:NSLocalizedString(@"birthday", nil)]){
                strongSelf.tabBarController.tabBar.hidden=YES;
                WYBirthdayPickerView *birthdayPickerView = [[WYBirthdayPickerView alloc] initWithInitialDate:@"1990-01-01"];
                
                // 选择日期完成之后的回调 : 按自己的要求做相应的处理就可以了
                birthdayPickerView.confirmBlock = ^(NSString *selectedDate) {
                    [CGSingleCommitData sharedInstance].birthDay=selectedDate;
                    strongSelf.tabBarController.tabBar.hidden=NO;
                    [cell updateCellContent:selectedDate];
                };
                
                [strongSelf.view addSubview:birthdayPickerView];
            }else if ([[cellData objectForKey:@"left"] isEqualToString:NSLocalizedString(@"about", nil)]){
                MineSettingTextViewController *aboutVC=[[MineSettingTextViewController alloc] init];
                aboutVC.titleText=NSLocalizedString(@"about", nil);
                aboutVC.textStr=[cell getContent];
                [aboutVC onTextBlock:^(NSString *text) {
                    [CGSingleCommitData sharedInstance].aboutUs=text;
                    [cell updateCellContent:text];
                }];
                [strongSelf.navigationController pushViewController:aboutVC animated:NO];
            }
            
        }];
        
    }
    
    return _tbv;
}


-(UIView *)bodyCellView{
    if (!_bodyCellView) {
        _bodyCellView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width-32*SCREEN_RADIO, 173*SCREEN_RADIO)];
        _bodyCellView.backgroundColor=[UIColor getColor:@"ffffff"];
        _bodyCellView.layer.cornerRadius=6;
    }
    
    return _bodyCellView;
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
