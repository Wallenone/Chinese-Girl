//
//  MyIndexCell.m
//  瀑布流
//
//  Created by iMac on 16/12/26.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "MyIndexCell.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "CGPinglunren.h"
#import "CGPinglunModel.h"
#import "CGPinglun.h"
@interface MyIndexCell(){
    CGFloat total_height;
    CommitClick commitClick;
}
@property(nonatomic,strong)CGShuoShuo *myIndexModel;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *nickNameLabel;
@property(nonatomic,strong)UILabel *timeDateLabel;
@property(nonatomic,strong)UITextView *contentLabel;
@property(nonatomic,strong)UIImageView *picImgView;
@property(nonatomic,strong)UIButton *likeImgView;
@property(nonatomic,strong)UILabel *likeLabel;
@property(nonatomic,strong)NSMutableArray *imgViewArr;
@property(nonatomic,strong)UIButton *commitView;
@property(nonatomic,strong)UIImageView *avaterCommit;
@property(nonatomic,strong)UIButton *allCommit;
@property(nonatomic,strong)UILabel *allCommitLabel;
@property(nonatomic,strong)UIView *bottomLine;
@property(nonatomic,strong)UIImageView *VideoimageView;
@property(nonatomic,strong)UIImageView *playView;
@end
@implementation MyIndexCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(CGShuoShuo *)indexModel withCommitClick:(CommitClick)block{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        total_height=0;
        commitClick=block;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor whiteColor];
        self.myIndexModel = indexModel;
        [self creatSubView];
    }
    
    return self;
}

-(NSMutableArray *)imgViewArr{
    if (!_imgViewArr) {
        _imgViewArr=[NSMutableArray new];
    }
    
    return _imgViewArr;
}

-(CGFloat)getCellHeight{
    return total_height;
}


-(CGRect)getVideoimageViewFrame{
   return CGRectMake(0, CGRectGetMaxY(self.contentLabel.frame), screen_width, 284*SCREEN_RADIO);
}

-(void)hiddenPlayView:(BOOL)state{
    self.VideoimageView.hidden=state;
    self.playView.hidden=state;
}

- (void)creatSubView {
    [self addSubview:self.iconImageView];
    [self addSubview:self.nickNameLabel];
    [self addSubview:self.timeDateLabel];
    [self addSubview:self.contentLabel];
    total_height=CGRectGetMaxY(self.contentLabel.frame);
    if ([self.myIndexModel.type integerValue]==1) {
        [self setImgBrower];
    }else if([self.myIndexModel.type integerValue]==2){
        [self setVideoImg];
    }
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.likeImgView];
    [self addSubview:self.likeLabel];
    [self addSubview:self.allCommitLabel];
    [self addSubview:self.allCommit];
    [self addSubview:self.commitView];
    [self addSubview:self.bottomLine];
    [self setCommitUI];
}

-(void)setpictureFrame:(CGRect)imgViewFrame withTag:(NSInteger)_tag withUrl:(NSString *)_url{
    UIImage *placeholder = [UIImage imageNamed:@"timeline_image_loading.png"];
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    
    imageView.frame = imgViewFrame;
    
    
    
    // 事件监听
    imageView.tag = _tag;
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
    
    // 内容模式
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    // 下载图片
    [imageView setImageURLStr:_url placeholder:placeholder];
    
    [self.imgViewArr addObject:imageView];
    total_height=CGRectGetMaxY(imageView.frame);
}

-(void)setVideoImg{
    [self addSubview:self.VideoimageView];
    [self addSubview:self.playView];
    total_height=CGRectGetMaxY(self.VideoimageView.frame);
}

