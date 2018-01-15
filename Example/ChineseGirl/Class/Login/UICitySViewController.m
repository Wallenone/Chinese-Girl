//
//  UICitySViewController.m
//  testcity
//
//  Created by wallen on 2017/11/13.
//  Copyright © 2017年 wallen. All rights reserved.
//

#import "UICitySViewController.h"
#import "EZJFastTableView.h"
#import "CGRegisterIndexViewController.h"
@interface UICitySViewController ()
@property(nonatomic,strong)RkyExtendedHitButton *leftIcon;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *titleLineView;
@property(nonatomic,strong)EZJFastTableView *tbv;
@end

@implementation UICitySViewController
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
    [self addSubViews];

}
-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)addSubViews{
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.leftIcon];
    [self.view addSubview:self.titleLineView];
    [self.view addSubview:self.tbv];
}

-(RkyExtendedHitButton *)leftIcon{
    if (!_leftIcon) {
        _leftIcon=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(23*SCREEN_RADIO, 37*SCREEN_RADIO, 10*SCREEN_RADIO, 19*SCREEN_RADIO)];
        [_leftIcon setImage:[UIImage imageNamed:@"BlackArrowleft"] forState:UIControlStateNormal];
        [_leftIcon addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _leftIcon.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    return _leftIcon;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftIcon.frame)+13*SCREEN_RADIO, 29*SCREEN_RADIO, 0, 35*SCREEN_RADIO)];
        _titleLabel.text=NSLocalizedString(@"city", nil);
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
        CGRect tbvFrame = CGRectMake(0, CGRectGetMaxY(self.titleLineView.frame), self.view.frame.size.width, self.view.frame.size.height);
        //初始化
        __weak typeof(self) weakSelf = self;
        _tbv = [[EZJFastTableView alloc]initWithFrame:tbvFrame];
        
        //给tableview赋值
         [_tbv setDataArray:self.citysArr];
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
           
            int index = (int)[[weakSelf.navigationController viewControllers]indexOfObject:weakSelf];
            if (index>2) {
                [weakSelf.navigationController popToViewController:[weakSelf.navigationController.viewControllers objectAtIndex:(index-2)] animated:YES];
            }else
            {
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getAreaName" object:@{@"countryName":weakSelf.countryName,@"cityName":cellData}];
        }];
        
    }
    
    return _tbv;
}

@end
