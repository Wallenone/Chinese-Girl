//
//  ViewController.m
//  PinyinIndexTableview
//
//  Created by luo.h on 15-5-14.
//  Copyright (c) 2015年 sibu.cn. All rights reserved.
//

#import "CGFriendsViewcontroller.h"
#import "NSString+PinYin.h"
#import "CGFriendsAddViewController.h"
@interface CGFriendsViewcontroller ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,HzfNavigationBarDelegate>

@property(nonatomic,strong)  UITableView     *myTableView;
@property(nonatomic,strong)  NSMutableArray  *dataArray;

@end

@implementation CGFriendsViewcontroller

-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initDataSource];
    [self createTableView];
    [self setHeaderView];
}

-(void)setHeaderView{
    [self setUpNavWithTitle:@"朋友" leftIcon:nil rightIcon:nil leftTitle:nil rightTitle:@"添加" delegate:nil];
    self.naviDelegate=self;
}

- (void)NavigationBarRightButtonClicked{
    CGFriendsAddViewController *addVC=[[CGFriendsAddViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:NO];
}

#pragma mark----CreatMyCustomTablevIew-----
- (void)createTableView
{
    self.myTableView = [[UITableView  alloc] initWithFrame:CGRectMake(0,20,self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"REUSE_CELLID"];
    self.myTableView.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2);
    [self.view  addSubview:self.myTableView];
     self.myTableView.sectionIndexColor =[UIColor colorWithRed:0.10 green:0.68 blue:0.94 alpha:1.0];    self.myTableView.sectionIndexBackgroundColor=[UIColor clearColor];
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
}

- (void)initDataSource
{
    NSArray *array = @[@"登记", @"大奔", @"周傅", @"爱德华",@"((((", @"啦文琪羊", @"   s文强", @"过段时间", @"等等", @"各个", @"宵夜**", @"***", @"贝尔",@"*而结婚*", @"返回***", @"你还", @"与非门*", @"是的", @"*模块*", @"*没做*",@"俄文", @"   *#咳嗽", @"6",@"fh",@"C罗",@"邓肯"];
   NSArray  *indexArray= [array arrayWithPinYinFirstLetterFormat];
   self.dataArray =[NSMutableArray arrayWithArray:indexArray];
    
    [self.myTableView reloadData];
}



#pragma mark--- UITableViewDataSource and UITableViewDelegate Methods---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }else{
        NSDictionary *dict = self.dataArray[section];
        NSMutableArray *array = dict[@"content"];
        return [array count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    NSDictionary *dict = self.dataArray[indexPath.section];
    NSMutableArray *array = dict[@"content"];
    cell.textLabel.text = array[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:0.10 green:0.68 blue:0.94 alpha:1.0];
    
    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //自定义Header标题
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor colorWithRed:0.10 green:0.68 blue:0.94 alpha:0.7];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 90, 22)];
    titleLabel.textColor=[UIColor whiteColor];

    NSString *title = self.dataArray[section][@"firstLetter"];
    titleLabel.text=title;
    [myView  addSubview:titleLabel];
    
    return myView;
}



#pragma mark---tableView索引相关设置----
//添加TableView头视图标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict = self.dataArray[section];
    NSString *title = dict[@"firstLetter"];
    return title;
}


//添加索引栏标题数组
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *resultArray =[NSMutableArray arrayWithObject:UITableViewIndexSearch];
    for (NSDictionary *dict in self.dataArray) {
        NSString *title = dict[@"firstLetter"];
        [resultArray addObject:title];
    }
    return resultArray;
}


//点击索引栏标题时执行
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //这里是为了指定索引index对应的是哪个section的，默认的话直接返回index就好。其他需要定制的就针对性处理
    if ([title isEqualToString:UITableViewIndexSearch])
    {
        [tableView setContentOffset:CGPointZero animated:NO];//tabview移至顶部
        return NSNotFound;
    }
    else
    {
        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index] - 1; // -1 添加了搜索标识
    }
}

@end
