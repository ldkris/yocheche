//
//  RegisterCellVerify.h
//  yocheche
//
//  Created by carcool on 7/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterVC.h"
@interface RegisterCellVerify : UITableViewCell
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,retain)RegisterVC *delegate;
@property(nonatomic,retain)IBOutlet UITextField *textFieldVerify;
@property(nonatomic,assign)NSInteger time;
@property(nonatomic,retain)IBOutlet UILabel *labelSendVerify;
@end
