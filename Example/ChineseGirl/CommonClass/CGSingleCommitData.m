//
//  CGSingleCommitData.m
//  ChineseGirl
//
//  Created by Wallen on 2017/10/22.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGSingleCommitData.h"
static CGSingleCommitData *_instance = nil;
@implementation CGSingleCommitData
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


-(NSString *)uid{
    return _uid ?: @"";
}

-(NSString *)nickName{
    return _nickName ?: @"";
}

-(NSString *)avatar{
    return _avatar ?: @"";
}

-(NSString *)sex{
    return _sex ?: @"";
}

-(NSString *)cityName{
    return _cityName ?: @"";
}

-(NSString *)birthDay{
    return _birthDay ?: @"";
}

-(NSString *)aboutUs{
    return _aboutUs ?: @"";
}

-(NSMutableArray *)albumS{
    return _albumS;
}

- (void)logout {
    self.uid = @"";
}
@end
