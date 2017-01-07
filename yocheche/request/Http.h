//
//  SOAP.h
//  EStar
//
//  Created by KingRain on 14-1-5.
//  Copyright (c) 2014年 KingRain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


static NSString * const SERVER_IN_Special = @"http://192.168.31.238:8888/yo_client/client/dispatch.html?";//in net special
static NSString * const SERVER_IN = @"http://192.168.31.239:8888/yo_client/client/dispatch.html?";//内网
static NSString * const SERVER_TEST = @"http://www.yocheche.com:8888/client/dispatch.html?";//外网
static NSString * const SERVER_Official = @"http://client.yocheche.com:8080/client/dispatch.html?";//正式
static NSString * const SERVER_Jiecao = @"http://192.168.31.193/yo_client/client/dispatch.html?";//正式
//social api
//http://121.42.31.38:8888/yo_social/user/getUptoken.yo
static NSString * const SOCIAL_IN_Special = @"http://192.168.31.157:8181/yo_social/";//in net special
static NSString * const SOCIAL_IN = @"http://121.42.31.38:8787/";//内网
static NSString * const SOCIAL_OLD = @"http://121.42.31.38:8888/";//内网
static NSString * const SOCIAL_TEST = @"http://www.yocheche.com:8787/";//外网
static NSString * const SOCIAL_Official = @"http://client.yocheche.com:8888/";//正式
static NSString * const SOCIAL_Jiecao = @"http://192.168.31.193/social/";//正式
@interface Http : NSObject<NSURLConnectionDelegate>
@property (strong, nonatomic)NSMutableString *postMessage;
@property(strong,nonatomic)NSURLConnection *m_conn;
@property(strong,nonatomic)NSBlockOperation *m_block;

@property(strong,nonatomic)NSMutableArray *m_arySendParams;
@property(strong,nonatomic)NSMutableArray *m_arySendKeys;
@property(nonatomic,retain)NSDictionary *m_data;
@property(nonatomic,retain)NSMutableData *m_appendData;
@property(nonatomic,retain)NSString *socialMethord;
-(void)setParams:(NSArray*)params forKeys:(NSArray*)keys;
-(void)startWithBlock:(void (^)(void))block;
@end


