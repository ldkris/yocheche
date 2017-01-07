//
//  FixLocationVC.h
//  yocheche
//
//  Created by carcool on 7/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "LocateVC.h"
@class  FlitrateCoachVC;
@protocol FixLocationVCDelegate <NSObject>
-(void)setLocation:(CLLocationCoordinate2D)loc address:(NSString*)district;
@end
@interface FixLocationVC : YCCViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UITextFieldDelegate,CLLocationManagerDelegate>
{
    BMKMapView* _mapView;
    BMKLocationService* _locService;
    BMKGeoCodeSearch *_searcher;
}
@property (nonatomic, strong) CLLocationManager* locationMgr;
@property(nonatomic,retain)IBOutlet UIView *bottomView;
@property(nonatomic,retain)IBOutlet UITextField *textfield;
@property(nonatomic,retain)IBOutlet UILabel *labelAddress;
@property(nonatomic,assign)CLLocationCoordinate2D m_currentLocation;
@property(nonatomic,retain)NSString *m_currentAddress;
@property(nonatomic,assign)CLLocationCoordinate2D m_userLocation;
@property(nonatomic,assign)LocateVC *delegate;
@property(nonatomic,assign)FlitrateCoachVC *delegateFlitrate;
@property(nonatomic,assign)id<FixLocationVCDelegate> FixLocationVCDelegate;
@property(nonatomic,retain)NSString *district;
@property(nonatomic,retain)NSString *citycode;
@end
