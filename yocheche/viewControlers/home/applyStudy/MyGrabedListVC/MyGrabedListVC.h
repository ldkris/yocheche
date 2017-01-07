//
//  MyGrabedListVC.h
//  yocheche
//
//  Created by carcool on 3/18/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface MyGrabedListVC : YCCViewController<UIAlertViewDelegate>
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)NSString *m_did;
@property(nonatomic,retain)NSString *m_coachId;
@property(nonatomic,assign)BOOL enableUpdateData;
-(void)submitCallEvent:(NSString*)orderid coachId:(NSString*)coachid;
-(void)showSignInNoteAlert:(NSString*)orderid coachId:(NSString*)coachid;
@end
