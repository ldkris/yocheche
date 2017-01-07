//
//  NormalHttp.h
//  yocheche
//
//  Created by carcool on 9/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NormalHttp : NSObject<NSURLConnectionDelegate>
@property (strong, nonatomic)NSMutableString *postMessage;
@property(strong,nonatomic)NSURLConnection *m_conn;
@property(strong,nonatomic)NSBlockOperation *m_block;

@property(strong,nonatomic)NSMutableArray *m_arySendParams;
@property(strong,nonatomic)NSMutableArray *m_arySendKeys;
@property(nonatomic,retain)NSDictionary *m_data;
@property(nonatomic,retain)NSMutableData *m_appendData;
@property(nonatomic,retain)NSString *socialMethord;
@property(nonatomic,retain)NSString *urlStr;
-(void)setParams:(NSArray*)params forKeys:(NSArray*)keys;
-(void)startWithBlock:(void (^)(void))block;

@end
