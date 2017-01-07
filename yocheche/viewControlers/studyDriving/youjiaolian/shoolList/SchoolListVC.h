//
//  SchoolListVC.h
//  yocheche
//
//  Created by carcool on 11/30/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "SchoolListView.h"
#import "CoachListView.h"
#import "SiteMapView.h"
@interface SchoolListVC : YCCViewController<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,CLLocationManagerDelegate>
{
    BMKLocationService *_locService;
    BMKGeoCodeSearch *_searcher;
}
@property (nonatomic, strong) CLLocationManager* locationMgr;
@property(nonatomic,assign)CLLocationCoordinate2D m_currentLocation;
@property(nonatomic,retain)NSString *m_currentAddress;
@property(nonatomic,retain)NSMutableDictionary *m_flitrateData;//school
@property(nonatomic,retain)NSMutableDictionary *m_flitrateDataCoach;//coach
@property(nonatomic,assign)NSInteger type;//0:shcool 1:coach 2:site
@property(nonatomic,assign)IBOutlet UILabel *labelCoach;
@property(nonatomic,assign)IBOutlet UIImageView *imgFiltrate;
@property(nonatomic,assign)IBOutlet UIButton *btnFiltrate;
@property(nonatomic,retain)UIScrollView *m_scrollView;
@property(nonatomic,retain)SchoolListView *m_schoolListView;
@property(nonatomic,retain)CoachListView *m_coachListView;
@property(nonatomic,retain)SiteMapView *m_siteMapView;
@property(nonatomic,assign)NSInteger from;//0:school 1:coach
-(void)updateData;//school
-(void)updateDataForCoach;//coach
-(void)setLocation:(CLLocationCoordinate2D)loc address:(NSString *)district;
-(void)showSchoolDetailVC:(NSDictionary*)data;
-(void)showCoachDetailVC:(NSDictionary*)data;
@end
