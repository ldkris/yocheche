//
//  FollowListCell.h
//  yocheche
//
//  Created by carcool on 8/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FollowListCell;

@protocol FollowListCellDelegate <NSObject>
-(void)followTheAccount:(NSString*)account followCell:(FollowListCell*)followCell type:(NSString*)followType;
@end

@interface FollowListCell : UITableViewCell
@property(nonatomic,retain)NSMutableDictionary *data;
@property(nonatomic,retain)IBOutlet UIView *lineView0;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *avatar;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UILabel *labelDescription;
@property(nonatomic,retain)IBOutlet UIButton *btnFollow;
@property(nonatomic,retain)NSString *followType;
@property(nonatomic,assign)id<FollowListCellDelegate> vcDelegate;
-(void)updateView;
@end
