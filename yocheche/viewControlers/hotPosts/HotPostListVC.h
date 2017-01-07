//
//  HotPostListVC.h
//  yocheche
//
//  Created by carcool on 8/23/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "PostNameCell.h"
#import "PostPicCell.h"
#import "PostArticleCell.h"
#import "VIPhotoView.h"
@interface HotPostListVC : YCCViewController<PostInfoCellDelegate,PostNameCellDelegate,PostPicCellDelegate,PostArticleCellDelegate>
@property(nonatomic,assign)CLLocationCoordinate2D m_currentLocation;
@property(nonatomic,retain)NSDictionary *preData;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSMutableArray *m_aryContentHeight;
@property(nonatomic,retain)NSMutableArray *m_aryPicHeight;
@property(nonatomic,retain)NSMutableArray *m_aryCommentHeight;
@property(nonatomic,retain)UIView *screenBlackBG;
@property(nonatomic,retain)VIPhotoView *bigView;
//hide navibar
@property(nonatomic,assign)BOOL isNaviHidden;
@property(nonatomic,assign)float old_y;
@property(nonatomic,assign)BOOL isHiddeningOrShowing;
//hot or from homepage
@property(nonatomic,retain)NSString *strOrigin;//"":hot "1":home comment "2":home buycar
@end