-(void)setImgBrower{
    CGFloat width = (screen_width-42*SCREEN_RADIO)/3;
    CGFloat height = (screen_width-42*SCREEN_RADIO)/3;
    CGFloat margin = 6*SCREEN_RADIO;
    CGFloat startX = 15 *SCREEN_RADIO;
    CGFloat startY =CGRectGetMaxY(self.contentLabel.frame);
    if (self.myIndexModel.content.length<=0) {
        startY =CGRectGetMaxY(self.contentLabel.frame)-15*SCREEN_RADIO;
    }
    
    if (self.myIndexModel.pictures.count==1) {
        [self setpictureFrame:CGRectMake(10*SCREEN_RADIO, CGRectGetMaxY(self.contentLabel.frame), screen_width-20*SCREEN_RADIO, 284*SCREEN_RADIO) withTag:0 withUrl:self.myIndexModel.pictureBigs[0]];
    }else if(self.myIndexModel.pictures.count==2){
        for (int i=0; i<self.myIndexModel.pictures.count; i++) {
            // 计算位置
            [self setpictureFrame:CGRectMake(10*SCREEN_RADIO+i*(screen_width-25*SCREEN_RADIO)/2+i*5, CGRectGetMaxY(self.contentLabel.frame), (screen_width-25*SCREEN_RADIO)/2, 284*SCREEN_RADIO) withTag:i withUrl:self.myIndexModel.pictureBigs[i]];
        }
        
    }else if (self.myIndexModel.pictures.count==4){
        for (int i=0; i<self.myIndexModel.pictures.count; i++) {
            // 计算位置
            CGFloat _startX=10*SCREEN_RADIO+i*(screen_width-25*SCREEN_RADIO)/2+i*5*SCREEN_RADIO;
            CGFloat _startY=CGRectGetMaxY(self.contentLabel.frame)+(284/2)*SCREEN_RADIO;
            if (i==2) {
                _startX=10*SCREEN_RADIO;
                _startY = CGRectGetMaxY(self.contentLabel.frame)+(284/2)*SCREEN_RADIO;
            }else if(i==3){
                _startX = 10*SCREEN_RADIO+1*(screen_width-25*SCREEN_RADIO)/2+1*5*SCREEN_RADIO;
                _startY = CGRectGetMaxY(self.contentLabel.frame)+(284/2)*SCREEN_RADIO;
            }else{
                _startY=CGRectGetMaxY(self.contentLabel.frame);
            }
            
            
            [self setpictureFrame:CGRectMake(_startX, _startY, (screen_width-25*SCREEN_RADIO)/2, (284/2-6)*SCREEN_RADIO) withTag:i withUrl:self.myIndexModel.pictures[i]];
        }
    }
    else{
        for (int i = 0; i<self.myIndexModel.pictures.count; i++) {
            // 计算位置
            int row = i/3;
            int column = i%3;
            CGFloat x = startX + column * (width + margin);
            CGFloat y = startY + row * (height + margin);
            [self setpictureFrame:CGRectMake(x, y, width, height) withTag:i withUrl:self.myIndexModel.pictures[i]];
        }
    }
}


