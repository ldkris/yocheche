//
//  CoachDetailCell1.h
//  yocheche
//
//  Created by carcool on 8/4/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoachDetailVC.h"
@interface CoachDetailCell1 : UITableViewCell
@property(nonatomic,assign)CoachDetailVC *delegate;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet UILabel *labelPrice;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,assign)NSInteger feeIndex;
-(void)updateViews;
@end
