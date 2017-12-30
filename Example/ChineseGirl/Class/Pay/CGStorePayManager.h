//
//  CGStorePayManager.h
//  CGPay
//
//  Created by wallen on 2017/12/28.
//  Copyright © 2017年 wallen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGStorePayManager : NSObject
+ (instancetype)sharedManager;
-(void)addTransactionObserver;    // 添加观察者
-(void)removeTransactionObserver;   // 移除观察者
-(void)replyToBuy;    //恢复购买(主要是针对非消耗产品)
-(void)purchasePay;  //开始购买
@end
