//
//  AppDelegate.m
//  yocheche
//
//  Created by carcool on 6/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeVC.h"
#import "MyCenterVC.h"
#import "ConversationListController.h"
//share sdk
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
#import "WeiboUser.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

#import <PhotoEditFramework/PhotoEditFramework.h>
#import <AlipaySDK/AlipaySDK.h>
#import "JPUSHService.h"
#import "MobClick.h"
#import "EaseUI.h"
//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";
@interface AppDelegate ()
@property (strong, nonatomic) NSDate *lastPlaySoundDate;
@property(nonatomic,assign)NSInteger badgeNum;
@end

@implementation AppDelegate
@synthesize _isFull,tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.initialDone=NO;
    self.badgeNum=0;
    self.isEnterprise=NO;
    self.updateLocationType=0;
    NSLog(@"CFBundleIdentifier :%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]);
    if ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] isEqualToString:@"com.yocheche.yocheche"])
    {
        self.isEnterprise=YES;
    }
    else
    {
        self.isEnterprise=NO;
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.m_homeVC=[[HomeVC alloc] init];
    self.m_socialHomeVC=[[SocialHomeVC alloc] init];
    self.m_conversationListVC=[[ConversationListController alloc] init];
    //tabbar
    self.tabBarController = [[myTabbarVC alloc] init];
    NSMutableArray *controllers = [NSMutableArray array];
    NSArray *item = [NSArray arrayWithObjects:@"around",@"find",@"release",@"message",nil];
    NSInteger count = [item count];
    for (int i = 0; i < count; i++)
    {
        switch (i)
        {
            case 0:
            {
                
                YCCNavigationController *nav=[[YCCNavigationController alloc] initWithRootViewController:self.m_homeVC];
                [controllers addObject:nav];
                
            }
                break;
            case 1:
            {
                YCCNavigationController *nav=[[YCCNavigationController alloc] initWithRootViewController:self.m_socialHomeVC];
                [controllers addObject:nav];
                
            }
                break;
            case 2:
            {
                YCCNavigationController *nav=[[YCCNavigationController alloc] initWithRootViewController:self.m_conversationListVC];
                [controllers addObject:nav];
                
            }
                break;
            case 3:
            {
                YCCNavigationController *nav=[[YCCNavigationController alloc] initWithRootViewController:[[MyCenterVC alloc] init]];
                [controllers addObject:nav];
                
            }
                break;
            default:
                break;
        }
    }
    tabBarController.viewControllers=controllers;
    self.window.rootViewController=tabBarController;
    [self.window makeKeyAndVisible];
    
    self.handleURLtype=11;// weixin login
    
    //umeng analytics
//    Class cls = NSClassFromString(@"UMANUtil");
//    SEL deviceIDSelector = @selector(openUDIDString);
//    NSString *deviceID = nil;
//    if(cls && [cls respondsToSelector:deviceIDSelector]){
//        deviceID = [cls performSelector:deviceIDSelector];
//    }
//    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:nil];
//    
//    NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick startWithAppkey:@"563c69e667e58e6d6a000fea" reportPolicy:BATCH   channelId:nil];
    
    
    //baidu map
    _mapManager = [[BMKMapManager alloc]init];
    NSString *baiduappke=@"";
    if (self.isEnterprise==NO)
    {
        baiduappke=@"tw4aLK1YpDamLbLjCUK9fURH";//appstore
    }
    else
    {
        baiduappke=@"8mVdEmzv1pybeufvFuH04rwG";
    }
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:baiduappke  generalDelegate:nil];//appstore
    if (!ret) {
        NSLog(@"BMKMapManager start failed!");
    }
    else
    {
        NSLog(@"BMKMapManager start seccuss.");
    }
    //camera 360
    if (self.isEnterprise==NO)//appstore
    {
        [pg_edit_sdk_controller sStart:@"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"];
    }
    else//enterprise
    {
        [pg_edit_sdk_controller sStart:@"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"];
    }
    //share sdk
