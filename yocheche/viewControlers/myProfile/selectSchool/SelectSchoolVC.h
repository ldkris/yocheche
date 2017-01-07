//
//  SelectSchoolVC.h
//  yocheche
//
//  Created by carcool on 8/14/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "MyInfoVC.h"
@interface SelectSchoolVC : YCCViewController
@property(nonatomic,retain)NSMutableArray *m_aryProvince;
@property(nonatomic,retain)NSMutableArray *m_arySchool;
@property(nonatomic,assign)NSInteger selectType;//0:province 1:school
@property(nonatomic,assign)MyInfoVC *delegate;
@end
