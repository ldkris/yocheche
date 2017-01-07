//
//  HomeVC.h
//  yocheche
//
//  Created by carcool on 6/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "HomeTabView.h"
#import "FollowView.h"
#import "HotCategoryView.h"
#import "MyCenterView.h"
#import "StudyView.h"
#import "SlideView.h"
#import "MyHomeProfileView.h"
#import "PostInfoCell.h"
#import "ImagePlayerView.h"
#import "EmbedReaderViewController.h"
#import "PostNameCell.h"
#import "PostPicCell.h"
#import "PostArticleCell.h"
#import "PostInfoCell.h"
#import "PostContentCell.h"
#import "PostTagsCell.h"
#import "VIPhotoView.h"
@interface HomeVC : YCCViewController<UIScrollViewDelegate,UIActionSheetDelegate,ImagePlayerViewDelegate,UIAlertViewDelegate,EmbedReaderViewControllerDelegate,PostInfoCellDelegate,PostNameCellDelegate,PostPicCellDelegate,PostArticleCellDelegate>
@property(nonatomic,retain)UIScrollView *m_scrollView;
@property(nonatomic,retain)FollowView *m_followView;
@property(nonatomic,retain)SlideView *m_searchView;
@property(nonatomic,retain)HotCategoryView *m_hotView;
@property(nonatomic,retain)StudyView *m_studyView;
@property(nonatomic,retain)MyHomeProfileView *m_profileView;
@property(nonatomic,retain)UIActionSheet *m_actionSheet;
@property(nonatomic,retain)NSString *searchSex;
@property (retain, nonatomic)ImagePlayerView *imagePlayerView;
@property(nonatomic,retain)NSMutableArray *m_aryAdvers;//welcome pages
@property(nonatomic,retain)NSMutableArray *m_aryAdversHome;//home pages
//sign in info
@property(nonatomic,retain)IBOutlet UIView *infoView;
@property(nonatomic,retain)IBOutlet UIButton *btnKe2;
@property(nonatomic,retain)IBOutlet UIButton *btnKe3;
@property(nonatomic,retain)IBOutlet UIView *lineView0;
@property(nonatomic,retain)IBOutlet UIView *lineView1;
@property(nonatomic,retain)IBOutlet UIView *lineView2;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *avaterCoach;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UILabel *labelClass;
@property(nonatomic,retain)IBOutlet UILabel *labelSchool;
@property(nonatomic,assign)NSInteger selectedClass;//2,3
@property(nonatomic,retain)NSDictionary *dataSignIn;
@property(nonatomic,retain)NSString *coachID;
//sign in end
//follow posts
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSMutableArray *m_aryContentHeight;
@property(nonatomic,retain)NSMutableArray *m_aryPicHeight;
@property(nonatomic,retain)NSMutableArray *m_aryTagHeight;
//follow posts end
//update version
@property(nonatomic,retain)NSString *trackUrl;
@property(nonatomic,retain)NSString *updateContent;
@property(nonatomic,retain)UILabel *labelUndoNum;
@property(nonatomic,assign)BOOL isLogged;
//update version end
//post delegate
@property(nonatomic,retain)UIView *screenBlackBG;
@property(nonatomic,retain)VIPhotoView *bigView;
//post delegate end
#pragma mark ------------- system operation -------
-(void)uploadLocation;
-(void)showInputInvitationCodeVC;
#pragma mark --------------- study ---------------------
-(void)checkToApplyOrApplyedStatus;
-(void)showSignInScanVC;
-(void)showSelectProgressVC;
-(void)showSchoolListVC;
-(void)showCoachListVC;
-(void)showKnowledgevc;
-(void)orderTrainDrive;
-(void)showStudyManageVC;
-(void)showFenqiVC;
-(void)showOrderExamVC;
#pragma mark --------------- social ---------------------
/////////////////// follow post view
-(void)updateFollowPostPageindex:(NSString*)Index pageSize:(NSString*)Count;
-(void)likePostOperate:(NSMutableDictionary*)postData postCell:(PostInfoCell*)followCell;
-(void)sharePostDetail:(NSDictionary*)invitationData;
/////////////////// hot categories ///////////////////
-(void)getHotCategoriesLat:(NSString*)lat Lng:(NSString*)lng;
-(void)showHotPostListVC:(NSInteger)index;
/////////////////// slide view
-(void)showSelectSearchSexActionSheet;
-(void)likePostOperateInvitationId:(NSString*)invitationId type:(NSString*)liketype;
-(void)updateSlideViewDataLat:(NSString*)latitude Lng:(NSString*)longitude PageIndex:(NSString*)pageIndex PageSize:(NSString*)pageSize;
-(void)showOtherCenterVC:(NSDictionary *)preData;
-(void)showPostVC:(NSDictionary*)preData;
//-social
#pragma mark --------------- my profile ---------------------
-(void)updateMyInfo;
-(void)showMyinfoVC:(NSDictionary*)predata;
-(void)showMyFansListVC;
-(void)showLikeMyListVC;
-(void)showCommentMyListVC;
-(void)showNotificationVC;
#pragma mark --------------- my profile new ---------------------
-(void)showMyInvitesVC;
-(void)showMyMessagesVC;

-(void)showWelcomeVC;
@end
