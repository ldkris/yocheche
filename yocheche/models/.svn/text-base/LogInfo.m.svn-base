//
//  LogInfo.m
//  weixueche
//
//  Created by carcool on 12/13/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import "LogInfo.h"

@implementation LogInfo
-(id)init
{
    self=[super init];
    if (self)
    {
        self.pro1Index=@"1";
        self.pro1SavedArray=[NSMutableArray array];
        self.pro1ErrorArray=[NSMutableArray array];
        self.settingDictionary=[NSMutableDictionary dictionaryWithObjects:@[@"1",@"1"] forKeys:@[@"sound",@"autoScroll"]];
        self.scoreWithTimeArray=[NSMutableArray array];
    }
    return self;
}
+(LogInfo*)initLogInfoWithObject:(NSMutableDictionary *)d
{
    LogInfo *o=[[LogInfo alloc] init];
    o.pro1Index = [d objectForKey:@"pro1Index"];
    o.pro1SavedArray = [d objectForKey:@"pro1SavedArray"];
    o.pro1ErrorArray = [d objectForKey:@"pro1ErrorArray"];
    o.settingDictionary=[d objectForKey:@"settingDictionary"];
    o.scoreWithTimeArray=[d objectForKey:@"scoreWithTimeArray"];
    return o;
}
+(NSMutableDictionary*)returnToDictionary:(LogInfo*)log
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjects:@[log.pro1Index,log.pro1SavedArray,log.pro1ErrorArray,log.settingDictionary,log.scoreWithTimeArray] forKeys:@[@"pro1Index",@"pro1SavedArray",@"pro1ErrorArray",@"settingDictionary",@"scoreWithTimeArray"]];
    return dic;
}

@end
