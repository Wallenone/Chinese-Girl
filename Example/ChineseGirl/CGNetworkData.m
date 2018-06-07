//
//  CGNetworkData.m
//  ChineseGirl_Example
//
//  Created by wallen on 2018/5/25.
//  Copyright © 2018年 wanjiehuizhaofang. All rights reserved.
//

#import "CGNetworkData.h"
#import "AFHTTPSessionManager.h"
@implementation CGNetworkData

+(void)postData:(NSDictionary *)dict withUrl:(NSString *)url{
    
        //NSString *urlData=[NSString stringWithFormat:@"%@",]
        // 请求管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
       
        // 拼接请求参数
       NSMutableDictionary *params = [NSMutableDictionary dictionary];
      [params setDictionary:dict];
    
       [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"请求成功:%@", responseObject);
       
              NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       
              NSLog(@"请求成功JSON:%@", JSON);
       
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
            NSLog(@"请求失败:%@", error.description);
       
         }];
}
    
  
@end
