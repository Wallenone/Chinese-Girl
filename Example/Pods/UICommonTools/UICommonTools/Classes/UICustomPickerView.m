//
//  UICustomPickerView.m
//  Huifenqi
//
//  Created by wallen on 2017/9/19.
//  Copyright © 2017年 qiuyu wang. All rights reserved.
//

#import "UICustomPickerView.h"
#import "CGPch.h"
@interface UICustomPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSArray *_pickerData;
    NSString *_title;
    CheckBlock checkBlock;
    NSInteger selectRow;
}
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)CALayer *maskLayer;
@end
@implementation UICustomPickerView

-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)pickerArray withTitle:(NSString *)title withCheckBlock:(CheckBlock)block{
    if (self=[super initWithFrame:frame]) {
        _pickerData=pickerArray;
        _title=title;
        checkBlock=block;
        selectRow=_pickerData.count-1;
        [self showMask];
        [self addSubViews];
    }
    
    return self;
}

-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView=[[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-246*SCREEN_RADIO, SCREEN_WIDTH, 246*SCREEN_RADIO)];
        _pickerView.backgroundColor=[UIColor whiteColor];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [_pickerView selectRow:_pickerData.count-1  inComponent:0  animated:YES];
    }
    
    return _pickerView;
}

-(CALayer *)maskLayer{
    if (!_maskLayer) {
        _maskLayer=[CALayer layer];
        [_maskLayer setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_maskLayer setBackgroundColor:[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4] CGColor]];
    }
    return _maskLayer;
}

-(void)addSubViews{
    [self addSubview:self.pickerView];
    UIView *picView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-246*SCREEN_RADIO, SCREEN_WIDTH, 30*SCREEN_RADIO)];
    picView.backgroundColor=[UIColor getColor:@"F8F8F8"];
    [self addSubview:picView];
    
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 25*SCREEN_RADIO)];
    titleLabel.text=_title;
    titleLabel.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
    titleLabel.textColor=[UIColor getColor:@"333333"];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [picView addSubview:titleLabel];
    
    
    RkyExtendedHitButton *cancelBtn = [[RkyExtendedHitButton alloc] initWithFrame:CGRectMake(42*SCREEN_RADIO, 5*SCREEN_RADIO, 30*SCREEN_RADIO, 20*SCREEN_RADIO)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor getColor:@"666666"] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
    [cancelBtn addTarget:self action:@selector(toolBarCanelClick) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    [picView addSubview:cancelBtn];
    
    
    RkyExtendedHitButton *okBtn = [[RkyExtendedHitButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-63*SCREEN_RADIO, 5*SCREEN_RADIO, 30*SCREEN_RADIO, 20*SCREEN_RADIO)];
    [okBtn setTitle:@"完成" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor getColor:@"3CD1C1"] forState:UIControlStateNormal];
    okBtn.titleLabel.font=[UIFont systemFontOfSize:14*SCREEN_RADIO];
    [okBtn addTarget:self action:@selector(toolBarDoneClick) forControlEvents:UIControlEventTouchUpInside];
    okBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-25, -25, -25, -25);
    [picView addSubview:okBtn];

}


- (void) showMask {
    [self.layer addSublayer:self.maskLayer];
}

-(void)toolBarCanelClick{
    [self removeFromSuperview];
    if (checkBlock) {
        checkBlock(@"");
    }
}
-(void)toolBarDoneClick{
    [self removeFromSuperview];
    if (checkBlock) {
        checkBlock([_pickerData objectAtIndex:selectRow]);
    }
}


#pragma mark - 代理方法
/**
 *  返回一共有多少列
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
/**
 *  返回第component列的行数
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    return _pickerData.count;
}

/**
 *  返回每一列每一行的内容
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [_pickerData objectAtIndex:row];
}
/**
 *  将当前选中的列和行的内容显示到label
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    selectRow=row;
}


@end
