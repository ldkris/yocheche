//
//  MySignInCell.h
//  yocheche
//
//  Created by carcool on 11/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MySignInCell;
@protocol MySignInCellDelegate <NSObject>
-(void)showCommentVC:(NSDictionary *)data;
@end

@interface MySignInCell : UITableViewCell
@property(nonatomic,assign)id<MySignInCellDelegate> delegate;
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet UILabel *labelTime;
@property(nonatomic,retain)IBOutlet UILabel *labelState;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UILabel *labelClassType;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *avatar;
-(void)updateView;

@end
