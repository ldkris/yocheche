//
//  MyCenterView.h
//  yocheche
//
//  Created by carcool on 6/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OtherCenterActionCell.h"
@class MySocialCenterVC;
@interface MyCenterView : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,OtherCenterActionCellDelegate>
@property(nonatomic,retain)UITableView *m_tableView;
@property(nonatomic,assign)MySocialCenterVC *delegate;
@property(nonatomic,assign)float old_y;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property (nonatomic, retain) SDRefreshFooterView *refreshFooter;
@property (nonatomic, retain) SDRefreshHeaderView *refreshHeader;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,assign)NSInteger pageCount;
@property(nonatomic,assign)NSInteger postType;//0:my post 1:my like post
-(void)showEditInfoVC;
@end
