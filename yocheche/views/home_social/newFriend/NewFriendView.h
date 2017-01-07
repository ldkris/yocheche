//
//  NewFriendView.h
//  yocheche
//
//  Created by carcool on 1/7/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SocialHomeVC;
@interface NewFriendView : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, retain) SDRefreshFooterView *refreshFooter;
@property (nonatomic, retain) SDRefreshHeaderView *refreshHeader;
@property(nonatomic,assign)CLLocationCoordinate2D m_currentLocation;
@property(nonatomic,retain)UITableView *m_tableView;
@property(nonatomic,assign)SocialHomeVC *delegate;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,assign)NSInteger pageCount;
-(void)chatWithUserChatID:(NSString *)chatAccount username:(NSString *)name userAvatar:(NSString *)avatar account:(NSString*)accountOther;
@end
