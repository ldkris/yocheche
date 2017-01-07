//
//  InputInviteCodeCell0.h
//  yocheche
//
//  Created by carcool on 8/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputInviteCodeVC.h"
@interface InputInviteCodeCell0 : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UITextField *textFieldCode;
@property(nonatomic,assign)InputInviteCodeVC *delegate;
@end
