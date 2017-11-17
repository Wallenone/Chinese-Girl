//
//  CGSingleCommitData.h
//  ChineseGirl
//
//  Created by Wallen on 2017/10/22.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGSingleCommitData : NSObject
@property(nonatomic,copy)NSString *uid;                 //用户id
@property(nonatomic,copy)NSString *password;            //用户密码
@property(nonatomic,copy)NSString *email;               //email
@property(nonatomic,copy)NSString *nickName;            //昵称
@property(nonatomic,copy)UIImage *avatar;              //头像
@property(nonatomic,copy)NSString *sex;                 //性别
@property(nonatomic,copy)NSString *cityName;            //所在城市
@property(nonatomic,copy)NSString *birthDay;            //生日
@property(nonatomic,copy)NSString *aboutUs;             //关于我
@property(nonatomic,strong)NSMutableArray *albumS;      //相册
@property(nonatomic,copy)NSString *vipLevel;            //vip等级
@property(nonatomic,strong)NSMutableArray *favourites;   //收藏
@property(nonatomic,copy)NSString *languageName;  //语言
@property(nonatomic,copy)NSString *countryName;  //国家

+ (instancetype)sharedInstance;
- (void)logout;
-(void)addAlbumS:(UIImage *)img;   //增加一个相册
-(void)addfavourites:(NSString *)addLike;   //增加点赞
-(void)replaceAlbumS:(UIImage *)img withTag:(NSInteger)_tag;  //替换图片
-(void)deleteAlbumwithTag:(NSInteger)_tag;   //删除图片
-(void)deletefavourite:(NSString *)obj;   //删除点赞
@end