//    [ShareSDK registerApp:@"9e3a4cb7508c"];//字符串api20为您的ShareSDK的AppKey
//    [ShareSDK ssoEnabled:YES];
//    //添加微信应用 注册网址 http://open.weixin.qq.com
//    [ShareSDK connectWeChatWithAppId:@"wx6f3bf9dad1ab773a"   //微信APPID
//                           appSecret:@"0639b7fce135c3d99a0b2da7eecd0c02"  //微信APPSecret
//                           wechatCls:[WXApi class]];
//    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
//    [ShareSDK  connectSinaWeiboWithAppKey:@"4071248429"
//                                appSecret:@"e9cbcfab2e5bb0ba7e33dd19e29395cd"
//                              redirectUri:@"http://www.yocheche.com"
//                              weiboSDKCls:[WeiboSDK class]];
//    //qq
//    [ShareSDK connectQQWithQZoneAppKey:@"1103837355"
//                     qqApiInterfaceCls:[QQApiInterface class]
//                       tencentOAuthCls:[TencentOAuth class]];
    
    
    [ShareSDK registerApp:@"9e3a4cb7508c"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"4071248429"
                                           appSecret:@"e9cbcfab2e5bb0ba7e33dd19e29395cd"
                                         redirectUri:@"http://www.yocheche.com"
                                            authType:SSDKAuthTypeWeb];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx6f3bf9dad1ab773a"
                                       appSecret:@"0639b7fce135c3d99a0b2da7eecd0c02"];
                 break;
             
             default:
                 break;
         }
     }];
    
    //JPush
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    //appstore :09f870b5f995812fe3c7ec90
    //enterprise :049da0ea8a08c1e3029b4759
    [JPUSHService setupWithOption:launchOptions appKey:@"09f870b5f995812fe3c7ec90" channel:@"1" apsForProduction:YES];
    
    //easeMob环信
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"yocheche#yocheche" apnsCertName:@"production_ycc"];//develop_ycc  production_ycc
    //注册登录状态监听
    [self registerRemoteNotification];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [self registerEaseMobNotification];
    [EMCDDeviceManager sharedInstance].delegate = self;


    //location get
    self.m_currentLocation=(CLLocationCoordinate2D){0.0,0.0};
    [self updateLocation];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.initialDone=YES;
    [self.m_homeVC viewWillAppear:YES];
    return YES;
}
-(void)updateLocation
{
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}
#pragma mark ------------- easemob push ----------------

