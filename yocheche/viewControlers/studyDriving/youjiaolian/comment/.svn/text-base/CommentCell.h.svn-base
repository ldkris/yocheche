//
//  CommentCell.h
//  yocheche
//
//  Created by carcool on 8/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentCell;
@protocol CommentCellDelegate <NSObject>
-(void)showOtherCenterVCTappedAvatar:(NSString*)account;
@end

@interface CommentCell : UITableViewCell
@property(nonatomic,assign)id<CommentCellDelegate> delegate;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *avatar;
@property(nonatomic,retain)IBOutlet UILabel *labelContent;
@property(nonatomic,retain)IBOutlet UILabel *labelTime;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,assign)float contentHeight;
@property(nonatomic,retain)IBOutlet UIView *commentBG;
@property(nonatomic,retain)IBOutlet UIView *bottomBG;
@property(nonatomic,retain)IBOutlet UIImageView *imgGood;
@property(nonatomic,retain)IBOutlet UILabel *labelGoodComment;
@property(nonatomic,retain)UIView *tagsBG;
@property(nonatomic,retain)NSMutableArray *m_aryBtns;
-(void)updateView;
-(void)updateViewForOrderDriveComment;
-(void)updateViewForSignInComment;
@end
