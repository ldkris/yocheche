//
//  SlideView.m
//  yocheche
//
//  Created by carcool on 7/28/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SlideView.h"
#import "CardView.h"
#import "SlidePostVC.h"
@implementation SlideView
-(void)awakeFromNib
{
    self.y_old=0;
    self.pageIndex=1;
    self.pageCount=10;
    self.showedIndex=0;
    self.currentIndex=0;
    self.type=@"1";
    [self setBackgroundColor:YCC_GrayBG];
    self.swipeableView.delegate = self;
    self.swipeableView.dataSource = self;
//    [self.btnSex addTarget:self action:@selector(selectSex) forControlEvents:UIControlEventTouchUpInside];
    [self.btnLike setImage:[UIImage imageNamed:@"good2"] forState:UIControlStateHighlighted];
    [self.btnUnlike setImage:[UIImage imageNamed:@"bad2"] forState:UIControlStateHighlighted];
    self.imgBoy.hidden=YES;
    self.imgGirl.hidden=YES;
    self.imgBoyAndGirl.hidden=NO;
    
    self.locationMgr = [[CLLocationManager alloc] init];
    if([self.locationMgr respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [self.locationMgr requestAlwaysAuthorization]; // 永久授权
        [self.locationMgr requestWhenInUseAuthorization]; //使用中授权
    }
    //设置代理
    self.locationMgr.delegate = self;
    // 设置定位精度
    // kCLLocationAccuracyNearestTenMeters:精度10米
    // kCLLocationAccuracyHundredMeters:精度100 米
    // kCLLocationAccuracyKilometer:精度1000 米
    // kCLLocationAccuracyThreeKilometers:精度3000米
    // kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
    // kCLLocationAccuracyBestForNavigation:导航情况下最高精度，一般要有外接电源时才能使用
    self.locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
    // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
    // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
    self.locationMgr.distanceFilter = 1000.0f;
    //开始定位
    //        [self.locationMgr startUpdatingLocation];
//    self.locationMgr=nil;
    
    self.m_currentLocation=(CLLocationCoordinate2D){0.0,0.0};
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    self.m_aryData=[NSMutableArray array];
}
-(void)getSomePictures
{
    [self.delegate updateSlideViewDataLat:[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude] Lng:[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude] PageIndex:[NSString stringWithFormat:@"%d",self.pageIndex] PageSize:[NSString stringWithFormat:@"%d",self.pageCount] Type:self.type];
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
    self.m_currentLocation= (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    [_locService stopUserLocationService];
    _locService.delegate=nil;
    _locService=nil;
    
    [self getSomePictures];
}
-(void)didFailToLocateUserWithError:(NSError *)error
{
    [self.delegate stopLoadingWithBG];
    [self.delegate showAlertViewWithTitle:nil message:@"定位失败,请检查系统设置里面定位是否开启" cancelButton:@"确定" others:nil];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.delegate stopLoadingWithBG];
    [self.delegate showAlertViewWithTitle:nil message:@"定位失败,请检查系统设置里面定位是否开启" cancelButton:@"确定" others:nil];
}
#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction
{
    [self.btnLike setHighlighted:NO];
    [self.btnUnlike setHighlighted:NO];
    NSLog(@"did swipe in direction: %zd", direction);
    
    //like or unlike the post
    if (direction==ZLSwipeableViewDirectionLeft)
    {
        AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        [appdelegate.m_homeVC likePostOperateInvitationId:[[self.m_aryData objectAtIndex:self.showedIndex] objectForKey:@"invitationId"] type:@"0"];
    }
    else
    {
        AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        [appdelegate.m_homeVC likePostOperateInvitationId:[[self.m_aryData objectAtIndex:self.showedIndex] objectForKey:@"invitationId"] type:@"1"];
    }

    
    self.showedIndex++;
    if (self.showedIndex>=self.m_aryData.count)
    {
//        [self.delegate showMessage:@"暂无更多"];
        [self.m_aryData removeAllObjects];
        self.currentIndex=0;
        self.showedIndex=0;
        self.pageIndex=1;
        [self getSomePictures];
    }
    NSLog(@"self.showedIndex :%d",self.showedIndex);
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
       didCancelSwipe:(UIView *)view {
//    NSLog(@"did cancel swipe");
    [self.btnLike setHighlighted:NO];
    [self.btnUnlike setHighlighted:NO];
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
//    NSLog(@"did start swiping at location: x %f, y %f", location.x, location.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation {
//    NSLog(@"swiping at location: x %f, y %f, translation: x %f, y %f",
//          location.x, location.y, translation.x, translation.y);
    if (translation.x>0)//right
    {
        [self.btnLike setHighlighted:YES];
    }
    else if (translation.x<0)//left
    {
        [self.btnUnlike setHighlighted:YES];
    }
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
//    NSLog(@"did end swiping at location: x %f, y %f", location.x, location.y);
}

#pragma mark - ZLSwipeableViewDataSource

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView
{
    if (self.currentIndex<self.m_aryData.count)
    {
        CardView *card=nil;
        card=[[[NSBundle mainBundle] loadNibNamed:@"CardView_i5" owner:nil options:nil] objectAtIndex:0];
        card.delegate=self;
        card.data=[self.m_aryData objectAtIndex:self.currentIndex];
        [card updateView];
        self.currentIndex++;
        //get more post data
        if (self.currentIndex==self.m_aryData.count-5)
        {
            self.pageIndex++;
            [self getSomePictures];
        }
        return card;
    }
    else
    {
        return nil;
    }
}
#pragma mark --------- event response
-(IBAction)selectSex:(id)sender
{
    [self.delegate showChooseSex];
}
-(IBAction)likeBtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==0)//left
    {
        [self.swipeableView swipeTopViewToLeft];
    }
    else
    {
        [self.swipeableView swipeTopViewToRight];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
