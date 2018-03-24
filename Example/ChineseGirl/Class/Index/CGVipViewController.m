//
//  CGVipViewController.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/12/13.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGVipViewController.h"

@interface CGVipViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIView *diView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UIView *basicView;
@property(nonatomic,strong)UIView *premiumView;
@property(nonatomic,strong)UIView *ultimateView;
@property(nonatomic,strong)UILabel *menuLabel1;
@property(nonatomic,strong)UILabel *menuLabel2;
@property(nonatomic,strong)UILabel *menuLabel3;
@property(nonatomic,strong)RkyExtendedHitButton *confimBtn;
@property(nonatomic,strong)RkyExtendedHitButton *noBtn;
@end

@implementation CGVipViewController

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [MobClick event:VipPage_beginLog];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick event:VipPage_endLog];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
}

-(void)addSubViews{
    [self.view addSubview:self.diView];
    [self.diView addSubview:self.scrollView];
    [self.scrollView addSubview:self.basicView];
    [self.scrollView addSubview:self.premiumView];
    [self.scrollView addSubview:self.ultimateView];
    [self.diView addSubview:self.pageControl];
    [self.diView addSubview:self.lineView];
    [self.diView addSubview:self.menuLabel1];
    [self.diView addSubview:self.menuLabel2];
    [self.diView addSubview:self.menuLabel3];
    [self.diView addSubview:self.confimBtn];
    [self.diView addSubview:self.noBtn];
}

-(void)confimClick{
    if (_pageControl.currentPage==0) {
        [MobClick event:VipPage_1];
        [self setIapHelper:7];
    }else if (_pageControl.currentPage==1){
        [MobClick event:VipPage_2];
        [self setIapHelper:6];
    }else if (_pageControl.currentPage==2){
        [MobClick event:VipPage_3];
        [self setIapHelper:5];
    }
}

-(void)setIapHelper:(NSInteger)iapIndex{
    [MobClick event:PayPage_beginLog];
    [[IAPShare sharedHelper].iap requestProductsWithCompletion:^(SKProductsRequest* request,SKProductsResponse* response)
     {
         if(response > 0 ) {
             SKProduct* product =[[IAPShare sharedHelper].iap.products objectAtIndex:iapIndex];
             
             NSLog(@"Price: %@",[[IAPShare sharedHelper].iap getLocalePrice:product]);
             NSLog(@"Title: %@",product.localizedTitle);
             [SVProgressHUD showWithStatus:NSLocalizedString(@"zhengzaigoumai", nil)];
             [[IAPShare sharedHelper].iap buyProduct:product
                                        onCompletion:^(SKPaymentTransaction* trans){
                                            if(trans.error)
                                            {
                                                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"goumaishibai", nil)];
                                                [[SKPaymentQueue defaultQueue] finishTransaction:trans];
                                                NSLog(@"Fail %@",[trans.error localizedDescription]);
                                            }
                                            else if(trans.transactionState == SKPaymentTransactionStatePurchased) {
                                                
                                                [[IAPShare sharedHelper].iap checkReceipt:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]] AndSharedSecret:iapShareSecret onCompletion:^(NSString *response, NSError *error) {
                                                    
                                                    //Convert JSON String to NSDictionary
                                                    NSDictionary* rec = [IAPShare toJSON:response];
                                                    
                                                    if([rec[@"status"] integerValue]==0)
                                                    {
                                                        [[IAPShare sharedHelper].iap provideContentWithTransaction:trans];
                                                        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"goumaichenggong", nil)];
                                                        [[SKPaymentQueue defaultQueue] finishTransaction:trans];
                                                        NSLog(@"SUCCESS %@",response);
                                                        NSLog(@"Pruchases %@",[IAPShare sharedHelper].iap.purchasedProducts);
                                                        [MobClick event:PayPage_Success];
                                                        if (_pageControl.currentPage==0) {
                                                            [CGSingleCommitData sharedInstance].goldNum+=1000;
                                                        }else if (_pageControl.currentPage==1){
                                                            [CGSingleCommitData sharedInstance].goldNum+=100;
                                                        }else if (_pageControl.currentPage==2){
                                                            [CGSingleCommitData sharedInstance].goldNum+=50;
                                                        }
                                                        
                                                        [CGSingleCommitData sharedInstance].vipLevel=[NSString stringWithFormat:@"%ld",(long)_pageControl.currentPage+1];
                                                    }
                                                    else {
                                                        [MobClick event:PayPage_Fail];
                                                        NSLog(@"Fail");
                                                        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"goumaishibai", nil)];
                                                        [[SKPaymentQueue defaultQueue] finishTransaction:trans];
                                                    }
                                                }];
                                            }
                                            else if(trans.transactionState == SKPaymentTransactionStateFailed) {
                                                NSLog(@"Fail");
                                                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"goumaishibai", nil)];
                                                [[SKPaymentQueue defaultQueue] finishTransaction:trans];
                                            }
                                            
                                        }];//end of buy product
         }
     }];
}



