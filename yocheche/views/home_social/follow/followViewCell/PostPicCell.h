//
//  PostPicCell.h
//  yocheche
//
//  Created by carcool on 8/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowView.h"
@class PostDeatilVC;

@class PostPicCell;
@protocol PostPicCellDelegate <NSObject>
-(void)showScreenView:(UIImage*)img;
@end

@interface PostPicCell : UITableViewCell
@property(nonatomic,assign)PostDeatilVC *detailDelegate;
@property(nonatomic,assign)id<PostPicCellDelegate> imgDelegate;
@property(nonatomic,assign)FollowView *delegate;
@property(nonatomic,retain)NSMutableDictionary *data;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *pic;
@property(nonatomic,retain)IBOutlet UIButton *btn;
@property(nonatomic,assign)NSInteger typeFlag;//1:detail pic
@property(nonatomic,retain)IBOutlet UIView *contentBG;
-(void)updateView;
@end
