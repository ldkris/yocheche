//
//  LogInfo.h
//  weixueche
//
//  Created by carcool on 12/13/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogInfo : NSObject
@property(nonatomic,retain)NSString *pro1Index;
@property(nonatomic,retain)NSMutableArray *pro1SavedArray;//saved page number
@property(nonatomic,retain)NSMutableArray *pro1ErrorArray;//error page numbew
@property(nonatomic,retain)NSMutableDictionary *settingDictionary;
@property(nonatomic,retain)NSMutableArray *scoreWithTimeArray;
+(LogInfo*)initLogInfoWithObject:(NSMutableDictionary *)d;
+(NSMutableDictionary*)returnToDictionary:(LogInfo*)log;
@end
