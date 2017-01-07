//
//  MyMessageSocialCell.h
//  yocheche
//
//  Created by carcool on 9/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMessagesVC.h"
@interface MyMessageSocialCell : UITableViewCell
@property(nonatomic,assign)MyMessagesVC *delegate;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet UIView *lineView0;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *avatar;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *pic;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UILabel *labelComment;
@property(nonatomic,retain)IBOutlet UILabel *labelTime;
@property(nonatomic,retain)IBOutlet UIImageView *taoxin;
-(void)updateView;
@end
