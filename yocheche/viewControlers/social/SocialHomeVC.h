//
//  SocialHomeVC.h
//  yocheche
//
//  Created by carcool on 9/18/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "FollowView.h"
#import "HotCategoryView.h"
#import "NewFriendView.h"
#import "MyCenterView.h"
#import "PostNameCell.h"
#import "PostPicCell.h"
#import "VIPhotoView.h"
@interface SocialHomeVC : YCCViewController<UIScrollViewDelegate,PostNameCellDelegate,PostPicCellDelegate,BMKLocationServiceDelegate,CLLocationManagerDelegate>
{
    BMKLocationService *_locService;
}
@property (nonatomic, strong) CLLocationManager* locationMgr;
@property(nonatomic,assign)CLLocationCoordinate2D m_currentLocation;
@property(nonatomic,assign)IBOutlet UIImageView *imgFiltrate;
@property(nonatomic,assign)IBOutlet UIButton *btnFiltrate;
@property(nonatomic,retain)IBOutlet UIView *topbg;
@property(nonatomic,retain)UIView *topLineView;
@property(nonatomic,retain)UIScrollView *m_scrollView;
@property(nonatomic,retain)IBOutlet UILabel *labelFollow;
@property(nonatomic,retain)IBOutlet UILabel *labelHot;
@property(nonatomic,retain)IBOutlet UIView *filtrateView;
@property(nonatomic,retain)IBOutlet UIButton *btnType1;
@property(nonatomic,retain)IBOutlet UIButton *btnType2;
@property(nonatomic,retain)IBOutlet UIButton *btnSex1;
@property(nonatomic,retain)IBOutlet UIButton *btnSex2;
@property(nonatomic,retain)IBOutlet UIButton *btnSex3;
@property(nonatomic,retain)IBOutlet UIButton *btnCancel;
@property(nonatomic,retain)IBOutlet UIButton *btnDone;
@property(nonatomic,retain)UIButton *btnRemove;
@property(nonatomic,retain)FollowView *m_followView;
@property(nonatomic,retain)HotCategoryView *m_hotView;
@property(nonatomic,retain)NewFriendView *m_newFriendView;
@property(nonatomic,retain)UIView *screenBlackBG;
@property(nonatomic,retain)VIPhotoView *bigView;
@property(nonatomic,retain)NSString *friendType;//1附近 2同校师兄妹
@property(nonatomic,retain)NSString *friendSex;//1男 2女
-(IBAction)topMenuBtnPressed:(id)sender;
/////////////////// follow post view
-(void)updateFollowPostPageindex:(NSString*)Index pageSize:(NSString*)Count;
-(void)likePostOperate:(NSMutableDictionary*)postData postCell:(PostInfoCell*)followCell;
-(void)sharePostDetail:(NSDictionary*)invitationData;
-(void)showPostVC:(NSDictionary*)preData;
/////////////////// hot categories ///////////////////
-(void)getHotCategoriesLat:(NSString*)lat Lng:(NSString*)lng;
-(void)showHotPostListVC:(NSInteger)index;
-(void)showSlidePostVC;
//////////////////new friend /////////////////////
-(void)submitLBSToBaiduLat:(NSString*)lat Lng:(NSString*)lng;
-(void)getNewFriendLat:(NSString*)lat Lng:(NSString*)lng Pageindex:(NSString*)Index pageSize:(NSString*)Count;
-(void)showOtherCenterVC:(NSString*)account;
@end
