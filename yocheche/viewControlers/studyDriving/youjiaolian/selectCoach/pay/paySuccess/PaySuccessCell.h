//
//  PaySuccessCell.h
//  yocheche
//
//  Created by carcool on 8/23/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaySuccessVC.h"
@interface PaySuccessCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UILabel *labelSchoolAndCoach;
@property(nonatomic,retain)IBOutlet UILabel *labelNewFee;
@property(nonatomic,retain)IBOutlet UILabel *labelOldFee;
@property(nonatomic,retain)NSDictionary *data;
-(void)updateView;
@end
