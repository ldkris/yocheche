//
//  TrainRecordWithFeeCell.h
//  yocheche
//
//  Created by carcool on 3/9/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TrainRecordWithFeeCell;
@protocol TrainRecordWithFeeCellDelegate <NSObject>
-(void)showCommentVC:(NSDictionary *)data;
@end

@interface TrainRecordWithFeeCell : UITableViewCell
@property(nonatomic,assign)id<TrainRecordWithFeeCellDelegate> delegate;
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet UILabel *labelTime;
@property(nonatomic,retain)IBOutlet UILabel *labelState;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UILabel *labelSchool;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *avatar;
@property(nonatomic,assign)IBOutlet UILabel *labelFee;
-(void)updateView;
@end
