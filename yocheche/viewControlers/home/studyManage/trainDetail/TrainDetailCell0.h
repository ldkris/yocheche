//
//  TrainDetailCell0.h
//  yocheche
//
//  Created by carcool on 2/19/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TrainDetailCell0;
@protocol TrainDetailCell0Delegate <NSObject>
-(void)showCoachDetailVC:(NSString*)coachID;
@end

@interface TrainDetailCell0 : UITableViewCell
@property(nonatomic,assign)id<TrainDetailCell0Delegate> delegate;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet UILabel *labelTime;
@property(nonatomic,retain)IBOutlet UILabel *labelState;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UILabel *labelClassType;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *avatar;
-(void)updateView;
@end
