//
//  SchoolDetailCell3.h
//  yocheche
//
//  Created by carcool on 12/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolDetailCell3 : UITableViewCell
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,assign)IBOutlet UIView *lineView2;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,assign)IBOutlet UILabel *labelTotal;
@property(nonatomic,assign)IBOutlet UILabel *labelLook;
@property(nonatomic,assign)IBOutlet WebImageViewNormal *avatar1;
@property(nonatomic,assign)IBOutlet WebImageViewNormal *avatar2;
@property(nonatomic,assign)IBOutlet WebImageViewNormal *avatar3;
@property(nonatomic,retain)NSMutableArray *m_aryAvatar;
-(void)updateView;
@end
