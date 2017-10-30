//
//  CGSingleCommitData.m
//  ChineseGirl
//
//  Created by Wallen on 2017/10/22.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

static NSString *const kUidKey = @"uidKey";
static NSString *const kPasswordKey = @"passwordKey";
static NSString *const kEmailKey = @"emailKey";
static NSString *const kNickNameKey = @"nickNameKey";
static NSString *const kAvatarKey = @"avatarKey";
static NSString *const kSexKey = @"sexKey";
static NSString *const kCityNameKey = @"cityNameKey";
static NSString *const kBirthDayKey = @"birthDayKey";
static NSString *const kAboutUsKey = @"aboutUsKey";
static NSString *const kAlbumSKey = @"albumSKey";
static NSString *const kVipLevelKey = @"vipLevelKey";
static NSString *const kFavouritesKey = @"favouritesKey";
#import "CGSingleCommitData.h"
static CGSingleCommitData *_instance = nil;
@implementation CGSingleCommitData
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[CGSingleCommitData alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *userid = [[NSUserDefaults standardUserDefaults] stringForKey:kUidKey];
        if (![CGCommonString isBlankString:userid]) {
            self.uid = userid;
        }
        
        NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:kPasswordKey];
        if (![CGCommonString isBlankString:password]) {
            self.password = password;
        }
        
        
        NSString *email = [[NSUserDefaults standardUserDefaults] stringForKey:kEmailKey];
        if (![CGCommonString isBlankString:email]) {
            self.email = email;
        }
        
        NSString *avatar = [[NSUserDefaults standardUserDefaults] stringForKey:kAvatarKey];
        if (![CGCommonString isBlankString:avatar]) {
            self.avatar = avatar;
        }
        
        NSString *sex = [[NSUserDefaults standardUserDefaults] stringForKey:kSexKey];
        if (![CGCommonString isBlankString:sex]) {
            self.sex = sex;
        }
        
        NSString *cityName = [[NSUserDefaults standardUserDefaults] stringForKey:kCityNameKey];
        if (![CGCommonString isBlankString:cityName]) {
            self.cityName = cityName;
        }
        
        NSString *birthDay = [[NSUserDefaults standardUserDefaults] stringForKey:kBirthDayKey];
        if (![CGCommonString isBlankString:birthDay]) {
            self.birthDay = birthDay;
        }
        
        NSString *aboutUs = [[NSUserDefaults standardUserDefaults] stringForKey:kAboutUsKey];
        if (![CGCommonString isBlankString:aboutUs]) {
            self.aboutUs = aboutUs;
        }
        
        NSArray *albumS = [[NSUserDefaults standardUserDefaults] arrayForKey:kAlbumSKey];
        if (albumS.count>0) {
            self.albumS = [albumS mutableCopy];
        }
        
        NSString *kLevel=[[NSUserDefaults standardUserDefaults] stringForKey:kVipLevelKey];
        if (![CGCommonString isBlankString:kLevel]) {
            self.vipLevel=kLevel;
        }
        
        NSArray *favourites = [[NSUserDefaults standardUserDefaults] arrayForKey:kFavouritesKey];
        if (favourites.count>0) {
            self.albumS = [favourites mutableCopy];
        }
        
    }
    return self;
}

-(void)setUid:(NSString *)uid{
    if ([CGCommonString isBlankString:uid]) {
        _uid=@"";
    }
    _uid=uid;
    [[NSUserDefaults standardUserDefaults] setValue:_uid forKey:kUidKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setPassword:(NSString *)password{
    if ([CGCommonString isBlankString:password]) {
        _password=@"";
    }
    _password=password;
    [[NSUserDefaults standardUserDefaults] setValue:_password forKey:kPasswordKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setEmail:(NSString *)email{
    if ([CGCommonString isBlankString:email]) {
        _email=@"";
    }
    _email=email;
    [[NSUserDefaults standardUserDefaults] setValue:_email forKey:kEmailKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setNickName:(NSString *)nickName{
    if ([CGCommonString isBlankString:nickName]) {
        _nickName=@"";
    }
    _nickName=nickName;
    [[NSUserDefaults standardUserDefaults] setValue:_nickName forKey:kNickNameKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setAvatar:(NSString *)avatar{
    if ([CGCommonString isBlankString:avatar]) {
        _avatar=@"";
    }
    _avatar=avatar;
    [[NSUserDefaults standardUserDefaults] setValue:_avatar forKey:kAvatarKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setSex:(NSString *)sex{
    if ([CGCommonString isBlankString:sex]) {
        _sex=@"";
    }
    _sex=sex;
    [[NSUserDefaults standardUserDefaults] setValue:_sex forKey:kSexKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setCityName:(NSString *)cityName{
    if ([CGCommonString isBlankString:cityName]) {
        _cityName=@"";
    }
    _cityName=cityName;
    [[NSUserDefaults standardUserDefaults] setValue:_cityName forKey:kCityNameKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setBirthDay:(NSString *)birthDay{
    if ([CGCommonString isBlankString:birthDay]) {
        _birthDay=@"";
    }
    _birthDay=birthDay;
    [[NSUserDefaults standardUserDefaults] setValue:_birthDay forKey:kBirthDayKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setAboutUs:(NSString *)aboutUs{
    if ([CGCommonString isBlankString:aboutUs]) {
        _aboutUs=@"";
    }
    _aboutUs=aboutUs;
    [[NSUserDefaults standardUserDefaults] setValue:_aboutUs forKey:kAboutUsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setAlbumS:(NSMutableArray *)albumS{
    if (albumS.count>0) {
        _albumS=[albumS mutableCopy];
        [[NSUserDefaults standardUserDefaults] setObject:_albumS forKey:kAlbumSKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

-(void)setVipLevel:(NSString *)vipLevel{
    if ([CGCommonString isBlankString:vipLevel]) {
        _vipLevel=@"";
    }
    _vipLevel=vipLevel;
    [[NSUserDefaults standardUserDefaults] setValue:_vipLevel forKey:kVipLevelKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)addFavourite:(NSMutableDictionary *)favouriteModel{
    if ([favouriteModel isKindOfClass:[NSDictionary class]]) {
        if (self.albumS.count>=10) {
            [self.albumS removeObjectAtIndex:0];
            [self.albumS addObject:favouriteModel];
        }
        
        if (self.albumS.count>0) {
            [[NSUserDefaults standardUserDefaults] setObject:self.albumS forKey:kAlbumSKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

- (void)logout {
    self.uid = @"";
}
@end
