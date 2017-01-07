//
//  OfficialNotifyCell.h
//  yocheche
//
//  Created by carcool on 8/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfficialNotifyCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet UILabel *labelTitle;
@property(nonatomic,retain)IBOutlet UILabel *labelTime;
@property(nonatomic,retain)UILabel *labelContent;
-(void)updateView;
@end
