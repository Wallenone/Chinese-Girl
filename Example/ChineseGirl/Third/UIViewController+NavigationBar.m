//
//  UIViewController+NavigationBar.m
//  Pods
//
//  Created by 万圣 on 2017/5/10.
//
//

#import "UIViewController+NavigationBar.h"
#import <objc/runtime.h>
static const void *naviDelegateKey = &naviDelegateKey;

@implementation UIViewController (NavigationBar)

@dynamic naviDelegate;

- (void)setUpNavWithTitle:(NSString *)title leftIcon:(NSString *)leftIcon rightIcon:(NSString *)rigthIcon leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle delegate:(id<HzfNavigationBarDelegate>)delegate{
    
    self.naviDelegate = delegate;
    [self setUpWithTitle:title leftIcon:leftIcon rightIcon:rigthIcon leftTitle:leftTitle rightTitle:rightTitle];
    
}

- (void)setUpWithTitle:(NSString *)title leftIcon:(NSString *)leftIcon rightIcon:(NSString *)rigthIcon leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle{
    
    UINavigationBar * bar = self.navigationController.navigationBar;
    bar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[self getColor:@"ffffff"]];
    bar.tintColor = [UIColor blackColor];
    NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:19.0],
                          NSForegroundColorAttributeName:[UIColor blackColor]};
    bar.titleTextAttributes = att;
    
    self.navigationItem.title = title;
    
    if (leftIcon != nil || leftTitle != nil) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 10, 19)];
        btn.tag = 222;
        [btn setContentMode:UIViewContentModeCenter];
        if (leftTitle !=nil){
            [btn setTitle:leftTitle forState:UIControlStateNormal];
        }
        if (leftIcon !=nil){
            [btn setImage:[UIImage imageNamed:leftIcon] forState:UIControlStateNormal];
        }
        
        [btn addTarget:self action:@selector(barBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = item;
    }
    
    if (rigthIcon != nil || rightTitle != nil) {
        UIButton * btn = [[UIButton alloc]init];
        btn.tag = 333;
        [btn setContentMode:UIViewContentModeCenter];
        [btn addTarget:self action:@selector(barBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if (rightTitle !=nil){
            [btn setFrame:CGRectMake(0, 0, 50, 30)];
            [btn setTitle:rightTitle forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize: 16];
        }
        if (rigthIcon !=nil){
            [btn setFrame:CGRectMake(0, 0, 23, 23)];
            [btn setImage:[UIImage imageNamed:rigthIcon] forState:UIControlStateNormal];
        }
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
        self.navigationItem.rightBarButtonItem = item;
    }
    
    
}


#pragma mark ---  EventResponse

- (void)barBtnClicked:(UIButton *)btn{
    
    NaviClickedBtnType type = btn.tag == 222 ? NaviClickedBtnTypeLeft : NaviClickedBtnTypeRight;
    
    if (type == NaviClickedBtnTypeLeft) {
        if ([self.naviDelegate respondsToSelector:@selector(NavigationBarLeftButtonClicked)]) {
            [self.naviDelegate NavigationBarLeftButtonClicked];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        if ([self.naviDelegate respondsToSelector:@selector(NavigationBarRightButtonClicked)]){
            [self.naviDelegate NavigationBarRightButtonClicked];
        }
    }
}

#pragma mark ---  getter && setter

- (void)setNaviDelegate:(id<HzfNavigationBarDelegate>)naviDelegate{
    objc_setAssociatedObject(self, naviDelegateKey, naviDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<HzfNavigationBarDelegate>)naviDelegate{
    return objc_getAssociatedObject(self, naviDelegateKey);
}

-(UIColor *)getColor:(NSString*)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
}

@end
