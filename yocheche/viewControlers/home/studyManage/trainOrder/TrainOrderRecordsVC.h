//
//  TrainOrdersVC.h
//  yocheche
//
//  Created by carcool on 2/15/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"
//#import "MyOrderDriveCell.h"
#import "OrderRecordCell.h"
#import "TrainRecordCell.h"
#import "TrainRecordWithFeeCell.h"
@interface TrainOrderRecordsVC : YCCViewController<UIAlertViewDelegate,OrderRecordCellDelegate,TrainRecordCellDelegate,TrainRecordWithFeeCellDelegate>
@property(nonatomic,retain)IBOutlet UIView *topbg;
@property(nonatomic,retain)UIView *topLineView;
@property(nonatomic,retain)IBOutlet UILabel *labelOrder;
@property(nonatomic,retain)IBOutlet UILabel *labelRecord;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSDictionary *operateData;
@property(nonatomic,assign)NSInteger type;//0:预约记录 1:练车记录
-(void)showCommentVC:(NSDictionary*)data;
-(void)cancelOrderDrive:(NSDictionary*)data;

@end
