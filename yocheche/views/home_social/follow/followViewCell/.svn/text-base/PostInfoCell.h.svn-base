//
//  PostInfoCell.h
//  yocheche
//
//  Created by carcool on 8/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowView.h"
#import "PostInfoCell.h"
#import "TKRoundedView.h"
@class PostInfoCell;
@protocol PostInfoCellDelegate <NSObject>
-(void)likePostOperate:(NSMutableDictionary*)postData postCell:(PostInfoCell*)followCell;
-(void)sharePostDetail:(NSDictionary*)invitationData;
-(void)CommentPostDetail:(NSDictionary*)invitationData;
-(void)ChatPostDetail:(NSDictionary*)invitationData;
@end
@interface PostInfoCell : UITableViewCell
@property(nonatomic,assign)IBOutlet UIView *moreBG;
@property(nonatomic,assign)id<PostInfoCellDelegate> vcDelegate;
@property(nonatomic,assign)FollowView *delegate;
@property(nonatomic,retain)NSMutableDictionary *data;
@property(nonatomic,retain)IBOutlet TKRoundedView *contentBG;
@property(nonatomic,retain)IBOutlet UIImageView *likePostImg;//点赞
@property(nonatomic,assign)IBOutlet UILabel *labelHeatNum;
-(void)updateView;
@end
