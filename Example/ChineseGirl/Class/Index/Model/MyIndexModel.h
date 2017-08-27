//
//  MyIndexModel.h
//  ChineseGirl
//
//  Created by Wallen on 2017/8/24.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyIndexModel : NSObject
@property(nonatomic,copy)NSString *icon;   //头像
@property(nonatomic,copy)NSString *nickName;  //昵称
@property(nonatomic,copy)NSString *timeDate;  //发布时间
@property(nonatomic,copy)NSString *content;  //说说内容
@property(nonatomic,strong)NSArray *pictures;  //图片
@property(nonatomic,copy)NSString *likes;  //喜欢人数
@property(nonatomic,copy)NSString *comments;  //回复人数
@end
