//
//  AppDelegate.h
//  yocheche
//
//  Created by carcool on 6/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import <BaiduMapAPI/BMapKit.h>
#import "HomeVC.h"
#import "SocialHomeVC.h"
#import "myTabbarVC.h"
#import "EaseMob.h"
#import "EMCDDeviceManager+Media.h"
#import "EMCDDeviceManager+ProximitySensor.h"
@class ConversationListController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,WeiboSDKDelegate,BMKLocationServiceDelegate,IChatManagerDelegate,EMCDDeviceManagerDelegate>
{
    BMKMapManager* _mapManager;
    BMKLocationService *_locService;
}
@property(nonatomic,assign)CLLocationCoordinate2D m_currentLocation;
@property(nonatomic,assign)NSInteger updateLocationType;//0:launch 1:new friend
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,assign)NSInteger handleURLtype; //0:share sdk 1:weixin sdk 2:alipay
@property(nonatomic,assign)NSInteger _isFull;//show full screen to play vedio
@property(retain,nonatomic)myTabbarVC *tabBarController;
@property(nonatomic,retain)HomeVC *m_homeVC;
@property(nonatomic,retain)SocialHomeVC *m_socialHomeVC;
@property(nonatomic,retain)ConversationListController *m_conversationListVC;
@property(nonatomic,assign)BOOL isEnterprise;
@property(nonatomic,assign)BOOL initialDone;
-(void)setTabBarUnreadMessageCount:(NSInteger)count;
-(void)updateMessageData;
-(void)updateLocation;
@end

