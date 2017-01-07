//
//  OrderTrainingVC.h
//  yocheche
//
//  Created by carcool on 2/4/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface OrderTrainingVC : YCCViewController<UIAlertViewDelegate>
@property(nonatomic,retain)IBOutlet UIButton *btn;
@property(nonatomic,assign)NSInteger type;//0:no coach 1:have coach
@property(nonatomic,retain)NSDictionary *coachData;
@property(nonatomic,retain)NSMutableArray *m_aryTimes;
@property(nonatomic,retain)NSMutableArray *m_aryDay1;
@property(nonatomic,retain)NSMutableArray *m_aryDay2;
@property(nonatomic,retain)NSMutableArray *m_aryDay3;
@property(nonatomic,retain)NSMutableArray *m_aryDay4;
@property(nonatomic,retain)NSMutableArray *m_aryDay5;
@property(nonatomic,retain)NSMutableArray *m_arySelectedDay;
@property(nonatomic,assign)NSInteger selectedDay;

@property(nonatomic,retain)IBOutlet UIView *studentItemViewBG;
@property(nonatomic,assign)IBOutlet UIView *lineViewBG;
@property(nonatomic,assign)IBOutlet UILabel *labelTitle;
@property(nonatomic,retain)NSMutableArray *m_aryStudentView;
@property(nonatomic,assign)NSInteger notUpdate;
-(void)showAddCoachVC;
-(void)showChangeCoachVC;
-(void)showAllOrderedStudent:(NSArray *)students;
-(void)showStudentDetailVC:(NSString*)account;
@end
