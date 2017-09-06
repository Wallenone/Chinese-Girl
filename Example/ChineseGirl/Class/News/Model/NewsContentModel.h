//
//  NewsContentModel.h
//  ChineseGirl
//
//  Created by wallen on 2017/9/6.
//  Copyright © 2017年 wanjiehuizhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    NewsContentTypeRight = 1,
    NewsContentTypeLeft
}NewsContentType;

@interface NewsContentModel : NSObject
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,assign)NewsContentType type;
@property(nonatomic,copy)NSString *timeDate;
@end
