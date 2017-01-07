//
//  CoachListVC.m
//  yocheche
//
//  Created by carcool on 7/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "CoachListVC.h"
#import "CoachCell.h"
#import "CoachDetailVC.h"
#import "FlitrateCoachVC.h"
@interface CoachListVC()


@end

@implementation CoachListVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"选择教练";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"切换位置"];
    [self.rightNaviBtn addTarget:self action:@selector(fixLocation) forControlEvents:UIControlEventTouchUpInside];
    
    self.isNaviHidden=NO;
    self.isHiddeningOrShowing=NO;
    self.m_aryData=[NSMutableArray array];
    self.m_flitrateData=[NSMutableDictionary dictionaryWithObjects:@[[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude],[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude],@"1",@"",@""] forKeys:@[@"lat",@"lng",@"sort",@"drivetype",@"dsname"]];
    
//    [self.view setFrame:CGRectMake(PARENT_X(self.view), PARENT_Y(self.view), PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view)+100)];
    [self addTableView];
    [self.m_tableView setFrame: CGRectMake(0,100, Screen_Width, Screen_Height-100)];
//    [self.m_tableView setFrame: CGRectMake(0,64, Screen_Width, Screen_Height-64)];
    self.old_y=self.m_tableView.contentOffset.y;
    [self setupHeader];
    [self setupFooter];
    
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
//    [self showLoadingWithBG];
}
-(void)fixLocation
{
    FixLocationVC *vc=[[FixLocationVC alloc] init];
    vc.FixLocationVCDelegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)setLocation:(CLLocationCoordinate2D)loc address:(NSString *)district
{
    self.m_currentLocation=CLLocationCoordinate2DMake(loc.latitude, loc.longitude);
    [self.m_flitrateData setObject:[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude] forKey:@"lat"];
    [self.m_flitrateData setObject:[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude] forKey:@"lng"];
    self.title=district;
    [self updateData];
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
    self.m_currentLocation= (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    [_locService stopUserLocationService];
    _locService.delegate=nil;
    _locService=nil;
    
    [self.m_flitrateData setObject:[NSString stringWithFormat:@"%f",self.m_currentLocation.latitude] forKey:@"lat"];
    [self.m_flitrateData setObject:[NSString stringWithFormat:@"%f",self.m_currentLocation.longitude] forKey:@"lng"];
    [self stopLoadingWithBG];
    [self updateData];
    
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

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNavigationBar) name:@"showCoachListNavi" object:nil];
    [MobClick beginLogPageView:@"CoachListVC"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showCoachListNavi" object:nil];
    [MobClick endLogPageView:@"CoachListVC"];
}
-(void)viewDidAppear:(BOOL)animated
{
}
-(void)viewDidLayoutSubviews
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    //cahnge @"0" to @"";
    for (NSString *key in [self.m_flitrateData allKeys])
    {
        if ([[self.m_flitrateData objectForKey:key] isEqualToString:@"0"])
        {
            [self.m_flitrateData setObject:@"" forKey:key];
        }
    }
    
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjects:@[@"coach.all.get",[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount]]forKeys:@[@"method",@"account",@"pageindex",@"pagesize"]];
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
            if (self.pageIndex==1)
            {
                [self.m_aryData removeAllObjects];
            }
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"infos"]];
            [self.m_tableView reloadData];
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
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
    }];

}
#pragma  mark ------ refresh delegate
-(void)headerRefresh
{
    self.pageIndex=1;
    [self updateData];
    
}
-(void)footerRefresh
{
    self.pageIndex++;
    [self updateData];
    
}

