//
//  SOAP.m
//  EStar
//
//  Created by KingRain on 14-1-5.
//  Copyright (c) 2014年 KingRain. All rights reserved.
//

#import "Http.h"
//#import "GDataXMLNode.h"
#import "AppDelegate.h"
#import "Base64codeFunc.h"
@implementation Http
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
    
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:self.m_arySendParams forKeys:self.m_arySendKeys];
    //sort keys
    NSArray * sortedKeys =
    [self.m_arySendKeys sortedArrayUsingComparator:^(id string1, id string2)
     {
         return [((NSString *)string1) compare:((NSString *)string2)
                                       options:NSNumericSearch];
     }];
    
    NSMutableArray *ary=[NSMutableArray array];
    NSInteger i=0;
    while (i<sortedKeys.count)
    {
        NSString *str1=[sortedKeys objectAtIndex:i];
        NSString *str=[NSString stringWithFormat:@"%@%@",str1,[dic objectForKey:str1]];
        [ary addObject:str];
        i++;
    }

    NSMutableArray *newary=[NSMutableArray arrayWithArray:ary];
    [newary insertObject:@"yo" atIndex:0];
    [newary addObject:@"yo"];
    
    //array to string
    NSMutableString *sign=[NSMutableString stringWithString:@""];
    for (NSString *item in newary)
    {
        [sign appendString:item];
    }
    NSString *signEncode= [sign stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //md5
    NSString *signResult=[MyFounctions md5:signEncode];
    [self.m_arySendKeys addObject:@"sign"];
    [self.m_arySendParams addObject:signResult];
    
}


-(void)startWithBlock:(void (^)(void))block
{
    NSString *currentServerUrl=@"";
    NSLog(@"self.socialMethord :%@",self.socialMethord);
    if ([self.socialMethord isEqualToString:@""])
    {
        currentServerUrl=SERVER_Official;
    }
    else
    {
        currentServerUrl=[NSString stringWithFormat:@"%@%@?",SOCIAL_Official,self.socialMethord];
    }
    NSLog(@"currentServerUrl :%@",currentServerUrl);
    NSURL *url=[NSURL URLWithString:currentServerUrl];
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
//    NSString *msgLength = [NSString stringWithFormat:@"%ul", [postMessage length]];
//    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: [postMessage dataUsingEncoding:NSUTF8StringEncoding]];
    self.m_conn=[NSURLConnection connectionWithRequest:request delegate:self];

    NSLog(@"request :%@",postMessage);
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
//    NSInteger strLength=[myData length];
//    NSString *compareStr=@"";
//    NSInteger i=16;
//    while (i>0)
//    {
//        compareStr=[compareStr stringByAppendingString:[NSString stringWithFormat:@"%c",[myData characterAtIndex:strLength-i]]];
//        i--;
//    }
//    if (![compareStr isEqualToString:@"</soap:Envelope>"])
//    {
//        [self.m_appendData appendData:data];
//        return;
//    }
//    else
//    {
//        [self.m_appendData appendData:data];
//    }
    
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

