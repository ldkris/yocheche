//
//  LocateVC.h
//  yocheche
//
//  Created by carcool on 7/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import <BaiduMapAPI/BMapKit.h>
@interface LocateVC : YCCViewController<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKLocationService *_locService;
    BMKGeoCodeSearch *_searcher;
}
@property(nonatomic,retain)IBOutlet MyButton *buttonSelectLocation;
@property(nonatomic,retain)IBOutlet MyButton *buttonDone;
@property(nonatomic,retain)IBOutlet UILabel *labelAddress;
@property(nonatomic,assign)CLLocationCoordinate2D m_currentLocation;
@property(nonatomic,retain)NSString *m_currentAddress;
@end
