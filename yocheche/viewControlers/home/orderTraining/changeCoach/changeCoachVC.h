//
//  changeCoachVC.h
//  yocheche
//
//  Created by carcool on 2/15/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface changeCoachVC : YCCViewController
@property(nonatomic,retain)NSString *coachid;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,assign)IBOutlet UILabel *labelCoachNum;
-(void)bundleCoach:(NSString*)bundleid;
@end
