//
//  LocateVC.m
//  yocheche
//
//  Created by carcool on 7/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "LocateVC.h"
#import "FixLocationVC.h"
#import "CoachListVC.h"
@interface LocateVC ()

@end

@implementation LocateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"确定位置";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    self.m_currentLocation=(CLLocationCoordinate2D){0.0};
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
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
#pragma mark --------- BMKGeoCodeSearch delegate
//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
errorCode:(BMKSearchErrorCode)error{
  if (error == BMK_SEARCH_NO_ERROR) {
      self.labelAddress.text=result.address;
      self.m_currentAddress=result.address;
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
      
  }
  else {
      NSLog(@"抱歉，未找到结果");
  }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)fixLocation:(id)sender
{
    FixLocationVC *vc=[[FixLocationVC alloc] init];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)doneLocating:(id)sender
{
    CoachListVC *vc=[[CoachListVC alloc] init];
    vc.m_currentLocation=self.m_currentLocation;
    vc.m_currentAddress=self.m_currentAddress;
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
