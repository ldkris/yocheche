//
//  FixLocationVC.m
//  yocheche
//
//  Created by carcool on 7/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "FixLocationVC.h"
#import "FlitrateCoachVC.h"
@interface FixLocationVC ()

@end

@implementation FixLocationVC
@synthesize citycode;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"选择位置";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomView setFrame:CGRectMake(0, Screen_Height-77, Screen_Width, 77)];
    [self.view addSubview:self.bottomView];
    self.textfield.delegate=self;
    
    self.m_userLocation=(CLLocationCoordinate2D){0, 0};
    self.m_currentLocation=(CLLocationCoordinate2D){0, 0};
    
    self.locationMgr = [[CLLocationManager alloc] init];
    if([self.locationMgr respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [self.locationMgr requestAlwaysAuthorization]; // 永久授权
        [self.locationMgr requestWhenInUseAuthorization]; //使用中授权
    }
    //设置代理
    self.locationMgr.delegate = self;
    self.locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationMgr.distanceFilter = 1000.0f;
    //map
    _mapView= [[BMKMapView alloc]initWithFrame:CGRectMake(0, 110, Screen_Width, Screen_Height-110-77)];
    _mapView.zoomLevel=14.0;
    [self.view addSubview:_mapView];
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
//    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
//    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
//    _mapView.showsUserLocation = YES;//显示定位图层
    
    UIImageView *centerBlack=[[UIImageView alloc] initWithFrame:CGRectMake((Screen_Width-18)/2.0, (Screen_Height-64-46-77-46)/2.0+110, 18, 23)];
    [centerBlack setImage:[UIImage imageNamed:@"centerPoint"]];
    [self.view addSubview:centerBlack];
    
    UIButton *centerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [centerBtn setFrame:CGRectMake(20, Screen_Height-77-26-20, 26, 26)];
    [centerBtn setImage:[UIImage imageNamed:@"center2_map"] forState:UIControlStateNormal];
    [centerBtn addTarget:self action:@selector(setUserLocationCenter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:centerBtn];
    
    UIImageView *zoom=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width-41-20, Screen_Height-77-77-20, 41, 77)];
    zoom.userInteractionEnabled=YES;
    [zoom setImage:[UIImage imageNamed:@"zoom_map"]];
    [self.view addSubview:zoom];
    UIButton *btnj=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnj setFrame:CGRectMake(0, 0, 41, 35.0)];
    [btnj addTarget:self action:@selector(zoomjia) forControlEvents:UIControlEventTouchUpInside];
    [zoom addSubview:btnj];
    UIButton *btnjian=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnjian setFrame:CGRectMake(0, 35.5, 41, 35.0)];
    [btnjian addTarget:self action:@selector(zoomjian) forControlEvents:UIControlEventTouchUpInside];
    [zoom addSubview:btnjian];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    [MobClick beginLogPageView:@"FixLocationVC"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    [MobClick endLogPageView:@"FixLocationVC"];
}
#pragma mark ------- textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchPlace:nil];
    return YES;
}
-(IBAction)searchPlace:(id)sender
{
    [self.textfield resignFirstResponder];
    if (![self.textfield.text isEqualToString:@""])
    {
        NSLog(@"self.textfield.text :%@",self.textfield.text);
        BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
        geoCodeSearchOption.city= @"重庆市";
        geoCodeSearchOption.address = self.textfield.text;
        BOOL flag = [_searcher geoCode:geoCodeSearchOption];
        if(flag)
        {
            NSLog(@"geo检索发送成功");
        }
        else
        {
            NSLog(@"geo检索发送失败");
        }
        
        //save citycode
        NSArray* array = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES );
        NSString* savePath = [NSString stringWithFormat:@"%@/citycode",[array objectAtIndex: 0]];
        NSMutableArray *citycodeArray= [NSKeyedUnarchiver unarchiveObjectWithFile:savePath];
        
        self.citycode=@"";
        for (NSDictionary *dic in citycodeArray)
        {
            if ([[dic objectForKey:@"city"] isEqualToString:geoCodeSearchOption.city])
            {
                self.citycode=[dic objectForKey:@"code"];
                break;
            }
        }

    }
}
#pragma mark --------- location manager delegate ------------
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self stopLoadingWithBG];
    [self showAlertViewWithTitle:nil message:@"定位失败,请检查系统设置里面定位是否开启" cancelButton:@"确定" others:nil];
}
#pragma mark ------ map delegate
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    [_mapView updateLocationData:userLocation];
    self.m_userLocation=(CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    [self setUserLocationCenter];
    
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
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
-(void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    self.m_currentLocation=mapView.centerCoordinate;
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = mapView.centerCoordinate;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
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
#pragma mark --------- BMKGeoCodeSearch delegate
//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        self.labelAddress.text=result.address;
        self.district=result.addressDetail.district;
        [_locService stopUserLocationService];
        _locService.delegate=nil;
//        _searcher.delegate = nil;
//        _mapView.delegate=nil;
        
        NSArray* array = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES );
        NSString* savePath = [NSString stringWithFormat:@"%@/citycode",[array objectAtIndex: 0]];
        NSMutableArray *citycodeArray= [NSKeyedUnarchiver unarchiveObjectWithFile:savePath];
        
        self.citycode=@"";
        for (NSDictionary *dic in citycodeArray)
        {
            if ([[dic objectForKey:@"city"] isEqualToString:result.addressDetail.city])
            {
                self.citycode=[dic objectForKey:@"code"];
                break;
            }
        }

    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}
//正向地理编码
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        self.m_currentLocation=result.location;
        self.labelAddress.text=result.address;
        self.district=result.address;
        [_mapView setCenterCoordinate:self.m_currentLocation];
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}
#pragma mark ------- event response
-(void)zoomjia
{
    _mapView.zoomLevel=_mapView.zoomLevel+1.0;
}
-(void)zoomjian
{
    _mapView.zoomLevel=_mapView.zoomLevel-1.0;
}
-(void)setUserLocationCenter
{
    [_mapView setCenterCoordinate:self.m_userLocation];
    self.m_currentLocation=self.m_userLocation;
}
-(IBAction)doneBtnPressed:(id)sender
{
    if (self.delegate)
    {
        self.delegate.labelAddress.text=self.labelAddress.text;
        self.delegate.m_currentAddress=self.labelAddress.text;
        self.delegate.m_currentLocation=self.m_currentLocation;
    }
    else if(self.delegateFlitrate)
    {
        self.delegateFlitrate.m_currentAddress=self.labelAddress.text;
        self.delegateFlitrate.m_currentLocation=self.m_currentLocation;
        [self.delegateFlitrate.m_tableView reloadData];
    }
    else
    {
        [self.FixLocationVCDelegate setLocation:self.m_currentLocation address:self.district];
    }
    //save city code
    [[NSUserDefaults standardUserDefaults] setObject:self.citycode forKey:@"citycode"];
    [self.navigationController popViewControllerAnimated:YES];
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
