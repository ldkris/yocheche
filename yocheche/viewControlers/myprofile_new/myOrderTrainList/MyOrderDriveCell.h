//
//  MyOrderDriveCell.h
//  yocheche
//
//  Created by carcool on 9/7/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MyOrderDriveCell;
@protocol MyOrderDriveCellDelegate <NSObject>
-(void)cancelOrderDrive:(NSDictionary*)data;
-(void)showCommentVC:(NSDictionary *)data;
@end

@interface MyOrderDriveCell : UITableViewCell
@property(nonatomic,assign)id<MyOrderDriveCellDelegate> delegate;
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet UILabel *labelTime;
@property(nonatomic,retain)IBOutlet UILabel *labelState;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UILabel *labelClassType;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *avatar;
-(void)updateView;
@end
