//
//  CGUserInfo.m
//  ChineseGirl_Example
//
//  Created by Wallen on 2017/11/12.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import "CGUserInfo.h"
#import "CGMessageModel.h"

#define userInfo [CGSingleCommitData sharedInstance].isDebug?@"userInfo1":@"userInfo"
@interface CGUserInfo()
@end
@implementation CGUserInfo
+ (instancetype)modelWithDic:(NSDictionary *)dic{
    CGUserInfo *model = [[CGUserInfo alloc]init];
    model.ids = [CGCommonString filterNullString:[dic stringForKey:@"id"]];
    model.nickname = [CGCommonString filterNullString:[dic stringForKey:@"nickname"]];
    model.sex = [CGCommonString filterNullString:[dic stringForKey:@"sex"]];
    model.birthday = [CGCommonString filterNullString:[dic stringForKey:@"birthday"]];
    model.aboutus = [CGCommonString filterNullString:[dic stringForKey:@"aboutus"]];
    model.avater = [NSString stringWithFormat:@"%@%@%@%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/",[CGSingleCommitData sharedInstance].resultName,model.ids,@"/Enclosure/",[CGCommonString filterNullString:[dic stringForKey:@"avater"]]];
    model.address = [NSString stringWithFormat:@"China.%@",[CGCommonString filterNullString:[dic stringForKey:@"city"]]] ;
    model.bigAvater = [self getBigAvater:model.avater withIds:model.ids];
    model.pictures = [self getPictures:[CGCommonString filterNullString:[dic stringForKey:@"pictures"]] withIds:model.ids];
    model.picturesBig = [self getBigPictures:[CGCommonString filterNullString:[dic stringForKey:@"pictures"]] withIds:model.ids];
    model.messageids = [self getMessageIds:[CGCommonString filterNullString:[dic stringForKey:@"messageid"]]];
    model.type = [CGCommonString filterNullString:[dic stringForKey:@"type"]];
    if ([model.type integerValue]==2){
        model.videoUrlS=[self getVideoUrlsId:model.ids];
    }
    
    model.english=[CGCommonString filterNullString:[dic stringForKey:@"english"]];
    model.korea=[CGCommonString filterNullString:[dic stringForKey:@"korea"]];
    model.japan=[CGCommonString filterNullString:[dic stringForKey:@"japan"]];
    model.tw=[CGCommonString filterNullString:[dic stringForKey:@"tw"]];
    model.content=[self getUserInfoContent:model];
    
    return model;
}

+(NSString *)getUserInfoContent:(CGUserInfo *)dic{
    NSString *language = [NSLocale preferredLanguages].firstObject;
    NSString *content=@"";
    if ([language hasPrefix:@"en"]) {
        content = dic.english;
    } else if ([language hasPrefix:@"zh"]) {
        if ([language rangeOfString:@"Hans"].location != NSNotFound) {
            content = dic.aboutus; // 简体中文
        } else { // zh-Hant\zh-HK\zh-TW
            content = dic.tw; // 繁體中文
        }
    }else if ([language hasPrefix:@"fr"]){
        content = dic.english;
    }else if ([language hasPrefix:@"ko"]){
        content = dic.korea;
    }else if ([language hasPrefix:@"ru"]){
        content = dic.english;
    }else if ([language hasPrefix:@"ja"]){
        content = dic.japan;
    }else if ([language hasPrefix:@"es"]){
        content = dic.english;
    }else {
        content = dic.english;
    }
    
    return content;
}

+(NSArray *)reloadTableRondomCount:(NSInteger)count{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:userInfo ofType:@"plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    NSMutableArray *newData=[NSMutableArray new];
    
    NSArray *newarr1= [CGCommonToolsNode genertateRandomNumberStartNum:0 endNum:(int)(data1.count)-1 count:(int)data1.count];
    for (NSString *ids in newarr1) {
        CGUserInfo *userInfoModel=[self modelWithDic:[data1 objectAtIndex:[ids integerValue]]];
        [newData addObject:userInfoModel.ids];
    }
    
    return newData;
}

+(void)getTableRondomNewsUser{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:userInfo ofType:@"plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    int _userid=[CGCommonToolsNode getRandomNumber:0 to:(int)data1.count-1];
    
    if([[CGSingleCommitData sharedInstance].userListDataArr containsObject:[NSString stringWithFormat:@"%d",_userid]]){
       // [self getTableRondomNewsUser];//todo 这个地方后期需要改善
    }else{
        [[CGSingleCommitData sharedInstance] addUserListDataArr:[NSString stringWithFormat:@"%d",_userid]];
        [[CGSingleCommitData sharedInstance] addNewlists:@{@"userid":@(_userid),@"item":@[@{@"type":@"0",@"message":@""}]}];
    }
}


+(void)updateReloadTable{
    [CGSingleCommitData sharedInstance].userListDataArr = [[self reloadTableRondomCount:999999] mutableCopy];
}

