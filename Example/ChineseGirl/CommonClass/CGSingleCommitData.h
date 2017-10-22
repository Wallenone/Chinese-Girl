//
//  CGSingleCommitData.h
//  ChineseGirl
//
//  Created by Wallen on 2017/10/22.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGSingleCommitData : NSObject
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *avatar;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *cityName;
@property(nonatomic,copy)NSString *birthDay;
@property(nonatomic,copy)NSString *aboutUs;
@property(nonatomic,strong)NSMutableArray *albumS;
+ (instancetype)sharedInstance;
- (void)logout;
@end
