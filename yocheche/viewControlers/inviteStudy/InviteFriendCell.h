//
//  InviteFriendCell.h
//  yocheche
//
//  Created by carcool on 8/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InviteFriendVC.h"
@interface InviteFriendCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet UILabel *labelCode;
@property(nonatomic,retain)IBOutlet UILabel *labelMoney;
@property(nonatomic,retain)IBOutlet UILabel *labelDesInvite;
@property(nonatomic,retain)IBOutlet UILabel *labelDesNormal;
@property(nonatomic,retain)IBOutlet UILabel *labelDesTotalNormal;
@property(nonatomic,retain)IBOutlet UILabel *labelDesTotalInvite;
@property(nonatomic,retain)IBOutlet UILabel *labelNote;
@property(nonatomic,assign)InviteFriendVC *delegate;
-(void)updateView;
@end