-(void)noconfimClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIView *)diView{
    if (!_diView) {
        _diView=[[UIView alloc] initWithFrame:CGRectMake(10*SCREEN_RADIO, 70*SCREEN_RADIO, screen_width-20*SCREEN_RADIO, screen_height-140*SCREEN_RADIO)];
        _diView.backgroundColor=[UIColor getColor:@"ffffff"];
        _diView.layer.cornerRadius=10*SCREEN_RADIO;
    }
    
    return _diView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screen_width-20*SCREEN_RADIO, (screen_height-200*SCREEN_RADIO)/3*2)];
        _scrollView.pagingEnabled = YES; //使用翻页属性
        _scrollView.delegate = self;//这个是重点
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
        [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH*3, (screen_width-200*SCREEN_RADIO)/3*2)];
    }
    
    return _scrollView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake((screen_width-20*SCREEN_RADIO)/2, CGRectGetMaxY(self.scrollView.frame)-30*SCREEN_RADIO, 15*SCREEN_RADIO, 15*SCREEN_RADIO);//指定位置大小
        _pageControl.numberOfPages = 3;//指定页面个数
        _pageControl.currentPage = 0;//指定pagecontroll的值，默认选中的小白点（第一个）
        //添加委托方法，当点击小白点就执行此方法
        _pageControl.pageIndicatorTintColor = [UIColor getColor:@"a3a3a4"];// 设置非选中页的圆点颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor getColor:@"1b6ae3"]; // 设置选中页的圆点颜色
    }
    
    return _pageControl;
    
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), screen_width-20*SCREEN_RADIO, 1)];
        _lineView.backgroundColor=[UIColor getColor:@"E8F3FF"];
    }
    
    return _lineView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 设置页码
    _pageControl.currentPage = page;
    
    if (page==0) {
        self.menuLabel1.text=NSLocalizedString(@"wuxianciliaotian", nil);
        self.menuLabel2.text=NSLocalizedString(@"wuxiancihudong", nil);
        self.menuLabel3.text=NSLocalizedString(@"zengsong1000jinbi", nil);
    }else if (page==1){
        self.menuLabel1.text=NSLocalizedString(@"100ciliaotian", nil);
        self.menuLabel2.text=NSLocalizedString(@"100cihudong", nil);
        self.menuLabel3.text=NSLocalizedString(@"zengsong100jinbi", nil);
    }else if (page==2){
        self.menuLabel1.text=NSLocalizedString(@"50ciliaotian", nil);
        self.menuLabel2.text=NSLocalizedString(@"50cihudong", nil);
        self.menuLabel3.text=NSLocalizedString(@"zengsong50jinbi", nil);
    }
}

