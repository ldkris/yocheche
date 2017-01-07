//
//  CoachListVC.h
//  yocheche
//
//  Created by carcool on 7/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "FixLocationVC.h"
@interface CoachListVC : YCCViewController<UIScrollViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,FixLocationVCDelegate,CLLocationManagerDelegate>
{
    BMKLocationService *_locService;
    BMKGeoCodeSearch *_searcher;
}
@property (nonatomic, strong) CLLocationManager* locationMgr;
@property(nonatomic,assign)CLLocationCoordinate2D m_currentLocation;
@property(nonatomic,assign)BOOL isNaviHidden;
@property(nonatomic,assign)float old_y;
@property(nonatomic,assign)BOOL isHiddeningOrShowing;
@property(nonatomic,retain)IBOutlet UIButton *btnFlitrate;
@property(nonatomic,retain)NSString *m_currentAddress;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSMutableDictionary *m_flitrateData;
-(void)updateData;
-(void)setLocation:(CLLocationCoordinate2D)loc address:(NSString *)district;
@end
