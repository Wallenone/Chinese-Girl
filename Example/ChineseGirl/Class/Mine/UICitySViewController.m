//
//  UICitySViewController.m
//  testcity
//
//  Created by wallen on 2017/11/13.
//  Copyright © 2017年 wallen. All rights reserved.
//

#import "UICitySViewController.h"
#import "EZJFastTableView.h"
@interface UICitySViewController ()
@property(nonatomic,strong)EZJFastTableView *tbv;
@end

@implementation UICitySViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tbv];
    // Do any additional setup after loading the view.
}

-(EZJFastTableView *)tbv{
    if (!_tbv) {
        CGRect tbvFrame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height);
        //初始化
        
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        
        //给tableview赋值
         [_tbv setDataArray:self.citysArr];
        __weak typeof(self) weakSelf = self;
        [_tbv onBuildCell:^(id cellData,NSString *cellIdentifier,NSIndexPath *index) {
            UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.userInteractionEnabled = true;
            cell.textLabel.text = cellData;
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
           
        }];
        
    }
    
    return _tbv;
}

@end
