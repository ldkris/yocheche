//
//  SiteMapView.h
//  yocheche
//
//  Created by carcool on 3/4/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SchoolListVC;
@interface SiteMapView : UIView
@property(nonatomic,assign)SchoolListVC *delegate;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@end
