//
//  YoView.h
//  yocheche
//
//  Created by carcool on 6/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SocialHomeVC;
@interface FollowView : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,retain)NSMutableArray *m_aryAdvers;
@property (nonatomic, retain) SDRefreshFooterView *refreshFooter;
@property (nonatomic, retain) SDRefreshHeaderView *refreshHeader;
@property(nonatomic,retain)UITableView *m_tableView;
@property(nonatomic,assign)SocialHomeVC *delegate;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSMutableArray *m_aryContentHeight;
@property(nonatomic,retain)NSMutableArray *m_aryCommentHeight;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,assign)NSInteger pageCount;
//hide navibar
@property(nonatomic,assign)BOOL isNaviHidden;
@property(nonatomic,assign)float old_y;
@property(nonatomic,assign)BOOL isHiddeningOrShowing;
@end
