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
@property(nonatomic,copy)NSString *avatar;              //头像
@property(nonatomic,copy)NSString *sex;                 //性别
@property(nonatomic,copy)NSString *cityName;            //所在城市
@property(nonatomic,copy)NSString *birthDay;            //生日
@property(nonatomic,copy)NSString *aboutUs;             //关于我
@property(nonatomic,strong)NSMutableArray *albumS;      //相册
@property(nonatomic,copy)NSString *vipLevel;            //vip等级
@property(nonatomic,strong)NSMutableArray *favourites;   //收藏
+ (instancetype)sharedInstance;
- (void)logout;
@end
