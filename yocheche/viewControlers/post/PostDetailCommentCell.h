//
//  PostDetailCommentCell.h
//  yocheche
//
//  Created by carcool on 8/17/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PostDeatilVC;
@interface PostDetailCommentCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *avatar;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UILabel *labelTime;
@property(nonatomic,retain)IBOutlet UILabel *labelComment;
@property(nonatomic,retain)TKRoundedView *contentBG;
@property(nonatomic,assign)NSInteger isLastOne;
@property(nonatomic,assign)PostDeatilVC *delegate;
-(void)updateView;
@end
