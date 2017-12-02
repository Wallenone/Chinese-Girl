//
//  ViewController.m
//  testcity
//
//  Created by wallen on 2017/11/7.
//  Copyright © 2017年 wallen. All rights reserved.
//

#import "UICountryViewController.h"
#import "CGGetCityPlist.h"
#import "EZJFastTableView.h"
#import "UICitySViewController.h"
#import "CGLocationTableViewCell.h"
#import <CoreLocation/CoreLocation.h>
@interface UICountryViewController ()<CLLocationManagerDelegate>{
    NSString *_countyName;
    NSString *_cityName;
    BOOL _replayLocation; //已经请求过了
}
@property(nonatomic,strong)UIButton *leftIcon;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *titleLineView;
@property(nonatomic,strong)NSMutableArray *cityArrs;
@property(nonatomic,strong)EZJFastTableView *tbv;
@property(nonatomic,strong)CLLocationManager* locationManager;
@end

@implementation UICountryViewController
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
    [self startLocation];
    [self setData];
    [self addSubViews];
}

-(void)addSubViews{
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.leftIcon];
    [self.view addSubview:self.titleLineView];
    [self.view addSubview:self.tbv];
    [self.tbv setDataArray:self.cityArrs];
    [self.tbv reloadData];
}

-(void)setData{
    _countyName=@"";
    _cityName=@"";
    _replayLocation=NO;
    self.cityArrs= [CGGetCityPlist readPlist];
    [self.cityArrs insertObject:@"location" atIndex:0];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)localtionClick{
    
}

- (void)startLocation
{
    self.locationManager=[[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
     * 获取授权认证，两个方法：
     * [self.locationManager requestWhenInUseAuthorization];
     * [self.locationManager requestAlwaysAuthorization];
     */
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        NSLog(@"requestAlwaysAuthorization");
        [self.locationManager requestAlwaysAuthorization];
    }
    
    //开始定位，不断调用其代理方法
    [self.locationManager startUpdatingLocation];
    NSLog(@"start gps");
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    
    // 2.停止定位
    [manager stopUpdatingLocation];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        _replayLocation=YES;
        for (CLPlacemark *place in placemarks) {
            
            _cityName=place.locality;
            _countyName=place.country;
            NSLog(@"name,%@",place.name);                      // 位置名
            
            NSLog(@"thoroughfare,%@",place.thoroughfare);      // 街道
            
            NSLog(@"subThoroughfare,%@",place.subThoroughfare);// 子街道
            
            NSLog(@"locality,%@",place.locality);              // 市
            
            NSLog(@"subLocality,%@",place.subLocality);        // 区
            
            NSLog(@"country,%@",place.country);                // 国家
            
        }
        
        NSString *locationName=@"当前位置:无法获取";
        if (_countyName.length>0) {
            locationName=[NSString stringWithFormat:@"当前位置:%@",_countyName];
        }
        
        if (_cityName.length>0 && _countyName.length>0) {
            locationName=[NSString stringWithFormat:@"当前位置:%@.%@",_countyName,_cityName];
        }
        
        UITableViewCell *cell = [self.tbv cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.textLabel.text=locationName;
        
    }];
    
    
    
    
//    if ([CLLocationManager locationServicesEnabled]  //确定用户的位置服务启用
//        &&[CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied)
//        //位置服务是在设置中禁用
//    {
//
//    }
   
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}


-(NSMutableArray *)cityArrs{
    if (!_cityArrs) {
        _cityArrs=[NSMutableArray new];
    }
    
    return _cityArrs;
}

-(UIButton *)leftIcon{
    if (!_leftIcon) {
        _leftIcon=[[UIButton alloc] initWithFrame:CGRectMake(23*SCREEN_RADIO, 37*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_leftIcon setImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_leftIcon addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftIcon;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftIcon.frame)+13*SCREEN_RADIO, 29*SCREEN_RADIO, 0, 35*SCREEN_RADIO)];
        _titleLabel.text=NSLocalizedString(@"Area", nil);
        _titleLabel.textColor=[UIColor getColor:@"2A2A2A"];
        _titleLabel.font=[UIFont systemFontOfSize:26*SCREEN_RADIO];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        [_titleLabel sizeToFit];
    }
    
    return _titleLabel;
}


-(UIView *)titleLineView{
    if (!_titleLineView) {
        _titleLineView=[[UILabel alloc] initWithFrame:CGRectMake(20*SCREEN_RADIO, CGRectGetMaxY(self.titleLabel.frame)+13*SCREEN_RADIO, screen_width-40*SCREEN_RADIO, 1)];
        _titleLineView.backgroundColor=[UIColor getColor:@"F3F3F3"];
    }
    
    return _titleLineView;
}


-(EZJFastTableView *)tbv{
    if (!_tbv) {
        CGRect tbvFrame = CGRectMake(0, CGRectGetMaxY(self.titleLineView.frame), self.view.frame.size.width, self.view.frame.size.height-60*SCREEN_RADIO);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        
        //给tableview赋值
        // [_tbv setDataArray:arrays];
        __weak typeof(self) weakSelf = self;
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (index.row==0) {
                if (!_replayLocation) {
                    cell.textLabel.text = @"当前位置:获取中";
                }else{
                    if (_countyName.length>0) {
                        cell.textLabel.text=[NSString stringWithFormat:@"当前位置:%@",_countyName];
                    }
                    
                    if (_cityName.length>0 && _countyName.length>0) {
                        cell.textLabel.text=[NSString stringWithFormat:@"当前位置:%@.%@",_countyName,_cityName];
                    }else{
                        cell.textLabel.text=@"当前位置:无法获取";
                    }
                }
   
            }else{
                NSArray *arr=[cellData objectForKey:@"cityList"];
                if (arr.count>0) {
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                }
                cell.textLabel.text = [cellData objectForKey:@"contryName"];
            }
            
                
            return cell;

        }];
        
        //动态改变
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            return _tbv.rowHeight;
        }];
        
        //设置选中事件 block设置方式
        //indexPath  是当前行对象 indexPath.row(获取行数)
        //cellData 是当前行的数据
        
        [_tbv onCellSelected:^(NSIndexPath *indexPath, id cellData) {
            NSLog(@"click");
            if (indexPath.row==0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getAreaName" object:@{@"countryName":_countyName,@"cityName":_cityName}];
                [weakSelf.navigationController popViewControllerAnimated:NO];
            }else{
                NSArray *arr=[cellData objectForKey:@"cityList"];
                if (arr.count>0) {
                    UICitySViewController *cityVC=[[UICitySViewController alloc] init];
                    cityVC.citysArr=[cellData objectForKey:@"cityList"];
                    cityVC.countryName=[cellData objectForKey:@"contryName"];
                    [weakSelf.navigationController pushViewController:cityVC animated:NO];
                }else{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"getAreaName" object:@{@"countryName":[cellData stringForKey:@"contryName"],@"cityName":@""}];
                    [weakSelf.navigationController popViewControllerAnimated:NO];
                }
            }
            
            
        }];
        
    }
    
    return _tbv;
}


@end
