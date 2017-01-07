//
//  ConfirmOrderVC.h
//  yocheche
//
//  Created by carcool on 9/14/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface ConfirmOrderVC : YCCViewController<UIAlertViewDelegate>
@property(nonatomic,retain)IBOutlet UIButton *btn;
@property(nonatomic,retain)NSMutableArray *m_arySelectedTime;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSDictionary *currentCoachData;
@property(nonatomic,retain)NSMutableString *strTime;
@property(nonatomic,assign)float contentHeight;
@end
