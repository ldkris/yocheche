//
//  MyTrainAndOrderListVC.h
//  yocheche
//
//  Created by carcool on 11/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "MyOrderDriveCell.h"
@interface MyTrainAndOrderListVC : YCCViewController<UIAlertViewDelegate,MyOrderDriveCellDelegate>
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSDictionary *operateData;
@property(nonatomic,assign)IBOutlet UIView *bottomBG;
@property(nonatomic,assign)IBOutlet UILabel *labelClass2;
@property(nonatomic,assign)IBOutlet UILabel *labelClass3;
@property(nonatomic,assign)IBOutlet UILabel *labelClassTitle;
@property(nonatomic,assign)IBOutlet UILabel *labelClassName2;
@property(nonatomic,assign)IBOutlet UILabel *labelClassName3;
-(void)showCommentVC:(NSDictionary*)data;
-(void)cancelOrderDrive:(NSDictionary*)data;

@end