-(UIView *)basicView{
    if (!_basicView) {
        _basicView=[[UIView alloc] initWithFrame:CGRectMake(screen_width*2-40*SCREEN_RADIO, 0, screen_width-20*SCREEN_RADIO, (screen_height-200*SCREEN_RADIO)/3*2)];
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:_basicView.bounds byRoundingCorners:(UIRectCornerTopLeft |UIRectCornerTopRight) cornerRadii:CGSizeMake(10*SCREEN_RADIO, 10*SCREEN_RADIO)];
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        shapeLayer.frame = _basicView.bounds;
        shapeLayer.path = bezierPath.CGPath;
        _basicView.layer.mask = shapeLayer;
        
        
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width/2-50*SCREEN_RADIO, 40*SCREEN_RADIO, 100*SCREEN_RADIO, 80*SCREEN_RADIO)];
        imgView.image=[UIImage imageNamed:@"icon-basic"];
        [_basicView addSubview:imgView];
        
        UILabel *simpLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame)+20*SCREEN_RADIO, screen_width-20*SCREEN_RADIO, 36*SCREEN_RADIO)];
        simpLabel.text=NSLocalizedString(@"jiben", nil);
        simpLabel.textColor=[UIColor getColor:@"FF7381"];
        simpLabel.font=[UIFont systemFontOfSize:36*SCREEN_RADIO];
        simpLabel.textAlignment=NSTextAlignmentCenter;
        [_basicView addSubview:simpLabel];
        
        UILabel *moneyLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(simpLabel.frame)+8*SCREEN_RADIO, screen_width-20*SCREEN_RADIO, 16*SCREEN_RADIO)];
        moneyLabel.text=NSLocalizedString(@"geren", nil);
        moneyLabel.textColor=[UIColor getColor:@"343434"];
        moneyLabel.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        moneyLabel.textAlignment=NSTextAlignmentCenter;
        [_basicView addSubview:moneyLabel];
        
        UILabel *moneyLabel1=[[UILabel alloc] initWithFrame:CGRectMake(95*SCREEN_RADIO, CGRectGetMaxY(simpLabel.frame)+55*SCREEN_RADIO, 0, 41*SCREEN_RADIO)];
        moneyLabel1.text=@"$";
        moneyLabel1.textColor=[UIColor getColor:@"343434"];
        moneyLabel1.font=[UIFont systemFontOfSize:30*SCREEN_RADIO];
        [moneyLabel1 sizeToFit];
        [_basicView addSubview:moneyLabel1];

        UILabel *moneyLabel2=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(moneyLabel1.frame), CGRectGetMaxY(simpLabel.frame)+35*SCREEN_RADIO, 0, 66*SCREEN_RADIO)];
        moneyLabel2.text=@"19.99";
        moneyLabel2.textColor=[UIColor getColor:@"343434"];
        moneyLabel2.font=[UIFont boldSystemFontOfSize:60*SCREEN_RADIO];
        [moneyLabel2 sizeToFit];
        [_basicView addSubview:moneyLabel2];
        
        UILabel *moneyLabel3=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(moneyLabel2.frame), CGRectGetMaxY(simpLabel.frame)+73*SCREEN_RADIO, 0, 19*SCREEN_RADIO)];
        moneyLabel3.text=@"/Month";
        moneyLabel3.textColor=[UIColor getColor:@"343434"];
        moneyLabel3.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        [moneyLabel3 sizeToFit];
        [_basicView addSubview:moneyLabel3];
    }
    
    return _basicView;
}

-(UIView *)premiumView{
    if (!_premiumView) {
        _premiumView=[[UIView alloc] initWithFrame:CGRectMake(screen_width-20*SCREEN_RADIO, 0, screen_width-20*SCREEN_RADIO, (screen_height-200*SCREEN_RADIO)/3*2)];
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:_premiumView.bounds byRoundingCorners:(UIRectCornerTopLeft |UIRectCornerTopRight) cornerRadii:CGSizeMake(10*SCREEN_RADIO, 10*SCREEN_RADIO)];
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        shapeLayer.frame = _premiumView.bounds;
        shapeLayer.path = bezierPath.CGPath;
        _premiumView.layer.mask = shapeLayer;
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width/2-50*SCREEN_RADIO, 40*SCREEN_RADIO, 100*SCREEN_RADIO, 80*SCREEN_RADIO)];
        imgView.image=[UIImage imageNamed:@"icon-premium"];
        [_premiumView addSubview:imgView];
        
        UILabel *simpLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame)+20*SCREEN_RADIO, screen_width-20*SCREEN_RADIO, 36*SCREEN_RADIO)];
        simpLabel.text=NSLocalizedString(@"zhuanye", nil);
        simpLabel.textColor=[UIColor getColor:@"FCB755"];
        simpLabel.font=[UIFont systemFontOfSize:36*SCREEN_RADIO];
        simpLabel.textAlignment=NSTextAlignmentCenter;
        [_premiumView addSubview:simpLabel];
        
        UILabel *moneyLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(simpLabel.frame)+8*SCREEN_RADIO, screen_width-20*SCREEN_RADIO, 16*SCREEN_RADIO)];
        moneyLabel.text=NSLocalizedString(@"shangye", nil);
        moneyLabel.textColor=[UIColor getColor:@"343434"];
        moneyLabel.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        moneyLabel.textAlignment=NSTextAlignmentCenter;
        [_premiumView addSubview:moneyLabel];
        
        UILabel *moneyLabel1=[[UILabel alloc] initWithFrame:CGRectMake(95*SCREEN_RADIO, CGRectGetMaxY(simpLabel.frame)+55*SCREEN_RADIO, 0, 41*SCREEN_RADIO)];
        moneyLabel1.text=@"$";
        moneyLabel1.textColor=[UIColor getColor:@"343434"];
        moneyLabel1.font=[UIFont systemFontOfSize:30*SCREEN_RADIO];
        [moneyLabel1 sizeToFit];
        [_premiumView addSubview:moneyLabel1];
        
        UILabel *moneyLabel2=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(moneyLabel1.frame), CGRectGetMaxY(simpLabel.frame)+35*SCREEN_RADIO, 0, 66*SCREEN_RADIO)];
        moneyLabel2.text=@"39.99";
        moneyLabel2.textColor=[UIColor getColor:@"343434"];
        moneyLabel2.font=[UIFont boldSystemFontOfSize:60*SCREEN_RADIO];
        [moneyLabel2 sizeToFit];
        [_premiumView addSubview:moneyLabel2];
        
        UILabel *moneyLabel3=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(moneyLabel2.frame), CGRectGetMaxY(simpLabel.frame)+73*SCREEN_RADIO, 0, 19*SCREEN_RADIO)];
        moneyLabel3.text=@"/Month";
        moneyLabel3.textColor=[UIColor getColor:@"343434"];
        moneyLabel3.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        [moneyLabel3 sizeToFit];
        [_premiumView addSubview:moneyLabel3];
    }
    
    return _premiumView;
}