- (void)tapImage:(UITapGestureRecognizer *)tap
{
    NSUInteger count = self.myIndexModel.pictures.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = self.myIndexModel.pictureBigs[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        photo.srcImageView = self.imgViewArr[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

-(void)allCommitClick{
    if (commitClick) {
        commitClick();
    }
}

-(void)giftClick{
    
}

-(void)likeClick:(UIButton *)button{
    if ([button.currentImage isEqual:[UIImage imageNamed:@"Likecell"]]) {
        [button setImage:[UIImage imageNamed:@"LikeTo"] forState:UIControlStateNormal];
        self.myIndexModel.isLike=YES;
        [[CGSingleCommitData sharedInstance] addfavourites:[NSString stringWithFormat:@"%@-%@",self.myIndexModel.ids,self.myIndexModel.sort]];
    }
    else {
        [button setImage:[UIImage imageNamed:@"Likecell"] forState:UIControlStateNormal];
        self.myIndexModel.isLike=NO;
        [[CGSingleCommitData sharedInstance] deletefavourite:[NSString stringWithFormat:@"%@-%@",self.myIndexModel.ids,self.myIndexModel.sort]];
    }
    
}

-(void)setCommitUI{
    NSInteger _count=self.myIndexModel.pinglunid.count;
    if (_count>3) {
        _count=3;
    }
    
    for (int i=0; i<_count; i++) {
        
        NSDictionary *dict= [[CGPinglun reloadCommits:self.myIndexModel.pinglunid] objectAtIndex:i];
        
        NSString *nickNameStr=[dict objectForKey:@"nickName"];
        NSString *contentStr=[dict objectForKey:@"content"];
    
        UILabel *nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.likeImgView.frame)+8.5*SCREEN_RADIO, 5*SCREEN_RADIO+(14+10)*i, 0, 14*SCREEN_RADIO)];
        nickName.text=  nickNameStr;
        nickName.textColor=[UIColor getColor:@"274E6E"];
        nickName.font=[UIFont boldSystemFontOfSize:14*SCREEN_RADIO];
        [nickName sizeToFit];
        [self.commitView addSubview:nickName];
        
        UILabel *commitLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nickName.frame)+10*SCREEN_RADIO, 5*SCREEN_RADIO+(14+10)*i, screen_width-102*SCREEN_RADIO, 17*SCREEN_RADIO)];
        commitLabel.text=contentStr;
        commitLabel.textColor=[UIColor getColor:@"99A3A9"];
        commitLabel.font=[UIFont boldSystemFontOfSize:14*SCREEN_RADIO];
        [self.commitView addSubview:commitLabel];
    }
}

-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10*SCREEN_RADIO, 12*SCREEN_RADIO, 32*SCREEN_RADIO, 32*SCREEN_RADIO)];
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:self.myIndexModel.icon]];
        _iconImageView.layer.cornerRadius = 16*SCREEN_RADIO;
        _iconImageView.layer.borderColor=[UIColor getColor:@"DCDCDC"].CGColor;
        _iconImageView.layer.borderWidth=1;
        _iconImageView.clipsToBounds=YES;
    }
    
    return _iconImageView;
}


-(UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+10*SCREEN_RADIO, 13*SCREEN_RADIO, 200*SCREEN_RADIO, 15*SCREEN_RADIO)];
        _nickNameLabel.text=self.myIndexModel.nickName;
        _nickNameLabel.textColor=[UIColor getColor:@"000000"];
        _nickNameLabel.font=[UIFont boldSystemFontOfSize:13*SCREEN_RADIO];
    }
    
    return _nickNameLabel;
}

-(UILabel *)timeDateLabel{
    if (!_timeDateLabel) {
        _timeDateLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+10*SCREEN_RADIO, CGRectGetMaxY(self.nickNameLabel.frame)*SCREEN_RADIO, 200*SCREEN_RADIO, 15*SCREEN_RADIO)];
        _timeDateLabel.text=@"China.BeiJing";
        _timeDateLabel.textColor=[UIColor getColor:@"7C858A"];
        _timeDateLabel.font=[UIFont systemFontOfSize:13*SCREEN_RADIO];
    }
    
    return _timeDateLabel;
}