// 注册推送
- (void)registerRemoteNotification
{
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
#if !TARGET_IPHONE_SIMULATOR
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
#endif
}
#pragma mark - registerEaseMobNotification
- (void)registerEaseMobNotification{
    [self unRegisterEaseMobNotification];
    // 将self 添加到SDK回调中，以便本类可以收到SDK回调
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

- (void)unRegisterEaseMobNotification{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}
#pragma mark --------------- push -----------------------
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [JPUSHService registerDeviceToken:deviceToken];
    
    //ease
     [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    NSLog(@"options :%@",options.nickname);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
    //ease
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
    NSLog(@"error push-- %@",error);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    self.badgeNum=0;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showCoachListNavi" object:nil userInfo:nil];
     [[EaseMob sharedInstance] applicationWillEnterForeground:application];
    [self updateMessageData];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    if (self.handleURLtype==0)
    {
        return YES;
    }
    else if(self.handleURLtype==1)//微信支付
    {
        [WXApi handleOpenURL:url delegate:self];
        return YES;
    }
    else if(self.handleURLtype==11)//微信登录
    {
        [WXApi handleOpenURL:url delegate:self];
        return YES;
    }
    else if(self.handleURLtype==12)//新浪微博登录
    {
        [WeiboSDK handleOpenURL:url delegate:self];
        return YES;
    }
    else
    {
        return YES;
    }
    
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if (self.handleURLtype==21)//alipay
    {
        //如果极简开发包不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给开 发包
        if ([url.host isEqualToString:@"safepay"]) {
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url
            standbyCallback:^(NSDictionary *resultDic)
            {
//                【由于在跳转支付宝客户端支付的过程中,商户 app 在后台很可能被系统 kill 了,所以 pay 接口的 callback 就会失效,请商户对 standbyCallback 返回的回调结果进行处理,就是在这个方￼法里面处理跟 callback 一样的逻辑】
                NSLog(@"result = %@",resultDic);
                if ([[resultDic objectForKey:@"resultStatus"] integerValue]==9000)
                {
                    //success
                }
                }];
        }
        if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic)
             {
                //【由于在跳转支付宝客户端支付的过程中,商户 app 在后台很可能被系统 kill 了, 所以 pay 接口的 callback 就会失效,请商户对standbyCallback 返回的回调结果进行处理,就 是在这个方法里面处理跟 callback 一样的逻辑】
                NSLog(@"result = %@",resultDic);
                 if ([[resultDic objectForKey:@"resultStatus"] integerValue]==9000)
                 {
                     //success
                 }
            }];
        }

    }
    else if (self.handleURLtype==1)//weipay
    {
        [WXApi handleOpenURL:url delegate:self];
        return YES;
    }
    else if(self.handleURLtype==11)//微信登录
    {
        [WXApi handleOpenURL:url delegate:self];
        return YES;
    }
    else if(self.handleURLtype==12)//新浪微博登录
    {
        [WeiboSDK handleOpenURL:url delegate:self];
        return YES;
    }
    else if(self.handleURLtype==0)
    {
        return YES;
    }
    else
    {
        return YES;
    }
    return YES;
}
-(void)onResp:(BaseResp *)resp
{
    if (self.handleURLtype==0)
    {
        return;
    }
    else if (self.handleURLtype==1)//weipay
    {
        if ([resp isKindOfClass:[PayResp class]]) {
            PayResp *response = (PayResp *)resp;
            NSLog(@"error :%@",response.errStr);
            NSLog(@"error :%@",response.returnKey);
            switch (response.errCode)
            {
                case WXSuccess:
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"paySuccess" object:nil userInfo:nil];
                }
                    break;
                case WXErrCodeAuthDeny:
                {
                    NSLog(@"WXErrCodeAuthDeny");
                }
                    break;
                case WXErrCodeCommon:
                {
                    NSLog(@"WXErrCodeCommon");
                }
                    break;
                case WXErrCodeSentFail:
                {
                    NSLog(@"WXErrCodeSentFail");
                }
                    break;
                case WXErrCodeUnsupport:
                {
                    NSLog(@"WXErrCodeUnsupport");
                }
                    break;
                case WXErrCodeUserCancel:
                {
                    NSLog(@"WXErrCodeUserCancel");
                }
                    break;
                default:
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"payFailed" object:nil userInfo:nil];
                    //                    if (_delegate && [_delegate
                    //                                      respondsToSelector:@selector(PayFail:)]) {
                    //                        [_delegate PayFail:response.errCode];
                    //                    }
                }
                    break;
            }
        }
    }
    else if (self.handleURLtype==11)//weixin login
    {
        if ([resp isKindOfClass:[SendAuthResp class]])
        {
            SendAuthResp *response = (SendAuthResp *)resp;
            if (response.errCode==0)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"weixinLogin" object:nil userInfo:[NSDictionary dictionaryWithObject:response.code forKey:@"code"]];
            }
        }
    }
    
}
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if (self.handleURLtype==12)//weibo login
    {
        NSString * userid = [(WBAuthorizeResponse *)response userID];
        NSString *wbtoken = [(WBAuthorizeResponse *)response accessToken];
        
//        NSString * oathString = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?uid=%@&access_token=%@",userid,wbtoken];//
        
        [WBHttpRequest requestForUserProfile:userid withAccessToken:wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
            DemoRequestHanlder(httpRequest, result, error);
            
        }];


    }
}
void DemoRequestHanlder(WBHttpRequest *httpRequest, id result, NSError *error)
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    if (error)
    {
        title = NSLocalizedString(@"请求异常", nil);
        alert = [[UIAlertView alloc] initWithTitle:title
                                           message:[NSString stringWithFormat:@"%@",error]
                                          delegate:nil
                                 cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                 otherButtonTitles:nil];
        [alert show];
    }
    else
    {
//        title = NSLocalizedString(@"收到网络回调", nil);
//        alert = [[UIAlertView alloc] initWithTitle:title
//                                           message:[NSString stringWithFormat:@"%@",result]
//                                          delegate:nil
//                                 cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                 otherButtonTitles:nil];
        WeiboUser *user=(WeiboUser*)result;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"weiboLogin" object:nil userInfo:[NSDictionary dictionaryWithObject:user forKey:@"userInfo"]];

    }
    
    
}

