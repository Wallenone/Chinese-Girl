//
//  XLVideoCell.m
//  XLVideoPlayer
//
//  Created by Shelin on 16/3/22.
//  Copyright © 2016年 GreatGate. All rights reserved.
//  https://github.com/ShelinShelin

#import "XLVideoCell.h"
#import "UIImageView+WebCache.h"
#import "MyIndexViewController.h"
@interface XLVideoCell (){
    CGFloat _imgHeight;
}
@property (strong, nonatomic)CGShuoShuo *model;
@property(nonatomic,strong)NSString *imgUrl;
@property(nonatomic,strong)UIView *menuView;
@property(nonatomic,strong)UIImageView *iconImgView;
@property(nonatomic,strong)UIButton *iconBtn;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *location;
@property(nonatomic,strong)UILabel *content;
@property(nonatomic,strong)UIImageView *playView;
@end
@implementation XLVideoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(CGShuoShuo *)tmodel withImg:(NSString *)imgUrl{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgHeight=284*SCREEN_RADIO;
        self.backgroundColor=[UIColor getColor:@"EBEBEB"];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.model=tmodel;
        self.imgUrl=imgUrl;
        [self creatSubView];
    }
    
    return self;
}

-(void)hiddenPlayView:(BOOL)state{
    self.videoImageView.hidden=state;
    self.playView.hidden=state;
}

-(void)iconClick{
    MyIndexViewController *indexVC=[[MyIndexViewController alloc] init];
    indexVC.ids=[self.model.uid integerValue];
    [[CGCommonToolsNode getCurrentVC].navigationController pushViewController:indexVC animated:NO];
}

-(UIView *)menuView{
    if (!_menuView) {
        _menuView=[[UIView alloc] initWithFrame:CGRectMake(0, 0.5, screen_width, 56*SCREEN_RADIO)];
        _menuView.backgroundColor=[UIColor whiteColor];
    }
    return _menuView;
}

-(UIImageView *)iconImgView{
    if (!_iconImgView) {
        _iconImgView=[[UIImageView alloc] initWithFrame:CGRectMake(10*SCREEN_RADIO, 12*SCREEN_RADIO, 32*SCREEN_RADIO, 32*SCREEN_RADIO)];
        [_iconImgView sd_setImageWithURL:[NSURL URLWithString:self.model.icon]];
        _iconImgView.layer.cornerRadius=16*SCREEN_RADIO;
        _iconImgView.layer.borderWidth=1;
        _iconImgView.layer.borderColor=[UIColor getColor:@"DCDCDC"].CGColor;
        _iconImgView.clipsToBounds=YES;
    }
    
    return _iconImgView;
}

-(UIButton *)iconBtn{
    if (!_iconBtn) {
        _iconBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70*SCREEN_RADIO, 56*SCREEN_RADIO)];
        [_iconBtn addTarget:self action:@selector(iconClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _iconBtn;
}

-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImgView.frame)+10*SCREEN_RADIO , 13*SCREEN_RADIO, 150*SCREEN_RADIO, 15*SCREEN_RADIO)];
        _nickName.text=self.model.nickName;
        _nickName.textColor=[UIColor getColor:@"000000"];
        _nickName.font=[UIFont systemFontOfSize:13*SCREEN_RADIO];
    }
    
    return _nickName;
}

-(UILabel *)location{
    if (!_location) {
        _location=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImgView.frame)+10*SCREEN_RADIO , CGRectGetMaxY(self.nickName.frame), 150*SCREEN_RADIO, 15*SCREEN_RADIO)];
        _location.text=self.model.address;
        _location.textColor=[UIColor getColor:@"BAB8B8"];
        _location.font=[UIFont systemFontOfSize:13*SCREEN_RADIO];
    }
    
    return _location;
}

-(UILabel *)content{
    if (!_content) {
        _content=[[UILabel alloc] initWithFrame:CGRectMake(0, 19*SCREEN_RADIO, screen_width-10*SCREEN_RADIO,15*SCREEN_RADIO)];
        _content.text=self.model.toContent;
        _content.textColor=[UIColor getColor:@"000000"];
        _content.font=[UIFont systemFontOfSize:13*SCREEN_RADIO];
        _content.textAlignment=NSTextAlignmentRight;
    }
    
    return _content;
}

-(UIImageView *)playView{
    if (!_playView) {
        _playView=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width/2-29*SCREEN_RADIO, 113*SCREEN_RADIO, 58*SCREEN_RADIO, 58*SCREEN_RADIO)];
        _playView.image=[UIImage imageNamed:@"PLAYVideo"];
    }
    
    return _playView;
}



-(UIImageView *)videoImageView{
    if (!_videoImageView) {
        _videoImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menuView.frame), screen_width, _imgHeight)];
        _videoImageView.contentMode =  UIViewContentModeScaleAspectFill;
        _videoImageView.clipsToBounds=YES;
        [_videoImageView sd_setImageWithURL:[NSURL URLWithString:self.imgUrl]];
    }
    
    return _videoImageView;
}

- (void)creatSubView {
    [self addSubview:self.menuView];
    [self.menuView addSubview:self.iconImgView];
    [self.menuView addSubview:self.iconBtn];
    [self.menuView addSubview:self.nickName];
    [self.menuView addSubview:self.location];
    [self.menuView addSubview:self.content];
    [self addSubview:self.videoImageView];
    [self.videoImageView addSubview:self.playView];
}

@end
