//
//  MessageWebVC.m
//  weixueche
//
//  Created by carcool on 1/31/15.
//  Copyright (c) 2015 carcool. All rights reserved.
//

#import "MessageWebVC.h"
#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface MessageWebVC ()

@end

@implementation MessageWebVC
@synthesize dic,webView,m_aryURL;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(myPopSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    self.m_aryURL=[NSMutableArray array];
    self.backFlag=0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [[ NSNotificationCenter defaultCenter ] addObserver : self selector : @selector (videoStarted:) name : @"UIMoviePlayerControllerDidEnterFullscreenNotification" object : nil ]; // 播放器即将播放通知
    
    [[ NSNotificationCenter defaultCenter ] addObserver : self selector : @selector (videoFinished:) name : @"UIMoviePlayerControllerDidExitFullscreenNotification" object : nil ]; // 播放器即将退出通知
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIMoviePlayerControllerDidEnterFullscreenNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIMoviePlayerControllerDidExitFullscreenNotification" object:nil];
}
#pragma mark 调用视频的通知方法

- ( void )videoStarted:( NSNotification *)notification { // 开始播放
    
    AppDelegate * appDelegate =(AppDelegate*) [[ UIApplication sharedApplication ] delegate ];
    
    appDelegate._isFull = 1 ;
    
}

- ( void )videoFinished:( NSNotification *)notification { // 完成播放
    
    AppDelegate *appDelegate = (AppDelegate*)[[ UIApplication sharedApplication ] delegate ];
    
    appDelegate._isFull = 0 ;
    
    if ([[ UIDevice currentDevice ] respondsToSelector : @selector (setOrientation:)]) {
        
        SEL selector = NSSelectorFromString ( @"setOrientation:" );
        
        NSInvocation *invocation = [ NSInvocation invocationWithMethodSignature :[ UIDevice instanceMethodSignatureForSelector :selector]];
        
        [invocation setSelector :selector];
        
        [invocation setTarget :[ UIDevice currentDevice ]];
        
        int val = UIInterfaceOrientationPortrait ;
        
        [invocation setArgument :&val atIndex : 2 ];
        
        [invocation invoke ];
        
    }
    
    //    NSLog(@"videoFinished %@", self.view.window.rootViewController.view);
    
    //
    
    //    NSLog(@"a == %f", self.view.window.rootViewController.view.transform.a);
    
    //    NSLog(@"b == %f", self.view.window.rootViewController.view.transform.b);
    
    //    NSLog(@"c == %f", self.view.window.rootViewController.view.transform.c);
    
    //    NSLog(@"d == %f", self.view.window.rootViewController.view.transform.d);
    
    //    if (self.view.window.rootViewController.view.transform.c == 1 || self.view.window.rootViewController.view.transform.c == -1 ) {
    
    //        CGAffineTransform transform;
    
    //        // 设置旋转度数
    
    //        //    transform = CGAffineTransformRotate(self.view.window.rootViewController.view.transform, M_PI / 2);
    
    //        transform = CGAffineTransformIdentity;
    
    //        [UIView beginAnimations:@"rotate" context:nil ];
    
    //        [UIView setAnimationDuration:0.1];
    
    //        [UIView setAnimationDelegate:self];
    
    //        [self.view.window.rootViewController.view setTransform:transform];
    
    //        [UIView commitAnimations];
    
    //
    
    //        self.view.window.rootViewController.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height );
    
    //    }
    
    //
    
    //    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:NO];
    
}
-(void)myPopSelfViewContriller
{
    if ([self.m_aryURL count]<=1)
    {
        [self popSelfViewContriller];
    }
    else
    {
        NSURL *url =[NSURL URLWithString:[self.m_aryURL objectAtIndex:self.m_aryURL.count-2]];
        [self.m_aryURL removeLastObject];
        self.backFlag=1;
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
    }
}
-(void)updateView
{
    self.title=[self.dic objectForKey:@"title"];
    self.webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.view addSubview:self.webView];
    webView.scrollView.bounces=NO;
    webView.scalesPageToFit =YES;
    webView.delegate =self;
    NSURL *url =[NSURL URLWithString:[self.dic objectForKey:@"url"]];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
-(BOOL)webView:(UIWebView *)web shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"request %@",request);
    if (self.backFlag==1)
    {
        self.backFlag=0;
        if([self.m_aryURL count]<=1)
        {
            [self setRightNaviBtnImage:nil];
            [self.rightNaviBtn removeTarget:self action:@selector(shareBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    else
    {
        if ([[request.URL absoluteString] rangeOfString:@"carcool_web"].location != NSNotFound)
        {
            [self.m_aryURL addObject:[request.URL absoluteString]];
            [self startLoadingGray];
            if([self.m_aryURL count]>1)
            {
                [self setRightNaviBtnImage:[UIImage imageNamed:@"share"]];
                [self.rightNaviBtn addTarget:self action:@selector(shareBtnPressed) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    return YES;
}
- (void) webViewDidStartLoad:(UIWebView *)web
{
}
- (void) webViewDidFinishLoad:(UIWebView *)web
{
    [self stopLoading];
}
- (void) webView:(UIWebView *)web didFailLoadWithError:(NSError *)error
{
    [self stopLoading];
}
-(void)shareBtnPressed
{
    [self shareWithContent:@"学车窍门 学车八卦" andUrl:[self.m_aryURL lastObject]];
}
#pragma mark --------- share
-(void)shareWithContent:(NSString*)content andUrl:(NSString*)urlstr
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    appdelegate.handleURLtype=0;//set appdelegate handle type
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"icon_aboutus@2x" ofType:@"png"];
    NSLog(@"content :%@",content);
    //构造分享内容
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:content
                                     images:@[[UIImage imageNamed:@"icon_aboutus"]]
                                        url:[NSURL URLWithString:urlstr]
                                      title:content
                                       type:SSDKContentTypeAuto];
    //2、分享（可以弹出我们的分享菜单和编辑界面）
    [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       default:
                           break;
                   }
               }
     ];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
