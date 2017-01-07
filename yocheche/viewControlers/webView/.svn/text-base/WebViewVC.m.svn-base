//
//  WebViewVC.m
//  chena
//
//  Created by carcool on 9/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "WebViewVC.h"

@interface WebViewVC ()

@end

@implementation WebViewVC
@synthesize webView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    self.webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.view addSubview:self.webView];
    //    webView.scrollView.bounces=NO;
    //    webView.scalesPageToFit =YES;
    webView.delegate =self;
    
    NSURL* url = [NSURL URLWithString:self.urlStr];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:self.title];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:self.title];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
