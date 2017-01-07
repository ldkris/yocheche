//
//  WebViewVC.h
//  chena
//
//  Created by carcool on 9/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface WebViewVC : YCCViewController<UIWebViewDelegate>
@property(nonatomic,retain)UIWebView *webView;
@property(nonatomic,retain)NSString *urlStr;

@end