#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryData.count>0?self.m_aryData.count:1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.m_aryData.count==0)
    {
        UITableViewCell *cell=[[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 60)];
        UILabel *labelNoData=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 60)];
        [labelNoData setTextColor:YCC_TextDarkColor];
        [labelNoData setTextAlignment:NSTextAlignmentCenter];
        [labelNoData setFont:[UIFont systemFontOfSize:15.0]];
        labelNoData.text=@"没有找到合适的教练";
        [cell addSubview:labelNoData];
        return cell;
    }
    else
    {
        CoachCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CoachCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"CoachCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=[self.m_aryData objectAtIndex:indexPath.row];
        [cell updateView];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.m_aryData.count==0)
    {
        return 60;
    }
    else
    {
        return 260;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.m_aryData.count>0)
    {
        [self showNavigationBar];
        CoachDetailVC *vc=[[CoachDetailVC alloc] init];
        vc.preData=[self.m_aryData objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark --------------- show navigationbar ----------------
-(void)showNavigationBar
{
    if (self.isNaviHidden==YES)
    {
        self.isHiddeningOrShowing=YES;
        self.btnFlitrate.hidden=NO;
        [self.view setFrame:CGRectMake(PARENT_X(self.view), PARENT_Y(self.view)+80, PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
        [self.navigationController.navigationBar setFrame:CGRectMake(PARENT_X(self.navigationController.navigationBar),20, PARENT_WIDTH(self.navigationController.navigationBar), PARENT_HEIGHT(self.navigationController.navigationBar))];
        [self.m_tableView setFrame:CGRectMake(PARENT_X(self.m_tableView), PARENT_Y(self.m_tableView), PARENT_WIDTH(self.m_tableView), PARENT_HEIGHT(self.m_tableView)-80)];
        self.isNaviHidden=NO;
        self.isHiddeningOrShowing=NO;
    }
}
#pragma mark -------------- scrollview delegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.old_y=scrollView.contentOffset.y;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.isHiddeningOrShowing==NO)
    {
        if (scrollView.contentOffset.y<self.old_y)//up scroll
        {
            if (self.isNaviHidden==YES)
            {
                self.isHiddeningOrShowing=YES;
                self.btnFlitrate.hidden=NO;
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                    [self.navigationController.navigationBar setFrame:CGRectMake(PARENT_X(self.navigationController.navigationBar), 20, PARENT_WIDTH(self.navigationController.navigationBar), PARENT_HEIGHT(self.navigationController.navigationBar))];
                    [self.m_tableView setFrame:CGRectMake(PARENT_X(self.m_tableView), PARENT_Y(self.m_tableView), PARENT_WIDTH(self.m_tableView), PARENT_HEIGHT(self.m_tableView)-80)];
                } completion:^(BOOL finished) {
                    self.isNaviHidden=NO;
                    self.isHiddeningOrShowing=NO;
                }];
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                    [self.view setFrame:CGRectMake(PARENT_X(self.view), 0, PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
                } completion:^(BOOL finished) {
                    [self.view setFrame:CGRectMake(PARENT_X(self.view), 0, PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
                }];
            }
        }
        else//down scroll
        {
            if (self.isNaviHidden==NO)
            {
                self.isHiddeningOrShowing=YES;
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                    [self.navigationController.navigationBar setFrame:CGRectMake(PARENT_X(self.navigationController.navigationBar), -80, PARENT_WIDTH(self.navigationController.navigationBar), PARENT_HEIGHT(self.navigationController.navigationBar))];
                    [self.m_tableView setFrame:CGRectMake(PARENT_X(self.m_tableView), PARENT_Y(self.m_tableView), PARENT_WIDTH(self.m_tableView), PARENT_HEIGHT(self.m_tableView)+80)];
                } completion:^(BOOL finished) {
                    self.isNaviHidden=YES;
                    self.btnFlitrate.hidden=YES;
                    self.isHiddeningOrShowing=NO;
                }];
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                    [self.view setFrame:CGRectMake(PARENT_X(self.view), -80, PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
                } completion:^(BOOL finished) {
                    [self.view setFrame:CGRectMake(PARENT_X(self.view), -80, PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
                }];
            }
        }
        
    }
    else
    {
        return;
    }

}
#pragma mark --------- event response
-(IBAction)flitrateBtnPressed:(id)sender
{
    FlitrateCoachVC *vc=[[FlitrateCoachVC alloc] init];
    vc.delegate=self;
    vc.m_currentLocation=self.m_currentLocation;
    vc.m_currentAddress=self.title;
    vc.m_filtrateData=[NSMutableDictionary dictionaryWithDictionary:self.m_flitrateData];
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
