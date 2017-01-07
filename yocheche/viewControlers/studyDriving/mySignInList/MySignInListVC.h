//
//  MySignInListVC.h
//  yocheche
//
//  Created by carcool on 11/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "MySignInCell.h"
@interface MySignInListVC : YCCViewController<MySignInCellDelegate>
@property(nonatomic,retain)NSMutableArray *m_aryData;
-(void)updateData;
@end
