//
//  OrderTrainDriveVC.h
//  yocheche
//
//  Created by carcool on 9/4/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "OrderTrainDriveCell.h"
@interface OrderTrainDriveVC : YCCViewController<UIAlertViewDelegate>
@property(nonatomic,retain)IBOutlet UIButton *btn;
@property(nonatomic,assign)NSInteger selectedCoach;//coach
@property(nonatomic,assign)NSInteger selectedDay;//day
@property(nonatomic,retain)NSMutableArray *m_arySelectedTime;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSMutableArray *m_aryCoach;
@property(nonatomic,retain)NSDictionary *currentCoachData;
@property(nonatomic,retain)OrderTrainDriveCell *m_orderDriveCell;
@property(nonatomic,retain)IBOutlet UIView *studentItemViewBG;
@property(nonatomic,assign)IBOutlet UIView *lineViewBG;
@property(nonatomic,assign)IBOutlet UILabel *labelTitle;
@property(nonatomic,retain)NSMutableArray *m_aryStudentView;
-(void)showBundleCoachVC:(NSString*)type;
-(void)updateDateAndTime:(NSDictionary*)coachData;
-(void)cancelBundleCoach:(NSDictionary*)dic type:(NSString*)coachtype;
-(void)showAllOrderedStudent:(NSArray*)students;
-(void)showStudentDetailVC:(NSString*)account;
@end
