//
//  OtherCenterVC.h
//  yocheche
//
//  Created by carcool on 8/16/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "OtherCenterActionCell.h"
#import "VIPhotoView.h"
#import "PostArticleCell.h"
@class OtherCenterTopCell;
@interface OtherCenterVC : YCCViewController<OtherCenterActionCellDelegate,PostInfoCellDelegate,PostNameCellDelegate,PostPicCellDelegate,PostArticleCellDelegate>
@property(nonatomic,retain)NSDictionary *preData;
@property(nonatomic,retain)NSMutableDictionary *data;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSMutableArray *m_aryContentHeight;
@property(nonatomic,retain)NSMutableArray *m_aryPicHeight;
@property(nonatomic,assign)NSInteger postType;//0:my post 1:my like post
@property(nonatomic,assign)NSInteger fromMyCenter;//1:from my center.
@property(nonatomic,retain)UIView *screenBlackBG;
@property(nonatomic,retain)OtherCenterTopCell *picCell;
@property(nonatomic,retain)VIPhotoView *bigView;
@property(nonatomic,retain)IBOutlet UIButton *btn;
@property(nonatomic,retain)NSDictionary *chatInfo;
-(void)createScreenView;
-(void)followTheUser;
-(void)showEditInfoVC;
-(void)showFollowOtherList;
-(void)showFansList;
-(void)getPostList;
-(void)getMyLikePostList;
@end
