//
//  CGGetCityPlist.m
//  testcity
//
//  Created by wallen on 2017/11/13.
//  Copyright © 2017年 wallen. All rights reserved.
//

#import "CGGetCityPlist.h"

@implementation CGGetCityPlist

+(NSMutableArray *)readPlist{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CNCity" ofType:@"plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    
    return data1;
}

+(NSMutableArray *)getCountryList{
    NSMutableArray *CN_Country=[NSMutableArray new];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"txt"];
    NSString *dataFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *dataarr = [dataFile componentsSeparatedByString:@"\n"];
    
    int fromNum=0;
    for (NSString *string in dataarr) {
        if([string rangeOfString:@"en"].location !=NSNotFound)//_roaldSearchText
        {
            NSArray *array = [string componentsSeparatedByString:@"|"];
            NSString *country=[array objectAtIndex:1];
            
            if ([country rangeOfString:@"_"].location ==NSNotFound) {
                //NSMutableDictionary *dict=[NSMutableDictionary new];
                NSMutableDictionary *newPiceDict=[NSMutableDictionary new];
                newPiceDict= [self getPiceArr:dataarr withfromNum:fromNum withJDStr:[array objectAtIndex:1] withCountryName:[array objectAtIndex:2]];
//                [dict setObject:newPiceDict forKey:[array objectAtIndex:2]];
                [CN_Country addObject:newPiceDict];
            }
            
        }
        fromNum++;
    }
    
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"ENCity.plist"];
    [CN_Country writeToFile:plistPath atomically:YES];
    NSLog(@"CN_Country:=%@",CN_Country);
    
    return CN_Country;
}

+(NSMutableDictionary *)getPiceArr:(NSArray *)arr withfromNum:(int)num withJDStr:(NSString *)JDStr withCountryName:(NSString *)countryName{
    NSMutableDictionary *newDict=[NSMutableDictionary new];
    
    NSMutableArray *p_arr=[NSMutableArray new];
    
    for (int i=num; i<arr.count; i++) {
        NSString *string=[arr objectAtIndex:i];
        
        if([string rangeOfString:@"en"].location !=NSNotFound)//_roaldSearchText
        {
            NSArray *array = [string componentsSeparatedByString:@"|"];
            NSString *country=[array objectAtIndex:1];
            if ([country rangeOfString:@"_"].location !=NSNotFound) {
                NSArray *array1 = [[array objectAtIndex:1] componentsSeparatedByString:@"_"];
                if ([JDStr isEqualToString:[array1 objectAtIndex:0]]) {
                    [p_arr addObject:[array objectAtIndex:2]];
                }
            }
        }
    }
    
    [newDict setObject:countryName forKey:@"contryName"];
    [newDict setObject:p_arr forKey:@"cityList"];
    return newDict;
}

@end
