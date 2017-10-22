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
@interface MyIndexCell(){
    CGFloat total_height;
    CommitClick commitClick;
}
@property(nonatomic,strong)MyIndexModel *myIndexModel;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *nickNameLabel;
@property(nonatomic,strong)UILabel *timeDateLabel;
@property(nonatomic,strong)UITextView *contentLabel;
@property(nonatomic,strong)UIImageView *picImgView;
@property(nonatomic,strong)UIButton *giftImgView;
@property(nonatomic,strong)UILabel *giftLabel;
@property(nonatomic,strong)UIButton *likeImgView;
@property(nonatomic,strong)UILabel *likeLabel;
@property(nonatomic,strong)NSMutableArray *imgViewArr;
@property(nonatomic,strong)UIButton *commitView;
@property(nonatomic,strong)UIImageView *avaterCommit;
@property(nonatomic,strong)UIButton *allCommit;
@property(nonatomic,strong)UILabel *allCommitLabel;
@property(nonatomic,strong)UIView *bottomLine;
@end
@implementation MyIndexCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(MyIndexModel *)indexModel withCommitClick:(CommitClick)block{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        total_height=0;
        commitClick=block;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor clearColor];
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


- (void)creatSubView {
    [self addSubview:self.iconImageView];
    [self addSubview:self.nickNameLabel];
   // [self addSubview:self.timeDateLabel];
    [self addSubview:self.contentLabel];
    total_height=CGRectGetMaxY(self.contentLabel.frame);
    [self setImgBrower];
    [self addSubview:self.iconImageView];
    [self addSubview:self.giftImgView];
    [self addSubview:self.giftLabel];
    [self addSubview:self.likeImgView];
    [self addSubview:self.likeLabel];
    [self addSubview:self.allCommitLabel];
    [self addSubview:self.allCommit];
    [self addSubview:self.commitView];
    [self addSubview:self.bottomLine];
    [self setCommitUI];
}

-(void)setImgBrower{
    // 1.创建9个UIImageView
    UIImage *placeholder = [UIImage imageNamed:@"timeline_image_loading.png"];
    CGFloat width = (screen_width-42*SCREEN_RADIO)/3;
    CGFloat height = (screen_width-42*SCREEN_RADIO)/3;
    CGFloat margin = 6*SCREEN_RADIO;
    CGFloat startX = 15 *SCREEN_RADIO;
    CGFloat startY =CGRectGetMaxY(self.contentLabel.frame);
    if (self.myIndexModel.content.length<=0) {
        startY =CGRectGetMaxY(self.contentLabel.frame)-15*SCREEN_RADIO;
    }
    for (int i = 0; i<self.myIndexModel.pictures.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        
        // 计算位置
        int row = i/3;
        int column = i%3;
        CGFloat x = startX + column * (width + margin);
        CGFloat y = startY + row * (height + margin);
        imageView.frame = CGRectMake(x, y, width, height);
        
        // 下载图片
        [imageView setImageURLStr:self.myIndexModel.pictures[i] placeholder:placeholder];
        
        // 事件监听
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.imgViewArr addObject:imageView];
        total_height=CGRectGetMaxY(imageView.frame);
    }

}


- (void)tapImage:(UITapGestureRecognizer *)tap
{
    NSUInteger count = self.myIndexModel.pictures.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = [self.myIndexModel.pictures[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
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

-(void)likeClick{
    
}

-(void)setCommitUI{
    for (int i=0; i<3; i++) {
        UILabel *nickName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.likeImgView.frame)+8.5*SCREEN_RADIO, 5*SCREEN_RADIO+(14+10)*i, 0, 14*SCREEN_RADIO)];
        nickName.text=@"wallen";
        nickName.textColor=[UIColor getColor:@"274E6E"];
        nickName.font=[UIFont boldSystemFontOfSize:14*SCREEN_RADIO];
        [nickName sizeToFit];
        [self.commitView addSubview:nickName];
        
        UILabel *commitLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nickName.frame)+10*SCREEN_RADIO, 5*SCREEN_RADIO+(14+10)*i, screen_width-52*SCREEN_RADIO, 17*SCREEN_RADIO)];
        commitLabel.text=@"XXXXXXXXXXXXXX";
        commitLabel.textColor=[UIColor getColor:@"99A3A9"];
        commitLabel.font=[UIFont boldSystemFontOfSize:14*SCREEN_RADIO];
        [self.commitView addSubview:commitLabel];
    }
}

