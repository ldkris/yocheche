//
//  CoachDetailVC.h
//  yocheche
//
//  Created by carcool on 7/22/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface CoachDetailVC : YCCViewController<UIScrollViewDelegate>
@property(nonatomic,retain)IBOutlet UIView *btnBG1;
@property(nonatomic,retain)NSMutableArray *m_aryShowed;
@property(nonatomic,retain)NSDictionary *preData;
@property(nonatomic,retain)NSDictionary *coachData;
@property(nonatomic,retain)NSDictionary *commentData;
@property(nonatomic,retain)NSDictionary *schoolData;
@property(nonatomic,retain)NSDictionary *spaceData;
@property(nonatomic,retain)NSMutableArray *m_aryStudents;
@property(nonatomic,retain)NSArray *feeArray;
@property(nonatomic,retain)NSMutableArray *expendedArray;
@property(nonatomic,assign)NSInteger selectedScheme;
@property(nonatomic,assign)float contentHeight;
@property(nonatomic,assign)NSInteger signUpFlag;//1:未报名 2:已报名
@property(nonatomic,retain)NSString *bundleCoachID;
-(void)showLookupMapVC;
-(void)showInviteFriendVC;
-(void)showCommentVC;
-(void)feeExpandBtnPressed:(NSInteger)feeIndex expend:(NSString*)expended;
-(void)bundleCoach;
-(void)showStudentCenterVC:(NSString*)account;
@end