- ( NSUInteger )application:( UIApplication *)application supportedInterfaceOrientationsForWindow:( UIWindow *)window {
    
    if ( _isFull )
    {
        return UIInterfaceOrientationMaskAll ;
    }
    else
    {
        return UIInterfaceOrientationMaskPortrait;
    }
    
}
#pragma mark ---------- ease mob 环信 ------------------
-(void)didReceiveMessage:(EMMessage *)message
{
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    switch (state) {
        case UIApplicationStateActive:
        {
            [self getMessageStartSoundAndUpdateView];
        }
            break;
        case UIApplicationStateInactive:
        {
            [self getMessageStartSoundAndUpdateView];
        }
            break;
        case UIApplicationStateBackground:
            [self showNotificationWithMessage:message];
            break;
        default:
            break;
    }
    
    
}
-(void)updateMessageData
{
    [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:NO];
    [self.m_conversationListVC tableViewDidTriggerHeaderRefresh];
}
-(void)getMessageStartSoundAndUpdateView
{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
    
    if (self.m_conversationListVC.view.superview)
    {
        [self.m_conversationListVC tableViewDidTriggerHeaderRefresh];
    }
    else
    {
        [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:NO];
        [self.m_conversationListVC tableViewDidTriggerHeaderRefresh];
    }
}
- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    
    if (options.displayStyle == ePushNotificationDisplayStyle_messageSummary) {
        id<IEMMessageBody> messageBody = [message.messageBodies firstObject];
        NSString *messageStr = nil;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Text:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case eMessageBodyType_Image:
            {
                messageStr = NSLocalizedString(@"message.image", @"Image");
            }
                break;
            case eMessageBodyType_Location:
            {
                messageStr = NSLocalizedString(@"message.location", @"Location");
            }
                break;
            case eMessageBodyType_Voice:
            {
                messageStr = NSLocalizedString(@"message.voice", @"Voice");
            }
                break;
            case eMessageBodyType_Video:{
                messageStr = NSLocalizedString(@"message.video", @"Video");
            }
                break;
            default:
                break;
        }
        
        NSString *title = message.from;
        if (message.messageType == eMessageTypeGroupChat) {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:message.conversationChatter]) {
                    title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, group.groupSubject];
                    break;
                }
            }
        }
        else if (message.messageType == eMessageTypeChatRoom)
        {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            NSString *key = [NSString stringWithFormat:@"OnceJoinedChatrooms_%@", [[[EaseMob sharedInstance].chatManager loginInfo] objectForKey:@"username" ]];
            NSMutableDictionary *chatrooms = [NSMutableDictionary dictionaryWithDictionary:[ud objectForKey:key]];
            NSString *chatroomName = [chatrooms objectForKey:message.conversationChatter];
            if (chatroomName)
            {
                title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, chatroomName];
            }
        }
        
        notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
    }
    else{
        notification.alertBody = NSLocalizedString(@"receiveMessage", @"you have a new message");
    }
    
#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    
    notification.alertAction = NSLocalizedString(@"open", @"Open");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
    } else {
        notification.soundName = UILocalNotificationDefaultSoundName;
        self.lastPlaySoundDate = [NSDate date];
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:message.messageType] forKey:kMessageType];
    [userInfo setObject:message.conversationChatter forKey:kConversationChatter];
    notification.userInfo = userInfo;
    
    //发送通知
    self.badgeNum++;
    [UIApplication sharedApplication].applicationIconBadgeNumber = self.badgeNum;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    //    UIApplication *application = [UIApplication sharedApplication];
    //    application.applicationIconBadgeNumber += 1;
}

-(void)didReceiveOfflineMessages:(NSArray *)offlineMessages
{
    [self updateMessageData];
}
-(void)setTabBarUnreadMessageCount:(NSInteger)count
{
    if (count>0)
    {
        self.tabBarController.notifyView3.hidden=NO;
    }
    else
    {
        self.tabBarController.notifyView3.hidden=YES;
    }
}
#pragma mark ---------- BMKLocationServiceDelegate
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //发起反向地理编码检索
    if (userLocation.location.coordinate.latitude>0)
    {
        self.m_currentLocation= (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    }
    [_locService stopUserLocationService];
    _locService.delegate=nil;
    _locService=nil;
    //upload location
    [self.m_homeVC uploadLocation];
    if (self.updateLocationType==1)// new friend
    {
        self.updateLocationType=0;
        self.m_socialHomeVC.m_newFriendView.m_currentLocation= (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
        [self.m_socialHomeVC submitLBSToBaiduLat:[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude] Lng:[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude]];
        [self.m_socialHomeVC getNewFriendLat:[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude] Lng:[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude] Pageindex:[NSString stringWithFormat:@"%d",self.m_socialHomeVC.m_newFriendView.pageIndex] pageSize:[NSString stringWithFormat:@"%d",self.m_socialHomeVC.m_newFriendView.pageCount]];
    }
}
@end
