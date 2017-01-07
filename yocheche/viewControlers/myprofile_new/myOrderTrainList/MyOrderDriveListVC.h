//
//  MyOrderDriveListVC.h
//  yocheche
//
//  Created by carcool on 9/7/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "MyOrderDriveCell.h"
@interface MyOrderDriveListVC : YCCViewController<UIAlertViewDelegate,MyOrderDriveCellDelegate>
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSDictionary *operateData;
-(void)showCommentVC:(NSDictionary*)data;
-(void)cancelOrderDrive:(NSDictionary*)data;
@end