-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView=[[UIImageView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, 15*SCREEN_RADIO, 38*SCREEN_RADIO, 38*SCREEN_RADIO)];
        _iconImageView.image=[UIImage imageNamed:self.myIndexModel.icon];
        _iconImageView.layer.cornerRadius = 19*SCREEN_RADIO;
    }
    
    return _iconImageView;
}

-(UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+15*SCREEN_RADIO, 23*SCREEN_RADIO, 200*SCREEN_RADIO, 27*SCREEN_RADIO)];
        _nickNameLabel.text=self.myIndexModel.nickName;
        _nickNameLabel.textColor=[UIColor getColor:@"232627"];
        _nickNameLabel.font=[UIFont systemFontOfSize:16*SCREEN_RADIO];
    }
    
    return _nickNameLabel;
}

-(UILabel *)timeDateLabel{
    if (!_timeDateLabel) {
        _timeDateLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+15*SCREEN_RADIO, CGRectGetMaxY(self.nickNameLabel.frame)+2*SCREEN_RADIO, 200*SCREEN_RADIO, 18*SCREEN_RADIO)];
        _timeDateLabel.text=self.myIndexModel.timeDate;
        _timeDateLabel.textColor=[UIColor getColor:@"7C858A"];
        _timeDateLabel.font=[UIFont systemFontOfSize:11*SCREEN_RADIO];
    }
    
    return _timeDateLabel;
}

-(UITextView *)contentLabel{
    if (!_contentLabel) {
        CGSize constraint = CGSizeMake(screen_width-30*SCREEN_RADIO, 99999.0f);
        CGSize size = [self.myIndexModel.content sizeWithFont:[UIFont systemFontOfSize:17.0f*SCREEN_RADIO] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
        
        _contentLabel=[[UITextView alloc] initWithFrame:CGRectMake(15*SCREEN_RADIO, CGRectGetMaxY(self.timeDateLabel.frame), screen_width-30*SCREEN_RADIO, size.height+15*SCREEN_RADIO)];
        _contentLabel.text=self.myIndexModel.content;
        _contentLabel.textColor=[UIColor getColor:@"575E62"];
        _contentLabel.font=[UIFont systemFontOfSize:17*SCREEN_RADIO];
        [_contentLabel setEditable:NO];
        _contentLabel.userInteractionEnabled=NO;
       // [_contentLabel sizeToFit];
    }
    
    
    return _contentLabel;
}

-(UIButton *)giftImgView{
    if (!_giftImgView) {
        _giftImgView=[[UIButton alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, total_height+ 10*SCREEN_RADIO, 17*SCREEN_RADIO, 17*SCREEN_RADIO)];
        [_giftImgView setImage:[UIImage imageNamed:@"Commentcell"] forState:UIControlStateNormal];
        [_giftImgView addTarget:self action:@selector(giftClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _giftImgView;
}


-(UILabel *)giftLabel{
    if (!_giftLabel) {
        _giftLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.giftImgView.frame)+8.5*SCREEN_RADIO, total_height+10*SCREEN_RADIO, 0, 18*SCREEN_RADIO)];
        _giftLabel.text=@"100 gifts";
        _giftLabel.textColor=[UIColor getColor:@"274E6E"];
        _giftLabel.font=[UIFont boldSystemFontOfSize:14*SCREEN_RADIO];
        [_giftLabel sizeToFit];
    }
    
    return _giftLabel;
}

-(UIButton *)likeImgView{
    if (!_likeImgView) {
        _likeImgView=[[UIButton alloc] initWithFrame:CGRectMake(16*SCREEN_RADIO, CGRectGetMaxY(self.giftImgView.frame)+10*SCREEN_RADIO, 17*SCREEN_RADIO, 15.2*SCREEN_RADIO)];
        [_likeImgView setImage:[UIImage imageNamed:@"Likecell"] forState:UIControlStateNormal];
        [_likeImgView addTarget:self action:@selector(likeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _likeImgView;
}

-(UILabel *)likeLabel{
    if (!_likeLabel) {
        _likeLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.likeImgView.frame)+8.5*SCREEN_RADIO, CGRectGetMaxY(self.giftImgView.frame)+10*SCREEN_RADIO, 0, 18*SCREEN_RADIO)];
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
        _allCommitLabel.text=[NSString stringWithFormat:@"view all %@ commits",self.myIndexModel.comments];
        _allCommitLabel.font=[UIFont boldSystemFontOfSize:14*SCREEN_RADIO];
        _allCommitLabel.textColor=[UIColor getColor:@"B1B1B1"];
    }
    
    return _allCommitLabel;
}


-(UIButton *)commitView{
    if (!_commitView) {
        _commitView=[[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.allCommit.frame), screen_width, 80*SCREEN_RADIO)];
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

@end
