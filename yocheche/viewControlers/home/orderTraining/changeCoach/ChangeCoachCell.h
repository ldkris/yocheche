//
//  ChangeCoachCell.h
//  yocheche
//
//  Created by carcool on 2/17/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class changeCoachVC;
@interface ChangeCoachCell : UITableViewCell
@property(nonatomic,assign)IBOutlet UIButton *btnOrder;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,assign)IBOutlet WebImageViewNormal *avatar;
@property(nonatomic,assign)IBOutlet UILabel *labelName;
@property(nonatomic,assign)IBOutlet UILabel *labelInfo;
@property(nonatomic,assign)IBOutlet UIView *contentBG;
@property(nonatomic,assign)changeCoachVC *delegate;
-(void)updateView;
@end
