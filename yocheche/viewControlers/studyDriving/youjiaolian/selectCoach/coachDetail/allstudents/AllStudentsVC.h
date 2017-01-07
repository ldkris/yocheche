//
//  AllStudentsVC.h
//  yocheche
//
//  Created by carcool on 9/30/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "CoachDetailVC.h"
@interface AllStudentsVC : YCCViewController
@property(nonatomic,assign)CoachDetailVC *delegate;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@end
