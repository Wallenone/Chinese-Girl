//
//  NewsBottomMessage.m
//  ChineseGirl
//
//  Created by wallen on 2017/8/27.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "NewsBottomMessage.h"
#import "UIMessageCustom.h"


@interface NewsBottomMessage()<UITextViewDelegate>{
    DidBeginEditing didBeginEditing;
    SubmitEdit submitEdit;
}

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView *toplineView;
@property(nonatomic,strong)UIMessageCustom *messageView;
@property(nonatomic,strong)UIButton *rightBtn;
@end
@implementation NewsBottomMessage

- (instancetype)initWithFrame:(CGRect)frame withDidBeginEditing:(DidBeginEditing)block withDidSubmitEdit:(SubmitEdit)submitBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor getColor:@"FFFFFF"];
        didBeginEditing=block;
        submitEdit=submitBlock;
        [self addSubViews];
    }
    return self;
}

-(void)setMessageContent:(NSString *)content{
    self.messageView.placeholder=@"";
    self.messageView.text=content;
}

//-(void)setFirstResponderAction{
//    [self.messageView resignFirstResponder];
//}
//
//-(BOOL)getIsFirstResponder{
//    return self.messageView.isFirstResponder;
//}
//
//-(void)setBeResponderAction{
//    [self.messageView becomeFirstResponder];
//}


-(void)addSubViews{
    [self addSubview:self.bgView];
    [self addSubview:self.toplineView];
    [self addSubview:self.messageView];
    [self addSubview:self.rightBtn];
}

-(void)leftBtnClick{

}

-(void)rightBtnClick{
    [self setresignFirstResponderAction];
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (didBeginEditing!=nil) {
        didBeginEditing(textView);
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>0) {
        self.messageView.placeholder=@"";
    }else{
        self.messageView.placeholder=NSLocalizedString(@"messages", nil);
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    //输入框编辑完成,视图恢复到原始状态
}

-(void)setresignFirstResponderAction{  //释放键盘
    if (submitEdit) {
        if (self.messageView.text.length>0) {
            [self.messageView resignFirstResponder];
            submitEdit(self.messageView.text);
            self.messageView.text=@"";
            self.messageView.placeholder=NSLocalizedString(@"messages", nil);
        }
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        
        [self setresignFirstResponderAction];
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
//    // 规定输入框最大高度。
//    CGFloat maxHeight =120.0f;
//    CGRect frame = textView.frame;
//    // 计算文字高度
//    CGSize constraintSize =CGSizeMake(frame.size.width,MAXFLOAT);
//    CGSize size = [textView sizeThatFits:constraintSize];
//    if (size.height >= maxHeight){
//        size.height = maxHeight;
//        textView.scrollEnabled =YES;   // 大于最大高度允许滚动
//    }else{
//        textView.scrollEnabled =NO;    // 小于最大高度不允许滚动
//    }

    return YES;
}

- (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
    CGSize constraint = CGSizeMake(textView.contentSize.width , CGFLOAT_MAX);
    CGRect size = [strText boundingRectWithSize:constraint
                                        options:(NSStringDrawingUsesLineFragmentOrigin)
                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17*SCREEN_RADIO]}
                                        context:nil];
    float textHeight = size.size.height + 23.0*SCREEN_RADIO;
    return textHeight;
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _bgView.backgroundColor=[UIColor whiteColor];
    }
    
    return _bgView;
}

-(UIView *)toplineView{
    if (!_toplineView) {
        _toplineView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 0.5)];
        _toplineView.backgroundColor=[UIColor getColor:@"CED7DB"];
    }
    
    return _toplineView;
}

-(UIMessageCustom *)messageView{
    if (!_messageView) {
        _messageView=[[UIMessageCustom alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 7.5*SCREEN_RADIO, screen_width-72*SCREEN_RADIO, 44*SCREEN_RADIO)];
        _messageView.layer.cornerRadius=6*SCREEN_RADIO;
        _messageView.placeholder=NSLocalizedString(@"messages", nil);
        _messageView.placeholderFont=[UIFont systemFontOfSize:17*SCREEN_RADIO];
        _messageView.placeholderColor=[UIColor getColor:@"232627s"];
        _messageView.font=[UIFont systemFontOfSize:17*SCREEN_RADIO];
        _messageView.textColor = [UIColor getColor:@"232627"];
        _messageView.backgroundColor=[UIColor getColor:@"F5F5F5"];
        _messageView.autocorrectionType = UITextAutocorrectionTypeNo;
        _messageView.textAlignment = NSTextAlignmentLeft;
        _messageView.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _messageView.returnKeyType =UIReturnKeyDone;
        _messageView.delegate=self;
        _messageView.textContainerInset=UIEdgeInsetsMake(10*SCREEN_RADIO, 17*SCREEN_RADIO, 13*SCREEN_RADIO, 10*SCREEN_RADIO);
        _messageView.layer.masksToBounds = YES;
        _messageView.scrollEnabled = YES;
        _messageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    }
    
    return _messageView;
}

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.messageView.frame)+ 15*SCREEN_RADIO, 16.5*SCREEN_RADIO, 27.1*SCREEN_RADIO, 27.1*SCREEN_RADIO)];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"NewsSend"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _rightBtn;
}
@end
