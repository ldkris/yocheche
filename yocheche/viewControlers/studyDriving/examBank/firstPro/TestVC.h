//
//  TestVC.h
//  weixueche
//
//  Created by carcool on 12/6/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import "YCCViewController.h"
#import "TestModel.h"
#import "FirstProgressVC.h"
#import "ExamTabView.h"
@class FirstProgressVC;
@class ExamTabView;
@interface TestVC : YCCViewController<UIScrollViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
@property(nonatomic,retain)UIActionSheet *m_actionSheet;
@property(nonatomic,retain)TestModel *mytestmodel;
@property(nonatomic,assign)CGPoint oldPoint;
@property(nonatomic,assign)CGPoint newPoint;
@property(nonatomic,retain)UIScrollView *m_scrollView;
@property(nonatomic,assign)CGPoint oldOffset;
@property(nonatomic,retain)UILabel *labelPage;
@property(nonatomic,retain)UIImageView *car;
@property(nonatomic,retain)NSMutableArray *m_aryPages;//7 views alive
@property(nonatomic,retain)NSMutableArray *m_aryTests;//all test data
@property(nonatomic,assign)NSInteger showAllAnswersFlag;
@property(nonatomic,retain)LogInfo *m_loginfo;
@property(nonatomic,assign)FirstProgressVC *delegateVC;
@property(nonatomic,retain)ExamTabView *examTab;
@property(nonatomic,assign)NSInteger examTime;
@property(nonatomic,retain)NSMutableDictionary *m_dicSelected;//dic : @{@"0":@"B"}
@property(nonatomic,retain)UIView *blackBG;
@property(nonatomic,retain)UIView *whiteBG;
@property(nonatomic,retain)UIScrollView *scrollSelectPage;
@property(nonatomic,retain)NSMutableArray *pageButtons;
@property(nonatomic,retain)UIButton *btnPageDone;
@property(nonatomic,retain)UIButton *btnPageCancel;
@property(nonatomic,retain)UIImageView *help;
@property(nonatomic,retain)UIImageView *help_l;
@property(nonatomic,retain)UIImageView *help_r;
@property(nonatomic,retain)UIImageView *imgfavor;
@property(nonatomic,retain)UIImageView *imganswer;
@property(nonatomic,retain)UIImageView *imgexplain;
-(void)setPages:(NSInteger)next;
-(void)showAllAnswers;
-(void)setTheSettings;
-(void)showExplain;
-(void)deleteSavedTest;
-(void)submitExamScore;
-(void)examTimeOut;
-(void)setSelectedArrayIndex:(NSString*)index selectedItem:(NSString*)item;
-(void)autoScroll;
-(void)scrollPage;
-(void)noteSubmitExam;
@end
