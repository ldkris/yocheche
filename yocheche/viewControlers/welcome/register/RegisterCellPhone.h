//
//  RegisterCellPhone.h
//  yocheche
//
//  Created by carcool on 7/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterVC.h"
@interface RegisterCellPhone : UITableViewCell
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,retain)RegisterVC *delegate;
@property(nonatomic,retain)IBOutlet UITextField *textFieldPhone;
@end
