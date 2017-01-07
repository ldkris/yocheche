//
//  HotCategoryView.h
//  yocheche
//
//  Created by carcool on 6/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SocialHomeVC;
@interface HotCategoryView : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, retain) SDRefreshFooterView *refreshFooter;
@property (nonatomic, retain) SDRefreshHeaderView *refreshHeader;
@property(nonatomic,assign)CLLocationCoordinate2D m_currentLocation;
@property(nonatomic,retain)UITableView *m_tableView;
@property(nonatomic,assign)SocialHomeVC *delegate;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@end
