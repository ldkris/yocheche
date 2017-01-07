//
//  StudyHomeVC.h
//  yocheche
//
//  Created by carcool on 11/18/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "EmbedReaderViewController.h"
@interface StudyHomeVC : YCCViewController<EmbedReaderViewControllerDelegate,UIAlertViewDelegate>
@property(nonatomic,retain)StudyView *m_studyView;
//coach and study info view
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
-(void)showSelectProgressVC;
-(void)showSelectLocateVC;
-(void)showKnowledgevc;
-(void)orderTrainDrive;
-(void)scanAndRegister;

@end
