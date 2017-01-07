//
//  SignInDetailTopCell.h
//  yocheche
//
//  Created by carcool on 11/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SignInDetailTopCell;
@protocol SignInDetailTopCellDelegate <NSObject>
-(void)showCoachDetailVC:(NSString*)coachID;
@end

@interface SignInDetailTopCell : UITableViewCell
@property(nonatomic,assign)id<SignInDetailTopCellDelegate> delegate;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)NSDictionary *preData;
@property(nonatomic,retain)IBOutlet UILabel *labelTime;
@property(nonatomic,retain)IBOutlet UILabel *labelState;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UILabel *labelClassType;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *avatar;
-(void)updateView;
@end
