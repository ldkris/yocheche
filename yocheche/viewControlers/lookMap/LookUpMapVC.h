//
//  LookUpMapVC.h
//  yocheche
//
//  Created by carcool on 8/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface LookUpMapVC : YCCViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,CLLocationManagerDelegate>
{
    BMKMapView* _mapView;
}
@property (nonatomic, strong) CLLocationManager* locationMgr;
@property(nonatomic,assign)CLLocationCoordinate2D m_currentLocation;
@property(nonatomic,assign)CLLocationCoordinate2D m_userLocation;
@property(nonatomic,retain)NSString *address;
@end
