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
static NSString *const kCountryNameKey = @"countryNameKey";
static NSString *const kBirthDayKey = @"birthDayKey";
static NSString *const kAboutUsKey = @"aboutUsKey";
static NSString *const kAlbumSKey = @"albumSKey";
static NSString *const kVipLevelKey = @"vipLevelKey";
static NSString *const kLanguageNameKey = @"languageNameKey";
static NSString *const kFavouriteSKey = @"favouriteSKey";
static NSString *const kFollowSKey = @"followSKey";
static NSString *const kNewsListArrKey = @"newsListArrKey";
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
        }else{
            self.uid=@"";
        }
        
        NSString *nickName = [[NSUserDefaults standardUserDefaults] stringForKey:kNickNameKey];
        if (![CGCommonString isBlankString:nickName]) {
            self.nickName = nickName;
        }else{
            self.nickName = @"";
        }
        
        NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:kPasswordKey];
        if (![CGCommonString isBlankString:password]) {
            self.password = password;
        }else{
            self.password = @"";
        }
        
        
        NSString *email = [[NSUserDefaults standardUserDefaults] stringForKey:kEmailKey];
        if (![CGCommonString isBlankString:email]) {
            self.email = email;
        }else{
            self.email=@"";
        }
        
        NSData *avatarData = [[NSUserDefaults standardUserDefaults] objectForKey:kAvatarKey];
        
        if (avatarData.bytes>0) {
            self.avatar = [UIImage imageWithData:avatarData];
        }else{
            self.avatar = [UIImage imageNamed:@"default_hd_avatar"];
        }
        
        NSString *sex = [[NSUserDefaults standardUserDefaults] stringForKey:kSexKey];
        if (![CGCommonString isBlankString:sex]) {
            self.sex = sex;
        }else{
            self.sex=NSLocalizedString(@"sex_man", nil);
        }
        
        NSString *cityName = [[NSUserDefaults standardUserDefaults] stringForKey:kCityNameKey];
        if (![CGCommonString isBlankString:cityName]) {
            self.cityName = cityName;
        }else{
            self.cityName = @"";
        }
        
        NSString *countryName=[[NSUserDefaults standardUserDefaults] stringForKey:kCountryNameKey];
        if (![CGCommonString isBlankString:countryName]) {
            self.countryName = countryName;
        }else{
            self.countryName = @"";
        }
        
        NSString *birthDay = [[NSUserDefaults standardUserDefaults] stringForKey:kBirthDayKey];
        if (![CGCommonString isBlankString:birthDay]) {
            self.birthDay = birthDay;
        }else{
            self.birthDay=@"1990-01-01";
        }
        
        NSString *aboutUs = [[NSUserDefaults standardUserDefaults] stringForKey:kAboutUsKey];
        if (![CGCommonString isBlankString:aboutUs]) {
            self.aboutUs = aboutUs;
        }else{
            self.aboutUs = @"";
        }
        
        NSArray *albumS = [[NSUserDefaults standardUserDefaults] arrayForKey:kAlbumSKey];
        if (albumS.count>0) {
            self.albumS = [albumS mutableCopy];
        }else{
            self.albumS=[[NSMutableArray alloc] init];
        }
        
        NSString *kLevel=[[NSUserDefaults standardUserDefaults] stringForKey:kVipLevelKey];
        if (![CGCommonString isBlankString:kLevel]) {
            self.vipLevel=kLevel;
        }else{
            self.vipLevel=@"";
        }
        
        NSString *kLanguageName=[[NSUserDefaults standardUserDefaults] stringForKey:kLanguageNameKey];
        if (![CGCommonString isBlankString:kLanguageName]) {
            self.languageName=kLanguageName;
        }else{
            self.languageName=@"English";
        }
        
        NSArray *favourites = [[NSUserDefaults standardUserDefaults] arrayForKey:kFavouriteSKey];
        if (favourites.count>0) {
            self.favourites = [favourites mutableCopy];
        }else{
            self.favourites=[[NSMutableArray alloc] init];
        }
        
        NSArray *follows = [[NSUserDefaults standardUserDefaults] arrayForKey:kFollowSKey];
        if (follows.count>0) {
            self.follows = [follows mutableCopy];
        }else{
            self.follows=[[NSMutableArray alloc] init];
        }
        
        NSArray *newsLists = [[NSUserDefaults standardUserDefaults] arrayForKey:kNewsListArrKey];
        if (newsLists.count>0) {
            self.newsListArr = [newsLists mutableCopy];
        }else{
            self.newsListArr=[[NSMutableArray alloc] init];
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

-(void)setAvatar:(UIImage *)avatar{
    if (avatar) {
        _avatar=avatar;
        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(_avatar) forKey:kAvatarKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
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

-(void)setCountryName:(NSString *)countryName{
    if ([CGCommonString isBlankString:countryName]) {
        _countryName=@"";
    }
    _countryName=countryName;
    [[NSUserDefaults standardUserDefaults] setValue:_countryName forKey:kCountryNameKey];
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
    _albumS=albumS;
    NSArray *arr=[NSArray arrayWithArray:albumS];
    
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:kAlbumSKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setFavourites:(NSMutableArray *)favourites{
    _favourites=favourites;
    NSArray *arr=[NSArray arrayWithArray:favourites];
    
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:kFavouriteSKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setFollows:(NSMutableArray *)follows{
    _follows=follows;
    NSArray *arr=[NSArray arrayWithArray:_follows];
    
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:kFollowSKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setNewsListArr:(NSMutableArray *)newsListArr{
    _newsListArr=newsListArr;
    NSArray *arr=[NSArray arrayWithArray:_newsListArr];
    
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:kNewsListArrKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setVipLevel:(NSString *)vipLevel{    
    if ([CGCommonString isBlankString:vipLevel]) {
        _vipLevel=@"";
    }
    _vipLevel=vipLevel;
    [[NSUserDefaults standardUserDefaults] setValue:_vipLevel forKey:kVipLevelKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

-(void)setLanguageName:(NSString *)languageName{
    if ([CGCommonString isBlankString:languageName]) {
        _languageName=@"English";
    }
    _languageName=languageName;
    [[NSUserDefaults standardUserDefaults] setValue:_languageName forKey:kLanguageNameKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)addAlbumS:(UIImage *)img{
    if (img) {
        [self.albumS addObject:UIImagePNGRepresentation(img)];
        NSArray *arr=[NSArray arrayWithArray:self.albumS];
        self.albumS=[arr mutableCopy];
    }
}

-(void)addfavourites:(NSString *)addLike{
    if (addLike.length>0) {
        [self deletefavourite:addLike];
        [self.favourites insertObject:addLike atIndex:0];
        NSArray *arr=[NSArray arrayWithArray:self.favourites];
        self.favourites=[arr mutableCopy];
    }
}

-(void)addFollows:(NSString *)addFollow{
    if (addFollow.length>0) {
        [self deletefollow:addFollow];
        [self.follows insertObject:addFollow atIndex:0];
        NSArray *arr=[NSArray arrayWithArray:self.follows];
        self.follows=[arr mutableCopy];
    }
}

-(NSArray *)getNewsSubListArrWithUserid:(NSString *)userid{
    NSArray *item=[NSArray new];
    for (id model in [CGSingleCommitData sharedInstance].newsListArr) {
        if ([userid isEqualToString:[model stringForKey:@"userid"]]) {
            item=[[model dictionaryForKey:@"content"] arrayForKey:@"item"];
        }
    }
    
    return item;
}

-(void)addNewlists:(NSDictionary *)addNewList{
    NSDictionary *newdict;
    if ([CGSingleCommitData sharedInstance].newsListArr.count<=0) {
        [self.newsListArr insertObject:addNewList atIndex:0];
        self.newsListArr=[[NSArray arrayWithArray:self.newsListArr] mutableCopy];
        
        return ;
    }else{
        for (id model in [CGSingleCommitData sharedInstance].newsListArr) {
            if ([[addNewList stringForKey:@"userid"] integerValue] ==[[model stringForKey:@"userid"] integerValue]) {
                NSDictionary *item=[[addNewList dictionaryForKey:@"content"] arrayForKey:@"item"][0];
                
                NSDictionary *dict=@{@"message":[item stringForKey:@"message"] ,
                                     @"newsid":[item stringForKey:@"newsid"],
                                     @"type":[item stringForKey:@"type"],
                                     @"turnFront":@"FrontLeft",
                                     @"userid":[item stringForKey:@"userid"]};
                NSMutableArray *arr= [[[model dictionaryForKey:@"content"] arrayForKey:@"item"] mutableCopy];
                [arr addObject:dict];
                newdict=@{@"content":@{@"item":arr},@"userid":[addNewList stringForKey:@"userid"]};
                [self.newsListArr removeObject:model];
                [self.newsListArr insertObject:newdict atIndex:0];
                self.newsListArr=[[NSArray arrayWithArray:self.newsListArr] mutableCopy];
                return ;
            }else{
                [self.newsListArr insertObject:addNewList atIndex:0];
                self.newsListArr=[[NSArray arrayWithArray:self.newsListArr] mutableCopy];
                return ;
            }
        }
    }
}

-(void)addNewlistSubData:(NSDictionary *)addNewList{
    NSDictionary *newdict;
    for (id model in [CGSingleCommitData sharedInstance].newsListArr) {
        if ([[addNewList stringForKey:@"userid"] isEqualToString:[model stringForKey:@"userid"]]) {
            NSDictionary *dict=@{@"message":[addNewList stringForKey:@"message"] ,@"newsid":[addNewList stringForKey:@"newsid"],@"type":[addNewList stringForKey:@"type"],@"turnFront":[addNewList stringForKey:@"turnFront"],@"userid":[addNewList stringForKey:@"userid"]};
            NSMutableArray *arr= [[[model dictionaryForKey:@"content"] arrayForKey:@"item"] mutableCopy];
            [arr addObject:dict];
            newdict=@{@"content":@{@"item":arr},@"userid":[addNewList stringForKey:@"userid"]};
            [self.newsListArr removeObject:model];
            [self.newsListArr insertObject:newdict atIndex:0];
            self.newsListArr=[[NSArray arrayWithArray:self.newsListArr] mutableCopy];
            return ;
        }
    }
}

-(void)replaceAlbumS:(UIImage *)img withTag:(NSInteger)_tag{
    if (img) {
        [self.albumS replaceObjectAtIndex:_tag withObject:UIImagePNGRepresentation(img)];
        NSArray *arr=[NSArray arrayWithArray:self.albumS];
        self.albumS=[arr mutableCopy];
    }
}

-(void)deleteAlbumwithTag:(NSInteger)_tag{
    if (_tag>=0 && _tag<self.albumS.count) {
        [self.albumS removeObjectAtIndex:_tag];
        NSArray *arr=[NSArray arrayWithArray:self.albumS];
        self.albumS=[arr mutableCopy];
    }
}

-(void)deletefavourite:(NSString *)obj{
    if (obj.length>0) {
        [self.favourites removeObject:obj];
        NSArray *arr=[NSArray arrayWithArray:self.favourites];
        self.favourites=[arr mutableCopy];
    }
}

-(void)deletefollow:(NSString *)obj{
    if (obj.length>0) {
        [self.follows removeObject:obj];
        NSArray *arr=[NSArray arrayWithArray:self.follows];
        self.follows=[arr mutableCopy];
    }
}

-(void)deleteNewList:(NSInteger)index{
    [self.newsListArr removeObjectAtIndex:index];
    NSArray *arr=[NSArray arrayWithArray:self.newsListArr];
    self.newsListArr=[arr mutableCopy];
}

-(void)deleteNewListModel:(id)model{
    [self.newsListArr removeObject:model];
    NSArray *arr=[NSArray arrayWithArray:self.newsListArr];
    self.newsListArr=[arr mutableCopy];
}

- (void)logout {
    self.uid = @"";
}

-(void)deleteAccout{
    self.uid = @"";
}
@end