+(NSMutableArray *)reloadTableWithRangeFrom:(NSInteger)fromNum rangeTLenth:(NSInteger)lenth{
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:userInfo ofType:@"plist"];
//    NSMutableArray *data1 = [[[[NSMutableArray alloc] initWithContentsOfFile:filePath] subarrayWithRange:NSMakeRange(fromNum, lenth)] mutableCopy];
//
    NSMutableArray *newData=[NSMutableArray new];
    
    NSInteger currentNum=fromNum+lenth;
    if ([CGSingleCommitData sharedInstance].userListDataArr.count>currentNum) {
        NSMutableArray *data2 = [[[CGSingleCommitData sharedInstance].userListDataArr subarrayWithRange:NSMakeRange(fromNum, lenth)] mutableCopy];
        for (CGUserInfo *model in data2) {
            [newData addObject:model];
        }
    }else{
        NSInteger t_num=[CGSingleCommitData sharedInstance].userListDataArr.count-fromNum;
        if (t_num>0) {
            NSMutableArray *data2 = [[[CGSingleCommitData sharedInstance].userListDataArr subarrayWithRange:NSMakeRange(fromNum, [CGSingleCommitData sharedInstance].userListDataArr.count-fromNum)] mutableCopy];
            for (CGUserInfo *model in data2) {  
                [newData addObject:model];
            }
        }
        
    }
    
    return newData;
}

+(CGUserInfo *)getitemWithID:(NSString *)ids{
  
    NSString *filePath = [[NSBundle mainBundle] pathForResource:userInfo ofType:@"plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    NSDictionary *dict= [data1 objectAtIndex:[ids intValue]-1];
    
    CGUserInfo *model1= [self modelWithDic:dict];
    if ([model1.ids isEqualToString:ids]) {
        BOOL _isLike=NO;
        for (NSString *content in [CGSingleCommitData sharedInstance].follows) {
            if (content.length>0) {
                if ([content isEqualToString:model1.ids]) {
                    _isLike = YES;
                }
            }
        }
        model1.followed=_isLike;
    }
    
    return model1;
}

+(NSString *)getBigAvater:(NSString *)icon withIds:(NSString *)ids{
    NSArray *array = [icon componentsSeparatedByString:@"/"];
    NSString *iconTstr=[array objectAtIndex:array.count-1];
    NSArray *array1 = [iconTstr componentsSeparatedByString:@"."];
    NSString *bstr=[[array1 objectAtIndex:0] stringByReplacingOccurrencesOfString:@"S" withString:@"B"];
    NSString *newIcon= [NSString stringWithFormat:@"%@%@%@%@%@%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/",[CGSingleCommitData sharedInstance].resultName,ids,@"/Enclosure/",bstr,@".",[array1 objectAtIndex:1]];
    
    return newIcon;
}

+(NSMutableArray *)getPictures:(NSString *)icon withIds:(NSString *)ids{
    NSArray *array = [icon componentsSeparatedByString:@"/"];
    NSMutableArray *newArr=[NSMutableArray new];
    for (NSString *img in array) {
        NSString *newIcon= [NSString stringWithFormat:@"%@%@%@%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/",[CGSingleCommitData sharedInstance].resultName,ids,@"/Enclosure/",img];
        [newArr addObject:newIcon];
    }
    
    return newArr;
}

+(NSMutableArray *)getBigPictures:(NSString *)icon withIds:(NSString *)ids{
    NSArray *array = [icon componentsSeparatedByString:@"/"];
    NSMutableArray *newArr=[NSMutableArray new];
    for (NSString *img in array) {
        NSArray *array1 = [img componentsSeparatedByString:@"."];
        NSString *bstr=[[array1 objectAtIndex:0] stringByReplacingOccurrencesOfString:@"S" withString:@"B"];
        NSString *newIcon= [NSString stringWithFormat:@"%@%@%@%@%@%@%@",@"https://raw.githubusercontent.com/Wallenone/service/master/",[CGSingleCommitData sharedInstance].resultName,ids,@"/Enclosure/",bstr,@".",[array1 objectAtIndex:1]];
        [newArr addObject:newIcon];
    }
    
    return newArr;
}

+(NSMutableArray *)getMessageIds:(NSString *)messageids{
    NSArray *array = [messageids componentsSeparatedByString:@"/"];
    NSMutableArray *newArr=[NSMutableArray new];
    for (NSString *messageid in array) {
        CGMessageModel *model=[CGMessageModel reloadReloadRondomIds:messageid];
        [newArr addObject:model];
    }
    
    return newArr;
}

+(NSMutableArray *)getVideoUrlsId:(NSString *)ids{
    NSMutableArray *newArr=[NSMutableArray new];
    for (int i=1; i<=3; i++) {
        NSString *videoUrl= [NSString stringWithFormat:@"%@%@%@%@%@%d%@",@"https://raw.githubusercontent.com/Wallenone/service/master/",[CGSingleCommitData sharedInstance].resultName,ids,@"/Enclosure/",@"V",i,@".mp4"];
        [newArr addObject:videoUrl];
    }
    
    return newArr;
}

@end
