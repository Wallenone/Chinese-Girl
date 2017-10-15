//
//  IndexCollectionView.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/14.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "IndexCollectionView.h"
#import "AFNetworking.h"
#import "CellModel.h"
#import "WSCollectionCell.h"
#import "WSLayout.h"
#import "MJRefresh.h"
#import "MyIndexViewController.h"

@interface IndexCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate>{
    NSMutableArray *modelCollectionArray;
    NSMutableArray *modelArray;
    NSInteger t_page;
    CellSelectedIndexBlock cellSelectedIndexBlock;
}
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) WSLayout *wslayout;
@end

@implementation IndexCollectionView

- (id)initWithFrame:(CGRect)frame onCellSelected:(CellSelectedIndexBlock)block{
    if (self=[super initWithFrame:frame]) {
        cellSelectedIndexBlock=block;
        self.backgroundColor=[UIColor whiteColor];
        [self setData];
        [self setUI];
    }
    
    return self;
}

-(void)setData{
    modelCollectionArray=[NSMutableArray array];
    t_page=0;
}

-(void)setUI{
    [self _creatSubView];
}

-(void)getCollectionData:(NSInteger)page{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [[NSString stringWithFormat:@"http://image.baidu.com/channel/listjson?pn=%ld&rn=50&tag1=美女&tag2=全部&ie=utf8",(long)page] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // NSLog(@"%@",responseObject);
        NSMutableArray *array = [responseObject[@"data"] mutableCopy];
        [array removeLastObject];
        
        modelArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            
            CellModel *model = [[CellModel alloc]init];
            model.imgURL = dic[@"image_url"];
            model.imgWidth = [dic[@"image_width"] floatValue];
            model.imgHeight = [dic[@"image_height"] floatValue];
            model.title = dic[@"abs"];
            
            [modelArray addObject:model];
            [modelCollectionArray addObject:model];
        }
        
        
        
        [self.collectionView reloadData];
        t_page++;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)_creatSubView {
    
    self.wslayout = [[WSLayout alloc] init];
    self.wslayout.lineNumber = 3; //列数
    self.wslayout.rowSpacing = 1; //行间距
    self.wslayout.lineSpacing = 1; //列间距
    self.wslayout.sectionInset = UIEdgeInsetsMake(1, 0, 1, 0);
    
    // 透明时用这个属性(保证collectionView 不会被遮挡, 也不会向下移)
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    // 不透明时用这个属性
    //self.extendedLayoutIncludesOpaqueBars = YES;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:self.wslayout];
    
    [self.collectionView registerClass:[WSCollectionCell class] forCellWithReuseIdentifier:@"collectionCell"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self getCollectionData:t_page];
    
    [self addSubview:self.collectionView];
    
    
    //返回每个cell的高   对应indexPath
    [self.wslayout computeIndexCellHeightWithWidthBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
        
        CellModel *model = modelCollectionArray[indexPath.row];
        CGFloat newHeigth = 135*SCREEN_RADIO;
        return newHeigth;
    }];
    
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{ //上拉
        [self.collectionView.mj_footer endRefreshing];
        if (t_page==3) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self getCollectionData:t_page];
        }
        
    }];
    
    //    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{   //下拉
    //        [self.collectionView.mj_header endRefreshing];
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            [self getCollectionData:t_page];
    //        });
    //    }];
    
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return modelCollectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WSCollectionCell *cell = (WSCollectionCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    cell.model = modelCollectionArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (cellSelectedIndexBlock) {
        cellSelectedIndexBlock(indexPath);
    }
    
    NSLog(@"选中了第%ld个item",indexPath.row);

}


@end
