//
//  WSCollectionCell.m
//  瀑布流
//
//  Created by iMac on 16/12/26.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "WSCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "MyIndexViewController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "CGNewSignInViewController.h"
@interface WSCollectionCell(){
    CGFloat _imgHeight;
}
@property(nonatomic,strong)CGShuoShuo *model;
@property(nonatomic,strong)UIView *menuView;
@property(nonatomic,strong)UIImageView *iconImgView;
@property(nonatomic,strong)UIButton *iconBtn;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *location;
@property(nonatomic,strong)UILabel *content;
@property(nonatomic,strong)NSMutableArray *imgViewArr;
@end

@implementation WSCollectionCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(CGShuoShuo *)commitModel{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgHeight=284*SCREEN_RADIO;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor getColor:@"ffffff"];
        self.model=commitModel;
        [self creatSubView];
    }
    
    return self;
}



-(void)iconClick{
    if ([CGSingleCommitData sharedInstance].uid.length<=0) {
        CGNewSignInViewController *loginVC=[[CGNewSignInViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [[CGCommonToolsNode getCurrentVC].navigationController presentViewController:nav animated:YES completion:nil];
    }else{
        MyIndexViewController *indexVC=[[MyIndexViewController alloc] init];
        indexVC.ids=[self.model.uid integerValue];
        [[CGCommonToolsNode getCurrentVC]   .navigationController pushViewController:indexVC animated:NO];
    }
    
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
        [_iconImgView sd_setImageWithURL:[NSURL URLWithString:self.model.icon] placeholderImage:[UIImage imageNamed:@"default_nor_avatar"]];
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

- (void)creatSubView {
    [self addSubview:self.menuView];
    [self.menuView addSubview:self.iconImgView];
    [self.menuView addSubview:self.iconBtn];
    [self.menuView addSubview:self.nickName];
    [self.menuView addSubview:self.location];
    [self.menuView addSubview:self.content];
    [self setImgBrower];
}

-(void)setImgBrower{
    CGFloat width = (screen_width-42*SCREEN_RADIO)/3;
    CGFloat height = (screen_width-42*SCREEN_RADIO)/3;
    CGFloat margin = 6*SCREEN_RADIO;
    CGFloat startX = 15 *SCREEN_RADIO;
    CGFloat startY =CGRectGetMaxY(self.menuView.frame);
    
    
    if (self.model.pictureBigs.count==1) {
        [self setpictureFrame:CGRectMake(10*SCREEN_RADIO, CGRectGetMaxY(self.menuView.frame), screen_width-20*SCREEN_RADIO, 284*SCREEN_RADIO) withTag:0 withUrl:self.model.pictureBigs[0]];
    }else if(self.model.pictureBigs.count==2){
        for (int i=0; i<self.model.pictureBigs.count; i++) {
            // 计算位置
            [self setpictureFrame:CGRectMake(10*SCREEN_RADIO+i*(screen_width-25*SCREEN_RADIO)/2+i*5, CGRectGetMaxY(self.menuView.frame), (screen_width-25*SCREEN_RADIO)/2, 284*SCREEN_RADIO) withTag:i withUrl:self.model.pictureBigs[i]];
        }
        
    }else if (self.model.pictureBigs.count==4){
        for (int i=0; i<self.model.pictureBigs.count; i++) {
            // 计算位置
            CGFloat _startX=10*SCREEN_RADIO+i*(screen_width-25*SCREEN_RADIO)/2+i*5*SCREEN_RADIO;
            CGFloat _startY=CGRectGetMaxY(self.menuView.frame)+(284/2)*SCREEN_RADIO;
            if (i==2) {
                _startX=10*SCREEN_RADIO;
                _startY = CGRectGetMaxY(self.menuView.frame)+(284/2)*SCREEN_RADIO;
            }else if(i==3){
                _startX = 10*SCREEN_RADIO+1*(screen_width-25*SCREEN_RADIO)/2+1*5*SCREEN_RADIO;
                _startY = CGRectGetMaxY(self.menuView.frame)+(284/2)*SCREEN_RADIO;
            }else{
                _startY=CGRectGetMaxY(self.menuView.frame);
            }
            
            
            [self setpictureFrame:CGRectMake(_startX, _startY, (screen_width-25*SCREEN_RADIO)/2, (284/2-6)*SCREEN_RADIO) withTag:i withUrl:self.model.pictureBigs[i]];
        }
    }
    else{
        for (int i = 0; i<self.model.pictureBigs.count; i++) {
            // 计算位置
            int row = i/3;
            int column = i%3;
            CGFloat x = startX + column * (width + margin);
            CGFloat y = startY + row * (height + margin);
            [self setpictureFrame:CGRectMake(x, y, width, height) withTag:i withUrl:self.model.pictureBigs[i]];
        }
    }
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
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    NSUInteger count = self.model.pictureBigs.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = self.model.pictureBigs[i];
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

-(NSMutableArray *)imgViewArr{
    if (!_imgViewArr) {
        _imgViewArr=[NSMutableArray new];
    }
    
    return _imgViewArr;
}

@end