-(UIView *)ultimateView{
    if (!_ultimateView) {
        _ultimateView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width-20*SCREEN_RADIO, (screen_height-200*SCREEN_RADIO)/3*2)];
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:_ultimateView.bounds byRoundingCorners:(UIRectCornerTopLeft |UIRectCornerTopRight) cornerRadii:CGSizeMake(10*SCREEN_RADIO, 10*SCREEN_RADIO)];
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        shapeLayer.frame = _ultimateView.bounds;
        shapeLayer.path = bezierPath.CGPath;
        _ultimateView.layer.mask = shapeLayer;
        _ultimateView.backgroundColor=[UIColor clearColor];
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width/2-50*SCREEN_RADIO, 40*SCREEN_RADIO, 100*SCREEN_RADIO, 80*SCREEN_RADIO)];
        imgView.image=[UIImage imageNamed:@"icon-ultimate"];
        [_ultimateView addSubview:imgView];
        
        UILabel *simpLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame)+20*SCREEN_RADIO, screen_width-20*SCREEN_RADIO, 36*SCREEN_RADIO)];
        simpLabel.text=NSLocalizedString(@"zhongji", nil);
        simpLabel.textColor=[UIColor getColor:@"2CCA70"];
        simpLabel.font=[UIFont systemFontOfSize:36*SCREEN_RADIO];
        simpLabel.textAlignment=NSTextAlignmentCenter;
        [_ultimateView addSubview:simpLabel];
        
        UILabel *moneyLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(simpLabel.frame)+8*SCREEN_RADIO, screen_width-20*SCREEN_RADIO, 16*SCREEN_RADIO)];
        moneyLabel.text=NSLocalizedString(@"qiye", nil);
        moneyLabel.textColor=[UIColor getColor:@"343434"];
        moneyLabel.font=[UIFont systemFontOfSize:12*SCREEN_RADIO];
        moneyLabel.textAlignment=NSTextAlignmentCenter;
        [_ultimateView addSubview:moneyLabel];
        
        UILabel *moneyLabel1=[[UILabel alloc] initWithFrame:CGRectMake(95*SCREEN_RADIO, CGRectGetMaxY(simpLabel.frame)+55*SCREEN_RADIO, 0, 41*SCREEN_RADIO)];
        moneyLabel1.text=@"$";
        moneyLabel1.textColor=[UIColor getColor:@"343434"];
        moneyLabel1.font=[UIFont systemFontOfSize:30*SCREEN_RADIO];
        [moneyLabel1 sizeToFit];
        [_ultimateView addSubview:moneyLabel1];
        
        UILabel *moneyLabel2=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(moneyLabel1.frame), CGRectGetMaxY(simpLabel.frame)+35*SCREEN_RADIO, 0, 66*SCREEN_RADIO)];
        moneyLabel2.text=@"59.99";
        moneyLabel2.textColor=[UIColor getColor:@"343434"];
        moneyLabel2.font=[UIFont boldSystemFontOfSize:60*SCREEN_RADIO];
        [moneyLabel2 sizeToFit];
        [_ultimateView addSubview:moneyLabel2];
        
        UILabel *moneyLabel3=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(moneyLabel2.frame), CGRectGetMaxY(simpLabel.frame)+73*SCREEN_RADIO, 0, 19*SCREEN_RADIO)];
        moneyLabel3.text=@"/Year";
        moneyLabel3.textColor=[UIColor getColor:@"343434"];
        moneyLabel3.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
        [moneyLabel3 sizeToFit];
        [_ultimateView addSubview:moneyLabel3];
    }
    
    return _ultimateView;
}

