//
//  MineSettingTextView.m
//  ChineseGirl
//
//  Created by Wallen on 2017/10/15.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "MineSettingTextView.h"
#import "CGBottleTextView.h"
@interface MineSettingTextView()<UITextViewDelegate>{
    int _maxNum;
    SettingTextBlock settingTextBlock;
    NSString *_textStr;
}
@property(nonatomic,strong)CGBottleTextView *cutomView;
@property(nonatomic,strong)UILabel *lbNums;
@end
@implementation MineSettingTextView

- (instancetype)initWithFrame:(CGRect)frame withMaxNum:(int)maxNum withTextBlock:(SettingTextBlock)block withTextStr:(NSString *)textStr
{
    self = [super initWithFrame:frame];
    if (self) {
        _maxNum=maxNum;
        settingTextBlock=block;
        _textStr=textStr;
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews{
    [self addSubview:self.cutomView];
    [self addSubview:self.lbNums];
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > _maxNum)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:_maxNum];
        
        [textView setText:s];
    }
    
    //不让显示负数
    self.lbNums.text = [NSString stringWithFormat:@"%ld",MAX(0,_maxNum - existTextNum)];
    
    if (settingTextBlock) {
        settingTextBlock(textView.text);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = _maxNum - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}


-(CGBottleTextView *)cutomView{
    if (!_cutomView) {
        _cutomView=[[CGBottleTextView alloc] initWithFrame:CGRectMake(0, 0, screen_width, self.frame.size.height)];
        _cutomView.backgroundColor=[UIColor whiteColor];
        _cutomView.textColor=[UIColor blackColor];
        _cutomView.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
        _cutomView.delegate=self;
        _cutomView.text=_textStr;
        
    }
    
    return _cutomView;
}

-(UILabel *)lbNums{
    if (!_lbNums) {
        _lbNums=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cutomView.frame)-25*SCREEN_RADIO, screen_width-30*SCREEN_RADIO, 18*SCREEN_RADIO)];
        _lbNums.text=[NSString stringWithFormat:@"%ld",(long)_maxNum];
        _lbNums.textColor=[UIColor getColor:@"99A3A9"];
        _lbNums.font=[UIFont systemFontOfSize:18*SCREEN_RADIO];
        _lbNums.textAlignment=NSTextAlignmentRight;
    }
    
    return _lbNums;
}

@end
