//
//  InputInviteCodeVC.h
//  yocheche
//
//  Created by carcool on 8/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "InputInviteCodeCell1.h"
@interface InputInviteCodeVC : YCCViewController
@property(nonatomic,retain)IBOutlet UIButton *btn;
@property(nonatomic,retain)IBOutlet UIView *bottomView;
@property(nonatomic,retain)InputInviteCodeCell1 *m_inputcell1;
@property(nonatomic,retain)NSString *inviteCode;
-(void)inputDone:(NSString*)str;
@end
