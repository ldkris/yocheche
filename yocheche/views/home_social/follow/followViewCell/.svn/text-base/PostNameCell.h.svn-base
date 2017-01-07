//
//  PostNameCell.h
//  yocheche
//
//  Created by carcool on 8/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowView.h"
#import "TKRoundedView.h"
@class PostNameCell;
@protocol PostNameCellDelegate <NSObject>
-(void)showOtherCenterVCTappedNameCell:(NSString*)account;
-(void)showMoreOperationMenuSheet;
@end

@interface PostNameCell : UITableViewCell
@property(nonatomic,assign)FollowView *delegate;
@property(nonatomic,retain)NSMutableDictionary *data;
@property(nonatomic,retain)IBOutlet TKRoundedView *contentBG;
@property(nonatomic,retain)IBOutlet UIButton *btnMore;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *avatar;
@property(nonatomic,retain)IBOutlet UILabel *laeblName;
@property(nonatomic,assign)id<PostNameCellDelegate> vcDelegate;
@property(nonatomic,assign)NSInteger selfFlag;
-(void)updateView;
@end
