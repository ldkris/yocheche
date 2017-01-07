//
//  LookUpMapVC.m
//  yocheche
//
//  Created by carcool on 8/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "LookUpMapVC.h"

@interface LookUpMapVC ()

@end

@implementation LookUpMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"场地位置";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
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
    _mapView= [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    _mapView.zoomLevel=14.0;
    [self.view addSubview:_mapView];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    [self setUserLocationCenter];
    
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = self.m_userLocation;
    annotation.title = self.address;
    [_mapView addAnnotation:annotation];
    
//    UIImageView *centerBlack=[[UIImageView alloc] initWithFrame:CGRectMake((Screen_Width-18)/2.0, (Screen_Height-64-46-77-46)/2.0+110, 18, 23)];
//    [centerBlack setImage:[UIImage imageNamed:@"centerPoint"]];
//    [self.view addSubview:centerBlack];
//    
//    UIButton *centerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [centerBtn setFrame:CGRectMake(20, Screen_Height-80, 26, 26)];
//    [centerBtn setImage:[UIImage imageNamed:@"center2_map"] forState:UIControlStateNormal];
//    [centerBtn addTarget:self action:@selector(setUserLocationCenter) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:centerBtn];
    
    UIImageView *zoom=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width-41-20, Screen_Height-80, 41, 77)];
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
// Override .... mapview delegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