-(UITextView *)contentLabel{
    if (!_contentLabel) {
        CGSize constraint = CGSizeMake(screen_width-30*SCREEN_RADIO, 99999.0f);
        CGSize size = [self.myIndexModel.shuoshuoContent sizeWithFont:[UIFont systemFontOfSize:13.0f*SCREEN_RADIO] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
        
        _contentLabel=[[UITextView alloc] initWithFrame:CGRectMake(10*SCREEN_RADIO, CGRectGetMaxY(self.timeDateLabel.frame), screen_width-30*SCREEN_RADIO, size.height+15*SCREEN_RADIO)];
        _contentLabel.text=self.myIndexModel.shuoshuoContent;
        _contentLabel.textColor=[UIColor getColor:@"000000"];
        _contentLabel.font=[UIFont systemFontOfSize:13*SCREEN_RADIO];
        [_contentLabel setEditable:NO];
        _contentLabel.userInteractionEnabled=NO;
       // [_contentLabel sizeToFit];
    }
    
    
    return _contentLabel;
}

-(UIButton *)likeImgView{
    if (!_likeImgView) {
        UIImage *img=[UIImage imageNamed:@"Likecell"];
        if (self.myIndexModel.isLike) {
            img=[UIImage imageNamed:@"LikeTo"];
        }
        _likeImgView=[[UIButton alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, total_height+ 10*SCREEN_RADIO, 17*SCREEN_RADIO, 15.2*SCREEN_RADIO)];
        [_likeImgView setImage:img forState:UIControlStateNormal];
        [_likeImgView addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _likeImgView;
}

-(UILabel *)likeLabel{
    if (!_likeLabel) {
        _likeLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.likeImgView.frame)+8.5*SCREEN_RADIO, total_height+ 10*SCREEN_RADIO, 0, 18*SCREEN_RADIO)];
        _likeLabel.text=[NSString stringWithFormat:@"%@ likes",self.myIndexModel.likes];
        _likeLabel.textColor=[UIColor getColor:@"274E6E"];
        _likeLabel.font=[UIFont boldSystemFontOfSize:14*SCREEN_RADIO];
        [_likeLabel sizeToFit];
    }
    
    return _likeLabel;
}


-(UIButton *)allCommit{
    if (!_allCommit) {
        _allCommit=[[UIButton alloc] initWithFrame:CGRectMake(30*SCREEN_RADIO, CGRectGetMaxY(self.likeImgView.frame)+10*SCREEN_RADIO, screen_width-30*SCREEN_RADIO, 14*SCREEN_RADIO)];
        [_allCommit addTarget:self action:@selector(allCommitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _allCommit;
}

-(UILabel *)allCommitLabel{
    if (!_allCommitLabel) {
        _allCommitLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.likeImgView.frame)+8.5*SCREEN_RADIO, CGRectGetMaxY(self.likeImgView.frame)+10*SCREEN_RADIO, screen_width-30*SCREEN_RADIO, 14*SCREEN_RADIO)];
        _allCommitLabel.text=[NSString stringWithFormat:@"%@ %@ %@",NSLocalizedString(@"zonggong", nil),self.myIndexModel.comments,NSLocalizedString(@"liuyan", nil)];
        _allCommitLabel.font=[UIFont boldSystemFontOfSize:14*SCREEN_RADIO];
        _allCommitLabel.textColor=[UIColor getColor:@"B1B1B1"];
    }
    
    return _allCommitLabel;
}


-(UIButton *)commitView{
    if (!_commitView) {
        _commitView=[[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.allCommit.frame), screen_width-10*SCREEN_RADIO, 80*SCREEN_RADIO)];
        _commitView.backgroundColor=[UIColor clearColor];
        [_commitView addTarget:self action:@selector(allCommitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _commitView;
}

-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.commitView.frame), screen_width, 0.5)];
        _bottomLine.backgroundColor=[UIColor getColor:@"CED7DB"];
    }
    
    return _bottomLine;
}

-(UIImageView *)VideoimageView{
    if (!_VideoimageView) {
        _VideoimageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentLabel.frame), screen_width, 284*SCREEN_RADIO)];
        [_VideoimageView sd_setImageWithURL:[NSURL URLWithString:self.myIndexModel.videoPicUrl]];
    }
    
    return _VideoimageView;
}

-(UIImageView *)playView{
    if (!_playView) {
        _playView=[[UIImageView alloc] initWithFrame:CGRectMake(screen_width/2, 200, 50, 50)];
        _playView.image=[UIImage imageNamed:@"PLAYVideo"];
    }
    
    return _playView;
}

@end
