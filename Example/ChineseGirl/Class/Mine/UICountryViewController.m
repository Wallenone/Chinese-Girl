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
@interface UICountryViewController (){
    
}
@property(nonatomic,strong)NSMutableArray *cityArrs;
@property(nonatomic,strong)EZJFastTableView *tbv;
@end

@implementation UICountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [CGGetCityPlist getCountryList];
    self.cityArrs= [CGGetCityPlist readPlist];
    [self.view addSubview:self.tbv];
    [self.tbv setDataArray:self.cityArrs];
    [self.tbv reloadData];
    
}

-(NSMutableArray *)cityArrs{
    if (!_cityArrs) {
        _cityArrs=[NSMutableArray new];
    }
    
    return _cityArrs;
}

-(EZJFastTableView *)tbv{
    if (!_tbv) {
        CGRect tbvFrame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        
        //给tableview赋值
        // [_tbv setDataArray:arrays];
        __weak typeof(self) weakSelf = self;
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.userInteractionEnabled = true;
            cell.textLabel.text = [cellData objectForKey:@"contryName"];
            return cell;
        }];
        
        //动态改变
        [_tbv onChangeCellHeight:^CGFloat(NSIndexPath *indexPath,id cellData) {
            return _tbv.rowHeight;
        }];
        
        
        
        //允许上行滑动
        [_tbv onDragUp:^void (int page) {
            // return [self loadNewData:page];
        }];
        
        //允许下行滑动刷新
        [_tbv onDragDown:^{
            
        }];
        
        
        //设置选中事件 block设置方式
        //indexPath  是当前行对象 indexPath.row(获取行数)
        //cellData 是当前行的数据
        
        [_tbv onCellSelected:^(NSIndexPath *indexPath, id cellData) {
            NSLog(@"click");
            NSArray *arr=[cellData objectForKey:@"cityList"];
            if (arr.count>0) {
                UICitySViewController *cityVC=[[UICitySViewController alloc] init];
                cityVC.citysArr=[cellData objectForKey:@"cityList"];
                [weakSelf.navigationController pushViewController:cityVC animated:NO];
            }
            
        }];
        
    }
    
    return _tbv;
}

@end
