//
//  NormalHttp.m
//  yocheche
//
//  Created by carcool on 9/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "NormalHttp.h"
#import "AppDelegate.h"
#import "Base64codeFunc.h"
@implementation NormalHttp
@synthesize postMessage,m_conn,m_block,m_arySendKeys,m_arySendParams,m_data,m_appendData;
- (id)init
{
    self = [super init];
    if (self)
    {
        self.socialMethord=@"";
        self.m_arySendParams=[NSMutableArray arrayWithArray:@[@"1.0",[MyFounctions getTimeStamp],@"ios"]];
        self.m_arySendKeys=[NSMutableArray arrayWithArray:@[@"v",@"timestamp",@"app_key"]];
        
        self.m_appendData=[NSMutableData data];
    }
    return self;
}
-(void)setParams:(NSArray *)params forKeys:(NSArray *)keys
{
    [self.m_arySendKeys addObjectsFromArray:keys];
    [self.m_arySendParams addObjectsFromArray:params];
    
}


-(void)startWithBlock:(void (^)(void))block
{
    NSURL *url=[NSURL URLWithString:self.urlStr];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:60.0];
    self.postMessage=[NSMutableString stringWithString:@""];
    NSInteger i=0;
    while (m_arySendKeys.count>i)
    {
        if (i==0)
        {
            [self.postMessage appendFormat:@"%@=%@",[self.m_arySendKeys objectAtIndex:i],[self.m_arySendParams objectAtIndex:i]];
        }
        else
        {
            [self.postMessage appendFormat:@"&%@=%@",[self.m_arySendKeys objectAtIndex:i],[self.m_arySendParams objectAtIndex:i]];
        }
        i++;
    }
    [request setHTTPBody: [postMessage dataUsingEncoding:NSUTF8StringEncoding]];
    self.m_conn=[NSURLConnection connectionWithRequest:request delegate:self];
    
    [self.m_conn start];
    self.m_block=[NSBlockOperation blockOperationWithBlock:block];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response{
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //mutable append data.
    [self.m_appendData appendData:data];
    NSString *myData=[[NSString alloc] initWithData:self.m_appendData encoding:NSUTF8StringEncoding];
    NSLog(@"myData :%@",myData);
    if ([[myData substringFromIndex:[myData length]-1] isEqualToString:@"}"]&&[myData rangeOfString:@"statusCode"].location!=NSNotFound)
    {
        self.m_data=[NSJSONSerialization JSONObjectWithData:m_appendData options:NSJSONReadingMutableContainers error:nil];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"connection error :%@",error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    [self.m_block start];
}

@end
