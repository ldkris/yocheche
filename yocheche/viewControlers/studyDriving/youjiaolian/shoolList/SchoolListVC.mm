//
//  SchoolListVC.m
//  yocheche
//
//  Created by carcool on 11/30/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SchoolListVC.h"
#import "SchoolCell.h"
#import "FiltrateSchoolVC.h"
#import "SchoolDetailVC.h"
#import "FlitrateCoachVC.h"
#import "CoachDetailVC.h"
@interface SchoolListVC ()

@end

@implementation SchoolListVC
@synthesize m_scrollView,m_schoolListView,m_coachListView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"优驾校";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"筛选排序"];
    [self.rightNaviBtn addTarget:self action:@selector(showSchoolFiltrate) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationBar.hidden=YES;
    self.type=1;
    self.m_flitrateData=[NSMutableDictionary dictionaryWithObjects:@[[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude],[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude],@"0",@""] forKeys:@[@"lat",@"lng",@"orderType",@"dsname"]];
    self.m_flitrateDataCoach=[NSMutableDictionary dictionaryWithObjects:@[[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude],[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude],@"1",@"",@""] forKeys:@[@"lat",@"lng",@"sort",@"drivetype",@"dsname"]];
    
    [self createScrollView];
    
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
    self.m_currentLocation=(CLLocationCoordinate2D){0.0,0.0};
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"选驾校"];
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"选驾校"];
}
-(IBAction)backBtnPressed:(id)sender
{
    [self popSelfViewContriller];
}
-(void)updateData//school
{
    //cahnge @"0" to @"";
    for (NSString *key in [self.m_flitrateData allKeys])
    {
        if ([[self.m_flitrateData objectForKey:key] isEqualToString:@"0"])
        {
            [self.m_flitrateData setObject:@"" forKey:key];
        }
    }
    
    Http *req=[[Http alloc] init];
    req.socialMethord=@"ds/getDsList.yo";
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjects:@[[NSString stringWithFormat:@"%d",self.m_schoolListView.pageIndex],[NSString stringWithFormat:@"%d",self.m_schoolListView.pageCount]]forKeys:@[@"pageindex",@"pagesize"]];
    [dic addEntriesFromDictionary:self.m_flitrateData];
    NSArray *keys=[dic allKeys];
    NSMutableArray *objects=[NSMutableArray array];
    for (NSString *key in keys)
    {
        [objects addObject:[dic objectForKey:key]];
    }
    [req setParams:objects forKeys:keys];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if (self.m_schoolListView.pageIndex==1)
            {
                [self.m_schoolListView.m_aryData removeAllObjects];
            }
            [self.m_schoolListView.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"dsList"]];
            [self.m_schoolListView.m_tableView reloadData];
        }
        else
        {
            if ([req.m_data valueForKey:@"msg"])
            {
                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
            }
            else
            {
                [self showNetworkError];
            }
            
        }
        [self.m_schoolListView.refreshHeader endRefreshing];
        [self.m_schoolListView.refreshFooter endRefreshing];
    }];

}
-(void)updateDataForCoach//coach
{
    //cahnge @"0" to @"";
    for (NSString *key in [self.m_flitrateDataCoach allKeys])
    {
        if ([[self.m_flitrateDataCoach objectForKey:key] isEqualToString:@"0"])
        {
            [self.m_flitrateDataCoach setObject:@"" forKey:key];
        }
    }
    
//    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjects:@[@"coach.all.get",[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%d",self.m_coachListView.pageIndex],[NSString stringWithFormat:@"%d",self.m_coachListView.pageCount]]forKeys:@[@"method",@"account",@"pageindex",@"pagesize"]];
    [dic addEntriesFromDictionary:self.m_flitrateDataCoach];
    NSArray *keys=[dic allKeys];
    NSMutableArray *objects=[NSMutableArray array];
    for (NSString *key in keys)
    {
        [objects addObject:[dic objectForKey:key]];
    }
    [req setParams:objects forKeys:keys];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if (self.m_coachListView.pageIndex==1)
            {
                [self.m_coachListView.m_aryData removeAllObjects];
            }
            [self.m_coachListView.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"coachList"]];
            [self.m_coachListView.m_tableView reloadData];
        }
        else
        {
            if ([req.m_data valueForKey:@"msg"])
            {
                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
            }
            else
            {
                [self showNetworkError];
            }
            
        }
        [self.m_coachListView.refreshHeader endRefreshing];
        [self.m_coachListView.refreshFooter endRefreshing];
    }];
    
}
-(void)updateDataForSite//site
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"ds/getNearbySpaceList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude],[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude]] forKeys:@[@"account",@"lat",@"lng"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.m_siteMapView.m_aryData removeAllObjects];
            [self.m_siteMapView.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"spaces"]];
        }
        else
        {
            if ([req.m_data valueForKey:@"msg"])
            {
                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
            }
            else
            {
                [self showNetworkError];
            }
            
        }
    }];
    
}
#pragma mark -------- create views -----------
-(void)createScrollView
{
    self.m_scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    self.m_scrollView.bounces=NO;
    self.m_scrollView.delegate=self;
    self.m_scrollView.tag=11;
    [m_scrollView setContentSize:CGSizeMake(Screen_Width*1,PARENT_HEIGHT(self.m_scrollView))];
    m_scrollView.showsHorizontalScrollIndicator=NO;
    m_scrollView.pagingEnabled=YES;
    [m_scrollView setBackgroundColor:[UIColor lightGrayColor]];
    self.m_scrollView.scrollEnabled=YES;
    [self.view addSubview:self.m_scrollView];
    
    UIButton *btnSender=[UIButton buttonWithType:UIButtonTypeCustom];
    btnSender.tag=0;
    if (self.from==1)
    {
        btnSender.tag=1;
    }
    
}
-(void)createSchoolListView
{
    self.m_schoolListView=[[SchoolListView alloc]
                    initWithFrame:CGRectMake(0, 0, Screen_Width, PARENT_HEIGHT(self.m_scrollView))];
    self.m_schoolListView.delegate=self;
    [self.m_scrollView addSubview:m_schoolListView];
    [self updateData];
}
-(void)createCoachListView
{
    self.m_coachListView=[[CoachListView alloc]
                           initWithFrame:CGRectMake(0, 0, Screen_Width, PARENT_HEIGHT(self.m_scrollView))];
    self.m_coachListView.delegate=self;
    [self.m_scrollView addSubview:m_coachListView];
    [self updateDataForCoach];
}
-(void)createSiteMapView
{
    self.m_siteMapView=[[SiteMapView alloc]
                          initWithFrame:CGRectMake(Screen_Width*2, 0, Screen_Width, PARENT_HEIGHT(self.m_scrollView))];
    self.m_siteMapView.delegate=self;
    [self.m_scrollView addSubview:self.m_siteMapView];
    [self updateDataForSite];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setLocation:(CLLocationCoordinate2D)loc address:(NSString *)district
{
    self.m_currentLocation=CLLocationCoordinate2DMake(loc.latitude, loc.longitude);
    self.title=district;
    if (self.type==0)
    {
        [self.m_flitrateData setObject:[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude] forKey:@"lat"];
        [self.m_flitrateData setObject:[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude] forKey:@"lng"];
        [self updateData];
    }
    else
    {
        [self.m_flitrateDataCoach setObject:[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude] forKey:@"lat"];
        [self.m_flitrateDataCoach setObject:[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude] forKey:@"lng"];
        [self updateDataForCoach];
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
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    //发起反向地理编码检索
    if (userLocation.location.coordinate.latitude>0)
    {
        self.m_currentLocation= (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    }
    else
    {
        AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        self.m_currentLocation= (CLLocationCoordinate2D){appdelegate.m_currentLocation.latitude, appdelegate.m_currentLocation.longitude};
    }
    [_locService stopUserLocationService];
    _locService.delegate=nil;
    _locService=nil;
    
    [self.m_flitrateData setObject:[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude] forKey:@"lat"];
    [self.m_flitrateData setObject:[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude] forKey:@"lng"];
    [self.m_flitrateDataCoach setObject:[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude] forKey:@"lat"];
    [self.m_flitrateDataCoach setObject:[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude] forKey:@"lng"];
    [self stopLoadingWithBG];
//    [self createSchoolListView];
    [self createCoachListView];
//    [self createSiteMapView];
    
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                            BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = self.m_currentLocation;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}
-(void)didFailToLocateUserWithError:(NSError *)error
{
    [self stopLoadingWithBG];
    [self showAlertViewWithTitle:nil message:@"定位失败,请检查系统设置里面定位是否开启" cancelButton:@"确定" others:nil];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self stopLoadingWithBG];
    [self showAlertViewWithTitle:nil message:@"定位失败,请检查系统设置里面定位是否开启" cancelButton:@"确定" others:nil];
}
#pragma mark --------- BMKGeoCodeSearch delegate
//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        self.m_currentAddress=result.addressDetail.district;
        _searcher.delegate = nil;
        [_locService stopUserLocationService];
        _locService.delegate=nil;
        
        NSArray* array = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES );
        NSString* savePath = [NSString stringWithFormat:@"%@/citycode",[array objectAtIndex: 0]];
        NSMutableArray *citycodeArray= [NSKeyedUnarchiver unarchiveObjectWithFile:savePath];
        
        NSString *citycode=@"";
        for (NSDictionary *dic in citycodeArray)
        {
            if ([[dic objectForKey:@"city"] isEqualToString:result.addressDetail.city])
            {
                citycode=[dic objectForKey:@"code"];
                break;
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:citycode forKey:@"citycode"];
        self.title=self.m_currentAddress;
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}


#pragma mark --------- event response school -------------
-(IBAction)filtrateBtnPressed:(id)sender
{
    if (self.type==0)
    {
        [self showSchoolFiltrate];
    }
    else if (self.type==1)
    {
        self.navigationController.navigationBar.hidden=NO;
        
        FlitrateCoachVC *vc=[[FlitrateCoachVC alloc] init];
        vc.delegate=self;
        vc.m_currentLocation=self.m_currentLocation;
        vc.m_currentAddress=self.title;
        vc.m_filtrateData=[NSMutableDictionary dictionaryWithDictionary:self.m_flitrateDataCoach];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)showSchoolFiltrate
{
    self.navigationController.navigationBar.hidden=NO;
    FiltrateSchoolVC *vc=[[FiltrateSchoolVC alloc] init];
    vc.delegate=self;
    vc.m_currentLocation=self.m_currentLocation;
    vc.m_currentAddress=self.title;
    vc.m_filtrateData=[NSMutableDictionary dictionaryWithDictionary:self.m_flitrateData];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showSchoolDetailVC:(NSDictionary *)data
{
    self.navigationController.navigationBar.hidden=NO;
    SchoolDetailVC *vc=[[SchoolDetailVC alloc] init];
    vc.dsid=[data objectForKey:@"dsid"];
    vc.preData=data;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --------- event response coach -------------
-(void)showCoachDetailVC:(NSDictionary*)data
{
    self.navigationController.navigationBar.hidden=NO;
    CoachDetailVC *vc=[[CoachDetailVC alloc] init];
    vc.preData=data;
    [self.navigationController pushViewController:vc animated:YES];
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