-(UILabel *)menuLabel1{
    if (!_menuLabel1) {
        _menuLabel1=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lineView.frame)+25*SCREEN_RADIO, screen_width-20*SCREEN_RADIO, 22*SCREEN_RADIO)];
        _menuLabel1.textColor=[UIColor getColor:@"8093AC"];
        _menuLabel1.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _menuLabel1.text=NSLocalizedString(@"wuxianciliaotian", nil);
        _menuLabel1.textAlignment=NSTextAlignmentCenter;
    }
    
    return _menuLabel1;
}

-(UILabel *)menuLabel2{
    if (!_menuLabel2) {
        _menuLabel2=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menuLabel1.frame)+10*SCREEN_RADIO, screen_width-20*SCREEN_RADIO, 22*SCREEN_RADIO)];
        _menuLabel2.textColor=[UIColor getColor:@"8093AC"];
        _menuLabel2.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _menuLabel2.text=NSLocalizedString(@"wuxiancihudong", nil);
        _menuLabel2.textAlignment=NSTextAlignmentCenter;
    }
    
    return _menuLabel2;
}

-(UILabel *)menuLabel3{
    if (!_menuLabel3) {
        _menuLabel3=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menuLabel2.frame)+10*SCREEN_RADIO, screen_width-20*SCREEN_RADIO, 22*SCREEN_RADIO)];
        _menuLabel3.textColor=[UIColor getColor:@"8093AC"];
        _menuLabel3.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _menuLabel3.text=NSLocalizedString(@"zengsong1000jinbi", nil);
        _menuLabel3.textAlignment=NSTextAlignmentCenter;
    }
    
    return _menuLabel3;
}

-(RkyExtendedHitButton *)confimBtn{
    if (!_confimBtn) {
        _confimBtn=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake((screen_width-20*SCREEN_RADIO)/2-(screen_width-140*SCREEN_RADIO)/2, CGRectGetMaxY(self.menuLabel3.frame)+15*SCREEN_RADIO, screen_width-140*SCREEN_RADIO, 40*SCREEN_RADIO)];
        [_confimBtn setTitle:NSLocalizedString(@"jixu", nil) forState:UIControlStateNormal];
        [_confimBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:UIControlStateNormal];
        _confimBtn.titleLabel.font=[UIFont systemFontOfSize:15*SCREEN_RADIO];
        _confimBtn.layer.cornerRadius=20*SCREEN_RADIO;
        [_confimBtn setBackgroundColor:[UIColor getColor:@"1b6ae3"]];
        [_confimBtn addTarget:self action:@selector(confimClick) forControlEvents:UIControlEventTouchUpInside];
        _confimBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _confimBtn;
}

-(RkyExtendedHitButton *)noBtn{
    if (!_noBtn) {
        _noBtn=[[RkyExtendedHitButton alloc] initWithFrame:CGRectMake((screen_width-20*SCREEN_RADIO)/2-(screen_width-140*SCREEN_RADIO)/2, CGRectGetMaxY(self.confimBtn.frame), screen_width-140*SCREEN_RADIO, 40*SCREEN_RADIO)];
        [_noBtn setTitle:NSLocalizedString(@"noxiexie", nil) forState:UIControlStateNormal];
        [_noBtn setTitleColor:[UIColor getColor:@"c2c6cc"] forState:UIControlStateNormal];
        _noBtn.titleLabel.font=[UIFont systemFontOfSize:15*SCREEN_RADIO];
        _noBtn.layer.cornerRadius=20*SCREEN_RADIO;
        [_noBtn addTarget:self action:@selector(noconfimClick) forControlEvents:UIControlEventTouchUpInside];
        _noBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    }
    
    return _noBtn;
}

@end
